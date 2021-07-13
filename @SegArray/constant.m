function S = constant(val,M,N)
% create a SegArray with all values the same

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    if ~isscalar(val)
        throwAsCaller(MException('MATLAB:SEGARRAY:notScalar',...
                                 'First input must be scalar'));
    end
    if ~exist('M','var')
        M = 1;
    end
    if isempty(M)
        M = 0;
    end
    if ~exist('N','var')
        if isscalar(M)
            N = M;
        else
            N = M(2);
            M = M(1);
        end
    end
    if isempty(N)
        N = 0;
    end
    S = SegArray;
    if M ~= 0
        S.vals = repmat(val,N,1);
        S.bpts = sparse(ones(1,N),1:N,1:N,M,N);
    else
        S.vals = [];
        S.bpts = sparse([],[],[],M,N);
    end
