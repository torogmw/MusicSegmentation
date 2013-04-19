function [ctime] = chorusdetection(readDir, writeDir, wavname, minnum, debug, method, output_opt)
%CHORUSDETECTION the main function to invoke and configure all the components
%   minnum - the number of minima in the caldiag.m
%   method - for method choice, 0 for chroma, 1 for MFCC, 2 for chroma+MFCC
%   option - 0 for output txt and wav, 1 for only txt, 2 for only wav

if nargin < 6
    output_opt = 0;
end

if nargin < 5
    method =0;
end

if nargin < 4
   debug = 0;
end

[Y, Fs] = wavread([readDir '\' wavname]);

Mono = (Y(:, 1) + Y(:, 2)) / 2;               %将wav文件平均成单声道
save Y;
clear Y;

tic;

if method==1
    [feature, bts] = chrombeatftrs(Mono, Fs);      %计算节拍为单位的chroma向量
end

if method==0
    [feature, bts]=mfccbeatftrs(Mono, Fs);           %计算以节拍为单位的MFCC向量
end
save Mono;
clear Mono;

%eliminate the 0 colomn at the end of feature matrix
feature= delete0(feature);

chroma_sdmar = sdm(feature);                    %计算特征向量的自距离矩阵
%chromahance_sdmar = chromenhance(chroma_sdmar, 1); 
%mfcc_sdmar = sdm(mfcc);
%chroma_sdmar = mfcc_sdmar+chroma_sdmar;      %计算MFCC向量的自距离矩阵

%[bimar,index] = caldiag(chromhance_sdmar, 30, 1);
[bimar,index] = caldiag(chroma_sdmar, minnum, 1);   %计算候选副歌的对角线
load Mono;
%[chorus, seggroup] = locseg(bimar, index, bts, chromhance_sdmar, Mono, Fs);
[chorus, ~] = locseg(bimar, index, bts, chroma_sdmar, Mono, Fs, debug); %计算chorus的位置函数
ctime = bts2time(chorus, bts);

%output the result to result.txt
if output_opt == 0 || output_opt == 1
    fout = fopen(([writeDir '\Result.txt']), 'a');                                    %set the directory to put in the chorus result text
    fprintf(fout, '%s\r\t', wavname);
    for j = 1:4
        if j == 4
            fprintf(fout, '%3f\r\n', ctime(j));
        else
            fprintf(fout, '%3f\r\t', ctime(j));
        end
    end
    fclose(fout);
end

%output the wavform of the chorus to folder ./chorus/
if output_opt == 0 || output_opt == 2
    load Y;
    ch = Y(round(Fs*ctime(2)):round(Fs*ctime(4)),:);
    chorus_name = [writeDir,'\chorus_',wavname];                         %set the directory to put in the chorus result wav
    wavwrite(ch, Fs, chorus_name);
    clear Y;
end

clear Mono;
delete Mono.mat;
delete Y.mat;
toc;

end








