function R = all(S,dim)
%ALL - overloaded ALL (AND summary) for SegArray
%
%   R = ALL(S)
%   R = ALL(S,DIM)
%
% Return value is a full row vector if DIM = 1, 
% a SegArray column vector if DIM = 2 and S is 
% not a row vector.

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    [M N] = size(S.bpts);
    
    if ~exist('dim','var') || isempty(dim)
        if M || N
            dim = find(size(S)~=1,1);
            % if scalar operand, return non-SegArray result
            if isempty(dim)
                R = logical(full(S));
                return
            end
        else
            % all([]) is true
            R = true;
            return
        end
    end

    if dim == 1 %% compress across rows ("against the grain")
        if isempty(S.bpts)
            R = zeros(1,N);
        else
            % optimize row and column vectors
            if M == 1
                R = logical(S.vals)';
            elseif N == 1
                R = all(S.vals);
            else
                % Testing "with the grain" for all nonzeros
                [~,J] = find(S.bpts);
                R = accumarray(J(:),logical(S.vals),[N 1],@all,false,false)';
            end
        end
    
    elseif dim == 2 %% compress across rows ("against the grain")
        if isempty(S.bpts)
            R = zeros(M,1);
        else
            R = crossgrain(S,@(x) all(x,2));
        end
    else
        R = logical(S);
    end

