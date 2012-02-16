% This is a sample script.
v1 = mmreader('../../../data/action_youtube/v_biking_01_01.avi');
v2 = mmreader('../../../data/action_youtube/v_biking_01_02.avi');
v1frames = rgb2grayVideo(v1, 1:80);
v2frames = rgb2grayVideo(v2,1:80);
[R1,subs1,vals1,cuboids1,V1] = stfeatures(v1frames,2, 3, 1, 2e-4, 250, 1.85, 1, 1, 0 );
[R2,subs2,vals2,cuboids2,V2] = stfeatures(v2frames,2, 3, 1, 2e-4, 250, 1.85, 1, 1, 0 );
cuboids = cat(4, cuboids1, cuboids2);
subs = [subs1(:,3);80+subs2(:,3)];
flatCub = flattenCuboids(cuboids);
z = linkage(flatCub,'ward','euclidean');
[d1 d2 d3] = dendrogram(z,30);
ownership = makeCuboidOwnershipMatrix(80,subs,d2);
imagesc(ownership)
zo = linkage(ownership,'ward','euclidean');
[do1,do2,do3] = dendrogram(zo,0);
plot(do2)
dendrogram(zo,0)
