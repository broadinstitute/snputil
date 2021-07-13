%% COMPRESSION_FACTOR returns the ratio of segment points to breakpoints in a SEGARRAY 

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function compression_factor = get_compression_factor(S)
    compression_factor = numel(S.bpts)/nnz(S.bpts);
end
