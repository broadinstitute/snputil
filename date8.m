function str8 = date8(timestamp)
%DATE8 create 8-digit date string for current time
if ~exist('timestamp','var') || isempty(timestamp)
    timestamp = now;
end
dv = datevec(timestamp);
str8 = sprintf('%4d%02d%02d',dv(1:3));
