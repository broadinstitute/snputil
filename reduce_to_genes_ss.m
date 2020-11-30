function G = reduce_to_genes_ss(D,rg,rg_field,options)
% REDUCE_TO_GENES Convert SNP copy number data to gene level data
%
%   G = reduce_to_genes(D,RG,RG_FIELD,options)
%
%   Converts SNP-level copy number data in D to gene level copy data in G
%   using the reference genome in structure array RG. RG_FIELD is a string
%   specifying the field in RG to use as a gene identifier, default 'symb'.
%   OPTIONS is a struct whose fields are optional parameters:
%       OPTIONS.collapse_method can be 'all' (default), 'mean', 'median',
%               'min', 'max', or 'extreme'
%       OPTIONS.find_snps_type is the type argument passed to find_snps
%               0 for SNP markers strictly contained in the gene region
%               1 to allow flanking SNPS if none are strictly contained
%               2 to always use flanking SNPS
%

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    if ~exist('options','var')
        options = struct;
    end
    if ~isfield(options,'collapse_method')
        options.collapse_method = 'mean';
    end
    if ~isfield(options,'find_snps_type')
        options.find_snps_type = 1;
    end
    if ~exist('rg_field','var') || isempty(rg_field)
        rg_field = 'symb';
    end

    %%%%%%
    % loop over unique chromosomes in the data
    verbose('reduce_to_genes: calculating gene footprints',30);
    uchrn = unique(D.chrn);
%!  rg = rg(ismember([rg.chrn],uchrn));
    % loop over each chromosome we have data for
