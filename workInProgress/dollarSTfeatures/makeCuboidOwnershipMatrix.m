function ownership = makeCuboidOwnershipMatrix(numFrames, cuboidLocations, dendrogramArm)

% Return a numFrames by len(dendrogramArm) matrix with a
% m(i,j) equal to the number of cuboids in dendrogram arm
% j that intersect frame i.

ownership = zeros(numFrames, max(dendrogramArm));

dendrogramArm = dendrogramArm(:);

for i=1:numFrames
    cuboids = abs(cuboidLocations-i) < 9;
    for j=1:max(dendrogramArm)
        ownership(i,j) = sum(dendrogramArm(cuboids) == j);
    end
end
