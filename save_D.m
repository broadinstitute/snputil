function save_D(fname,D,v)
% save a D-struct to a file

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

if isfield(D,'marker') && iscell(D.marker)
%   D.marker=strvcat(D.marker);
    D.marker=char(D.marker);
end

if isfield(D,'chr') && iscell(D.chr)
%  D.chr=strvcat(D.chr);
  D.chr=char(D.chr);
end

if isfield(D,'sdesc') && iscell(D.sdesc)
%  D.sdesc=strvcat(D.sdesc);
  D.sdesc=char(D.sdesc);
end

if exist('v','var')
  save(fname,'D',v);
else
  save(fname,'D');
end
