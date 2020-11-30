function d=find_dlm(fname,dlm)
% find delimiter

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

if ~exist('dlm','var') || isempty(dlm)
  dlm=[ char(9) ',|'];
end

f=fopen(fname,'r');
l=fgetl(f);
for i=1:length(dlm)
  h(i)=length(find(l==dlm(i)));
end
[hm,hi]=max(h);
d=dlm(hi);
