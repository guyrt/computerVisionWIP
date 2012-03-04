% This is a sample script.
clear all
v1 = mmreader('../../../data/action_youtube_reformat/v_biking_01_01.ogg');
v2 = mmreader('../../../data/action_youtube_reformat/v_juggle_01_02.ogg');
v1frames = rgb2grayVideo(v1, 1:80);
v2frames = rgb2grayVideo(v2, 1:80);
[R1,subs1,vals1,cuboids1,V1] = stfeatures(v1frames,2, 3, 1, 2e-4, 250, 1.85, 1, 1, 0 );
[R2,subs2,vals2,cuboids2,V2] = stfeatures(v2frames,2, 3, 1, 2e-4, 250, 1.85, 1, 1, 0 );

cuboids = cat(4, cuboids1, cuboids2);
subs = [subs1(:,3);80+subs2(:,3)];

flatCub = flattenCuboids(cuboids);
z = linkage(flatCub,'ward','euclidean');

rawHistogramSize = 30;
[d1 d2 d3] = dendrogram(z,rawHistogramSize);

% Make an ownership list by finding which frame owns each type.
ownership = makeCuboidOwnershipMatrix(80*2,subs,d2);

imagesc(ownership)
pause;

% 
videoHistogramSize = 4;
zo = linkage(ownership,'ward','euclidean');
[do1,do2,do3] = dendrogram(zo,videoHistogramSize);

% Look at frame histogram.
figure(3), dendrogram(zo,0)
pause;
figure(3), dendrogram(zo, videoHistogramSize);

% Show breakdown of frame sources.
% A strong difference shows that the two video sequences are not alike.
% Overlap suggests they are.
frameHist =  showFrameSource([80 80],do2);
figure(4), bar(frameHist');