function ownership = makeCuboidOwnershipMatrix(numFrames, cuboidLocations, dendrogramArm)

% Return a numFrames by len(dendrogramArm) matrix with a
% m(i,j) equal to the number of cuboids in dendrogram arm
% j that intersect frame i.

mx = max(dendrogramArm);
ownership = zeros(numFrames, mx);

dendrogramArm = dendrogramArm(:);

for i=1:numFrames
    cuboids = abs(cuboidLocations-i) < 9;
    ownership(i,:) = hist(dendrogramArm(cuboids),[1:mx]);
end
