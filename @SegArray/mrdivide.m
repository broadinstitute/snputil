function Q = mrdivide(A,B)
% MRDIVIDE SegArray implementation of matrix division
%    emulates normal behavior of MRDIVIDE
%    returns a full array unless divisor is scalar

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    % convert arguments to full arrays
    warnmsg = 'converting to full array for matrix multiplication';
    if ~isscalar(B) & isa(A,'SegArray')
        segwarn(A,warnmsg);
        A = full(A);
    end
    if isa(B,'SegArray')
        B = full(B);
    end

    if isscalar(A) && isscalar(B)
        Q = full(A)*B;
    elseif isa(A,'SegArray')
        Q = SegArray;
        Q.bpts = A.bpts;
        Q.vals = A.vals / full(B);
    else
        % perform normal matrix multiplication
        try
            Q = A / B;
        catch me
            throwAsCaller(me);
        end
    end
end
