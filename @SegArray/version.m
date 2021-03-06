function vertext = version
% VERSION static method to return SegArray version string
%   Returns a string of the form '<major>.<minor>.<revision>'
%   where <maj> is the major version, <min> is the minor version,
%   and <revision> is the subversion revision of the last check-in.

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

    revstring = '$Revision: 86560 $'; % modified by subversion
    verstring = '1.10'; % modify this manually
    vertext = [verstring '.' regexprep(revstring,'\$Revision[:\s]*([0-9.]+)\s*\$','$1')];
