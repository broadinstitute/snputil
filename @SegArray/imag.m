%    SegArray implementation of IMAG.
%    B = IMAG(A)
%    Emulates full array behavior of IMAG; returns a SegArray.
%    (use HELP IMAG for details)

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function B = imag(A)
% (code generated by unarray.pl)
B = A;
try
    B.vals = imag(A.vals);
catch me
    throwAsCaller(me);
end
