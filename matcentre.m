function [dirmean] = matcentre(chroma_mar, i, j)
%MATCENTRE the intermediate process of chroma enhancement

kernel = zeros(5,5);
dirmean = zeros(6,1);
len = length(chroma_mar);

for m = -2:2
    for n = -2:2
        if i+m<=0 || i+m>len || j+n<=0 || j+n>len
            continue;
        end
        kernel(m+3,n+3) = chroma_mar(i+m,j+n);
    end
end

%Six directional local mean values are calculated along the upper-left, 
%lower-right, right, left, upper, and lower dimensions of the kernel

dirmean(1) = mean([kernel(1,1),kernel(2,2)]);
dirmean(2) = mean([kernel(4,4),kernel(5,5)]);
dirmean(3) = mean([kernel(3,4),kernel(3,5)]);
dirmean(4) = mean([kernel(3,1),kernel(3,2)]);
dirmean(5) = mean([kernel(1,3),kernel(2,3)]);
dirmean(6) = mean([kernel(4,3),kernel(5,3)]);

end

