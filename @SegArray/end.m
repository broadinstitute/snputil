% SEGARRAY implementation of END

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function ind = end(S,k,n)
    siz = size(S.bpts);
    if k < n
        ind = siz(k);
    else
        ind = prod(siz(k:end));
    end
end
