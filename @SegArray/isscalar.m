%    SegArray implementation of ISSCALAR
%    B = ISSCALAR(A)
%    emulates normal behavior of ISSCALAR
%    (see HELP ISSCALAR for details)

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function TF = isscalar(A)
    try
        TF = isscalar(A.bpts); % queries shape
        if TF
            segwarn(A,'Scalar SegArray allowed to exist!');
        end 
    catch me
        throwAsCaller(me);
    end
end
