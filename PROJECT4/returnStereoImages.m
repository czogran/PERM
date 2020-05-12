function [IL,IR] = returnStereoImages(idx)
% Copyright 2015-2016 The MathWorks, Inc.
% Create an image set for the Recorded Image directories
LeftImages = imageSet('./RecordedImages/left');
RightImages = imageSet('./RecordedImages/right');

% Load the idx'th images from the directories
ILO = imread(LeftImages.ImageLocation{idx});
IRO = imread(RightImages.ImageLocation{idx}); 

% figure
% imshow(ILO)
% hold off

% % Extract the middle of the image
% [nr,width,~] = size(ILO);
% tf = 2/4;
% bf = 3/4;
% 
% wl=0.25;
% wr=0.75;
% 
% IL = ILO(tf*nr:bf*nr,wl*width:wr*width,:);
% IR = IRO(tf*nr:bf*nr,wl*width:wr*width,:);

[nr,~] = size(ILO);
tf = 1/4;
bf = 3/4;
IL = ILO(tf*nr:bf*nr,:,:);
IR = IRO(tf*nr:bf*nr,:,:);

% IL = ILO(:,:,:);
% IR = IRO(:,:,:);
end