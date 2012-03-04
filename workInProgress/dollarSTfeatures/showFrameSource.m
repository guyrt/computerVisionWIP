function frameImg = showFrameSource(frameCounts, d2)

% Use the output of a dendrogram to show which frame each element came
% from.
% frameCounts(i) is number of frame in video i.

mx = max(d2);
frameImg = zeros(length(frameCounts),mx);

frameCnt = 1;
for i = 1:length(frameCounts)
    frameImg(i,:) = hist(d2(frameCnt:(frameCnt+frameCounts(i)-1)), [1:mx]);
    frameCnt = frameCnt + frameCounts(i);
end