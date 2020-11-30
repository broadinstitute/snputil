function n=line_count(fname)


% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

n=0;
if ispc
    sz=5000000;
else
    sz=250000000;
end
f=fopen(fname,'r');
a=zeros(sz,1);
if f>0
  while ~feof(f)
    [a,count]=fread(f,sz,'uchar');
    n=n+length(find(a==10));
  end
  verbose(['... ' num2str(n) ' lines read (line_count.m)'],30)
else
  error(['File not found: ' fname]);
end
fclose(f);
