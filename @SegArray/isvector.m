%    SegArray implementation of ISVECTOR
%    B = ISVECTOR(A)
%    emulates normal behavior of ISVECTOR
%    (see HELP ISVECTOR for details)

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function B = isvector(A)
    try
        B = isvector(A.bpts); % queries shape
    catch me
        throwAsCaller(me);
    end
end
