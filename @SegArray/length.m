function L = length(S)
% SEGARRAY pass-through implementation of SIZE
%

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    try
        L = length(S.bpts);
    catch me
        throwAsCaller(me);
    end
