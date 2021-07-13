function errNoError(S)
% generate an error to indicate error handler failure

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    throwAsCaller(MException('MATLAB:SEGARRAY:nongenException',... 
                             'Attempt to generate exception with MATLAB failed.'));
end
