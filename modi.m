function modi(i,n)
  % Simple function which tests if i==0 mod n, and if so, displays i

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    if ~exist('n','var') || isempty(n)
      n=1;
    end
    
    if mod(i,n) == 0
      disp(i)
    end
