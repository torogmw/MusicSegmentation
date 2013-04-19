function [ftr] = delete0(ftr)
%DELETE0 delete the 0 vector at the end of matrix ftr

[m, n] = size(ftr);           
i = n;
while norm(ftr(:, i)) == 0
    i = i-1;
end

for j = 0:n-i-1
    ftr(:, n-j) = [];
end

end

