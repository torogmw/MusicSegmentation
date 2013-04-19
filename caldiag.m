function [ bimar, index ] = caldiag(sdmar, num, debug, deplot)
%CALDIAG calculate the possible diagonal, return as the binarized matrix
%   sdmar - feature self-distance matrix
%   num - number of minima
%   debug - 1 for plot the diagonals, 2 for low pass

if nargin < 4
    deplot = 0;
end

if nargin <3
    debug = 0;
end

len = length(sdmar);
dig = zeros(len-1,1);
for i = 1:len-1
    dig(i) = sum(diag(sdmar, -i))/(len-i);
end

if debug ~= 0
    %low pass the dig to "detrend"
    dig_lp = filter(ones(50,1)/50, 1, dig);
    dig = dig-dig_lp;
end

[minima, index] = lmin(dig, 2);

if length(minima) > num
    while(1)
        add = find(minima == max(minima), length(minima)-num, 'first');
        minima(:, add) = [];
        index(:, add) = [];
        if(length(minima) == num)
            break;
        end
    end
end

if deplot ~= 0
    figure;
    plot(dig); grid; hold on;
    plot(index, dig(index), 'r+');
end

all_len = length(diag(sdmar,-index(1)));
longvec = diag(sdmar,-index(1))';
for i = 2:length(index)
    all_len = all_len+length(diag(sdmar,-index(i)));
    longvec = [longvec, diag(sdmar,-index(i))'];
end

longvec = sort(longvec);
threshold = longvec(round(0.2*all_len));
bimar = -ones(len,len);

for i = 1:length(index)
    temp = diag(sdmar,-index(i));
    for j = 1:length(diag(sdmar,-index(i)))
        if temp(j) > threshold
            bimar(index(i)+j,j) = 1;
        else
            bimar(index(i)+j,j) = 0;
        end
    end
end

if deplot ~= 0
    figure; imshow(mat2gray(bimar));title('binarized matrix');
end

%enhance the binarized matrix
for i = 1:length(index)
    temp = diag(bimar,-index(i));
    j = 1;
    while length(temp) >= 25 || j <= length(temp)
        if temp(j) == 0
            j = j + 1;
            if j+25-1 > length(temp)
                break;
            end
            continue;
        end
        if j+25-1 > length(temp)
            break;
        end
        kernel = temp(j:j+25-1);
        if isenhan(kernel)
            for k = 0:24
                bimar(index(i)+j+k, j+k) = 1;
            end
            j = j+25-1;
        end
        j = j + 1;
        if j+25-1 > length(temp)
            break;
        end        
    end
end

if deplot ~= 0
    figure; imshow(mat2gray(bimar));title('binarized matrix - after enhancement');
end

end


