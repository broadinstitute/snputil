function D=add_history(D,varargin)
%ADD_HISTORY Add data processing history to D struct.
%
%D = ADD_HISTORY(D,VARARGIN) returns data structure D with cell appended to
%.history field specifying date and any additional parameters given in
%varargin.  Typical usage: add_history(D,mfilename,varargin);
%
% use stack instead of mfilename
% call in beginning and end of a function so it is like ( (())() )
% if we use the stack we don't need to run twice.
%

% GISTIC software version 2.0
% Copyright (c) 2011-2017 Gad Getz, Rameen Beroukhim, Craig Mermel,
% Jen Dobson, Steve Schumacher, Nico Stransky, Mike Lawrence, Gordon Saksena
% All Rights Reserved.
% (See the accompanying LICENSE file for licensing details.)

if ~isfield(D,'suppress_history') || isempty(D.suppress_history) || ~D.suppress_history 
    if isfield(D,'history')
        % add to history
        D.history{end+1}={ datestr(clock) varargin{:}};
    else
        % create first historical record
        D.history{1}={ datestr(clock) varargin{:}};
        if isfield(D,'dat')
            % back up dat before last operation
            D.orig=D.dat;
            D.origidx=1:size(D.dat,2);
            D.gorigidx=1:size(D.dat,1);
        end
    end
end

