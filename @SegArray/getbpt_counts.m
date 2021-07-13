function nbpts = getbpt_counts(S)
%GETBPT_COLS get breakpoint counts (per column)
%
%   NBPTS = GETBPT_COUNTS(S) returns a row vector of breakpoint
%   (segment) counts for each column in the SegArray object S. 
%   

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    nbpts = ones(1,size(S.bpts,2));
    for col = 1:length(nbpts)
        nbpts(col) = nnz(S.bpts(:,col));
    end