%!  footprint = cell(size(rg));
    lo_snp = nan(size(rg));
    hi_snp = nan(size(rg));
    for i = 1:length(uchrn)
        c = uchrn(i);
        verbose('chromosome %d',30,c);
        gonc = find([rg.chrn]==c);
        rgc = rg(gonc);
        cbase = find(D.chrn==c,1,'first')-1;
        cpos = D.pos(D.chrn==c);
        % find bounding markers, method depending on options.find_snps_type
        if options.find_snps_type < 2
            % find inner marker boundaries
            st = marker_above(cpos,[rgc.start]);
            en = marker_below(cpos,[rgc.end]);
            % find empty inner boundaries
            need_flanks = st > en;
            if options.find_snps_type == 1
                % use outer markers for empty inner boundaries
                st(need_flanks) = marker_below(cpos,[rgc(need_flanks).start]);
                en(need_flanks) = marker_above(cpos,[rgc(need_flanks).end]);
            else % options.find_snps_type == 0
                % eliminate genes without coverage
                st(need_flanks) = [];
                en(need_flanks) = [];
                gonc(need_flanks) = [];
            end
        else % options.find_snps_type == 2
            % use outer markers always
            st = marker_below(cpos,[rgc.start]);
            en = marker_above(cpos,[rgc.end]);            
        end
        lo_snp(gonc) = cbase+st;
        hi_snp(gonc) = cbase+en;
    end % loop over each chromosome
 
    % remove genes which do not map to D-struct
    genes2keep = ~isnan(lo_snp) & ~isnan(hi_snp);
    rgi = 1:length(rg);
    rg = rg(genes2keep);
    rgi = rgi(genes2keep);
    lo_snp = lo_snp(genes2keep);
    hi_snp = hi_snp(genes2keep);

    verbose('reduce_to_genes: merging gene isoforms',30);
    % compress genes with same identifier in reference genome 
    ids_chr = strcat({rg.(rg_field)},'|chr',num2chromosome([rg.chrn]));
    [uqids,ui,oi] = unique(ids_chr);
    
    % leave '|chrN' for genes that occur on multiple chromosomes
    ids = {rg(ui).(rg_field)};
    unids = unique(ids);
    [~,x1,x2] = match_string_sets_hash(ids,unids);
    mm = sparse(x2,x1,1);
    dup_chr = full(sum(mm,2)) > 1;
    unique_chr = ~(dup_chr'*mm);
    uqids(unique_chr) = ids(unique_chr);
    
    [~,m1,m2] = match_string_sets_hash(uqids(oi),uqids); %!
    gmatch = sparse(m1,m2,true);
    % m1 indexes ids
    % m2 corresponds ids, indexes uqids
    
    % create mapping from compresssed reference genome to snps
    usize = [length(uqids) 1];
    snps = cell(usize);    % cell array of snp positions
    low_marker = Inf(usize);
    high_marker = zeros(usize);
    rgindex = cell(usize); % cell array of reference genome indices
    chrn = zeros(usize);   % chromosome (NaN if ambiguous)
    g_start = Inf(usize);  % minimum gene start
    g_end = zeros(usize);  % maximum gene end

    % loop over unique gene IDs
    tic;
    for ag = 1:length(uqids)
        if mod(ag,1000)==0
            verbose('reduce_to_genes: defining gene %d of %d',30,ag,length(uqids));
        end
        matches = find(gmatch(:,ag));
        rgindex{ag} = rgi(matches); % keep track of what was compressed
        if ~isempty(matches)
            % loop over all matches to unique gene ID
            for k = matches'
                g_start(ag) = min(g_start(ag),rg(k).start);
                g_end(ag) = max(g_end(ag),rg(k).end);
                if chrn(ag) == 0
                    chrn(ag) = rg(k).chrn;
                elseif chrn(ag) ~= rg(k).chrn;
                    %!!! this should no longer happen now that we give genes
                    %!!! on different chromosomes distinct identifiers
                    assert(false);
 %!                 verbose('Conflicting chromosomes (%d and %d) for gene %s !',30, ...
 %!                             chrn(ag),rg(k).chrn,rg(k).(rg_field));
 %!                 chrn(ag) = min(chrn(ag),rg(k).chrn);
                end
                
                % expand marker boundaries to enclose the isoform 
                low_marker(ag) = min(low_marker(ag),lo_snp(k));
                high_marker(ag) = max(high_marker(ag),hi_snp(k));
                %{
                if g_end(ag) > g_start(ag) && ~isnan(chrn(ag))
                    % combine markers for the same gene
                    if isfield(rg,'snps')
                        snps{ag} = union(snps{ag},rg(k).snps);
                    else
                        snps{ag} = union(snps{ag},find_snps(D,chrn(ag),...
                                     g_start(ag),g_end(ag),options.find_snps_type));
                    end
                else
                    verbose('Bad gene data for %s !',30, ...
                            rg(k).(rg_field));
                end
                %}
            end % loop over matches
            snps{ag} = low_marker(ag):high_marker(ag);
        end
    end
    
    % create index for compressing/ordering genes/snps
%!  low_marker = cellfun(@(s) s(1),snps);
    [low_marker,order] = sort(low_marker);
    snps = snps(order);
    high_marker = high_marker(order);
%{
    % create array of logical SegArrays for fast indexing
    segmat = SegArray.fromSegments(low_marker,high_marker,1:length(snps),true,false,length(D.pos));
(unfortunately, it wasn't so fast)
%}    
    % create output struct by removing matrix fields
    matrix_fields = {'dat','orig','cbs','affy_calls'}; % TODO add more?
    if isfield(D,'matrix_fields')
        matrix_fields = unique([matrix_fields D.matrix_fields]);
    end
    G = rmfield_if_exists(D,matrix_fields);
    % remove some other fields we won't need
    G = rmfield_if_exists(G,{'marker','chr','pos','cM', ...
                            'score','cbs_rl','orig', ...
                            'history','origidx','gorigidx',...
                            'medians','Qs'});
    % collapse G rows from snp to gene size 
    G = reorder_D_rows(G,low_marker);
    % add some gene fields
    G = add_D_field(G,'gene',{'gdesc','snps','rgindex','chrn',...
                               'gstart','gend'});
    G.gdesc = uqids(order)'; %! achilles: geneID
    G.snps = snps;
    G.rgindex = rgindex(order);
    G.chrn = chrn(order);
    G.gstart = g_start(order); %! achilles: gene_start
    G.gend = g_end(order);     %! achilles: gene_end
    G.collapse_settings = options;

    %% collapse copy number data
    verbose('reduce_to_genes: collapsing markers to genes',30);
    % loop across all copy number matrix fields in D
    for field = matrix_fields
        fld = char(field);
        if isfield(D,fld)
            % add empty matrix field
            G.(fld) = nan(length(snps),size(D.(fld),2));
            % loop over genes
            for i = 1:length(snps)
                if mod(i,100)==0
                    verbose('reduce_to_genes: reducing gene %d of %d',30,i,length(snps));
                    toc
                end
                % compress markers to current gene
                switch options.collapse_method
                    case 'mean'
                        G.(fld)(i,:) = mean(D.(fld)(snps{i},:),1);
%!                      G.(fld)(i,:) = mean(D.(fld)(segmat(:,i),:),1);
                    case 'median'
                        G.(fld)(i,:) = median(D.(fld)(snps{i},:),1);
%!                      G.(fld)(i,:) = median(D.(fld)(segmat(:,i),:),1);
                    case 'min'
                        G.(fld)(i,:) = min(D.(fld)(snps{i},:),[],1);
%!                      G.(fld)(i,:) = min(D.(fld)(segmat(:,i),:),[],1);
                    case 'max'
                        G.(fld)(i,:) = max(D.(fld)(snps{i},:),[],1);
%!                      G.(fld)(i,:) = max(D.(fld)(segmat(:,i),:),[],1);
                    case 'extreme'
                        min_val = min(D.(fld)(snps{i},:),[],1);
                        max_val = max(D.(fld)(snps{i},:),[],1);
%! twice as slow!                       
%!                      min_val = min(D.(fld)(segmat(:,i),:),[],1);
%!                      max_val = max(D.(fld)(segmat(:,i),:),[],1);
                        vals = [min_val; max_val];
                        [~,mi] = max(abs(vals));
                        v = zeros(1,length(min_val));
                        v(mi==1) = min_val(mi==1);
                        v(mi==2) = max_val(mi==2);
                        G.(fld)(i,:) = v;
                end
            end % loop over genes
        end
    end % loop over matrix fields

