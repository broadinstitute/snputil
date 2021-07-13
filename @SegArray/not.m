%    SegArray implementation of NOT.
%    B = NOT(A)
%    Emulates full array behavior of NOT; returns a SegArray.
%    (use HELP NOT for details)

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function B = not(A)
% (code generated by unarray.pl)
B = A;
try
    B.vals = not(A.vals);
catch me
    throwAsCaller(me);
end
