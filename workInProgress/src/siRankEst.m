function r = siRankEst(M)

    s1 = svd(M);
    sRed = svd(M(1:(end-1),1:(end-1)));
    
    r = s1(2)*s1(3)/(sRed(1)*sRed(2));