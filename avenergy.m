function [score] = avenergy(mono2, aven, fs, bts, seggroup, ind)
%AVENERGY Calcualte the average energy as a score
%   mono - music signal
%   fs - sampling rate
%   bts - beats
%   seggroup - the group contains the interesting segments
%   ind - index in seggroup

en = mean(mono2(round(fs*bts(seggroup(ind,1))):round(fs*bts(seggroup(ind,3)))));
score = en/aven;

end

