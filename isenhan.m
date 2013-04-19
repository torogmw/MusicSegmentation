function [enhanflg] = isenhan( kernel )
%ISENHAN Determine whether kernel should be enhanced
%   Detailed explanation goes here

len = length(kernel);
count = 0;

for i = 1:len
    if kernel(i) == 1
        count = count+1;
    end
end

if count/len >= 0.65 && (kernel(len-1) == 1 || kernel(len) == 1)
    enhanflg = 1;
else
    enhanflg = 0;
end
end

