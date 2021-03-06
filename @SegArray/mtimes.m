%TIMES overloaded element-by-element seg array multiplication

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function C = mtimes(A,B)
if isscalar(A) || isscalar(B)
    C = binary(A,B,@times);
else
    throwAsCaller(MException('Matlab:SegArray:Unsupported',...
               'Matrix multiplication of two SegArrays is not supported.'));
end




   
       
