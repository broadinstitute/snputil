% SEGARRAY pass through implementation of NUMEL

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

function varargout = numel(S, varargin)
    try
        [varargout{1:nargout}] = numel(S.bpts, varargin{:});
    catch me
        throwAsCaller(me);
    end
end

