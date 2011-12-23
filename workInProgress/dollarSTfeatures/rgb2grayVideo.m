function grayVid = rgb2grayVideo(video, frames)

% Convert a video object to gray scale video
% Params
%   video: a video object
%   frames: a frame set (default is whole video)

% Author: Richard T. Guy

if nargin == 1
    frames = 1:get(video,'numberofframes');
end

frame = read(video, frames(1));
s = size(frame);
s = s(1:2);

grayVid = zeros([s length(frames)]);

for i = frames
   grayVid(:,:,i) = rgb2gray(read(video,i));
end