function [ chromhance_mar ] = chromenhance(chroma_mar, debug)
%CHROMENHANCE enhance the chroma feature

if nargin < 2
    debug = 0;
end

[m,n] = size(chroma_mar);
chromhance_mar = zeros(m,n);
for i = 1:length(chroma_mar)
    for j = 1:i
        dirmean = matcentre(chroma_mar, i, j);
        if min(dirmean) == dirmean(1) || min(dirmean) == dirmean(2)
            chromhance_mar(i,j) = chroma_mar(i,j)+min(dirmean);
        else
            chromhance_mar(i,j) = chroma_mar(i,j)+max(dirmean);
        end
    end
end
        
if debug ~= 0; 
    figure; imshow(mat2gray(chromhance_mar)); title('chroma SDM - after enhancement');
end

end






