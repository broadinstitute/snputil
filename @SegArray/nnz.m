function nz = nnz(S)
%NNZ SegArray number of nonzero elements

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    brks = find(S.bpts); 
    nz = (S.vals ~= 0)' * diff([ brks(:); numel(S.bpts)+1 ]);
