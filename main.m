%output the detection result
%matlab����������

readDir = 'I:\testing';              %���ò���Ŀ¼
writeDir = 'I:\testing\result';
readPath = [readDir '\*.wav'];      

readList = dir(readPath);
[m, ~] = size(readList);

for i = 1:m
    wavName = readList(i, 1).name;
    %readPath = [readDir '\' wavName];
    ctime = chorusdetection(readDir, writeDir, wavName, 30, 0, 1, 0);    
end







