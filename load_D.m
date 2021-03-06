function D=load_D(fname,varname)
% load a D-struct from a file

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

if exist('varname','var')
  D=load(fname,varname);
else
  tmp=load(fname);
end

nms=fieldnames(tmp);
D=getfield(tmp,nms{1});

if isfield(D,'marker') && ischar(D.marker)
  D.marker=cellstr(D.marker);
end

if isfield(D,'chr') && ischar(D.chr)
  D.chr=cellstr(D.chr);
end

if isfield(D,'sdesc') && ischar(D.sdesc)
  D.sdesc=cellstr(D.sdesc);
end
