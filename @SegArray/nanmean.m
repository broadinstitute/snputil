function y = nanmean(x,dim)
% OVERLOADED nanmean function for SegArray object.

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

if nargin == 1
    dim = min(find(size(x) ~=1));
end

if isempty(dim)
    dim = 1;
end

y = nansum(x,dim)./sum(~isnan(x),dim);

