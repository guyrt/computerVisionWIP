
x = video.height-10;
y = video.width-10;
t = 5;

rankMatrix = zeros(x,y,t);
eigenValues = zeros(x*y*t,3);
c = 1;

for tm=1:t

    frame = read(video, [tm 3+tm]);
    grayFrame = zeros(video.height,video.width,4);
    for f=1:4
       grayFrame(:,:,f) = rgb2gray(frame(:,:,:,f));
    end
    
    
    for i=1:x
        for j=1:y
        
            patch1 = getPatch(grayFrame, i,j,1,7,3);
            G = buildG(patch1);
            M = G'*G;
            rankMatrix(i,j,tm) = siRankEst(M);
            eigenValues(c,:) = svd(M)';
            c = c+1;
        end
    end
end
