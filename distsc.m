function score = distsc(avedis, sdm, seggroup, ind)
%DISTSC Average distance score

med = median(diag(sdm(seggroup(ind,1):seggroup(ind,3),seggroup(ind,2):seggroup(ind,4))));
score = 1-med/avedis;

end

