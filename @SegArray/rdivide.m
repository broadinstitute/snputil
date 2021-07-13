%RDIVIDE overloaded arraywise SEGARRAY right division ( ./ )

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function C = rdivide(A,B)
C = binary(A,B,@rdivide);
