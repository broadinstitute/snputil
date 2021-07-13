function varargout = imagesc(varargin)
% SegArray implementation of IMAGESC converts arguments to full

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    varargin = cellfun(@full,varargin,'UniformOutput',false);
    segwarn(SegArray,'converting SegArray to full for IMAGESC operation');
    try
        [varargout{1:nargout}] = imagesc(varargin{:});
    catch me
        throwAsCaller(me);
    end
end
