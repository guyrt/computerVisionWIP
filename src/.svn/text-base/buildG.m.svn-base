function G = buildG(patch)

dX = diff(patch);
dY = diff(patch,1,2);
dt = diff(patch,1,3);

dX = dX(1:end,1:(end-1),1:(end-1));
dY = dY(1:(end-1),1:end,1:(end-1));
dt = dt(1:(end-1),1:(end-1),1:end);

G = [dX(:) dY(:) dt(:)];