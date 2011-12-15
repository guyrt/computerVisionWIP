function patch = getPatch(video, x, y, t, dSpace, dTime)


patch = video(x:(x+dSpace-1),y:(y+dSpace-1),t:(t+dTime));