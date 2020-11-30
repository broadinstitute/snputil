function idx=find_D_cols(D,supacc_name,val)

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)


supid=strmatch(supacc_name,regexprep(cellstr(D.supacc),':.*',''),'exact');
if length(supid)~=1
  error([ mfilename  ': non-unique or non-valid id']);
end
idx=find(D.supdat(supid,:)==val);
