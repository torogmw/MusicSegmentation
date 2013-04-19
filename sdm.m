function [sdmar] = sdm(ftr, debug)
%SDM calculate the self-distance matrix of the input vector ftr, sdmar
%returns the results

if nargin < 2; debug = 0;end

[~, vecnum] = size(ftr);
sdmar = zeros(vecnum, vecnum);

for i = 1:vecnum;
    for j = 1:vecnum;
        sdmar(i,j) = sqrt((sum(ftr(:,i)-ftr(:,j)).^2));  
    end
end

if debug ~= 0; 
    figure; imshow(mat2gray(sdmar));
end
end
