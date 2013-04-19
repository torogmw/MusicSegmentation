function [timegroup] = bts2time(seggroup, bts)
%BTS2TIME convert bts to time

[m, n] = size(seggroup);
timegroup = bts(seggroup);

end

