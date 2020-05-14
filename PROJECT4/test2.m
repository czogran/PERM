clc;
clear all;
close all;

load stereoParams

% idx=133;
 idx=61;
% idx=2;

LeftImages = imageSet('./RecordedImages/left');
RightImages = imageSet('./RecordedImages/right');

% Load the idx'th images from the directories
I1 = imread(LeftImages.ImageLocation{idx});
I2 = imread(RightImages.ImageLocation{idx}); 

% [I1 I2] =  returnStereoImages(idx);
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);
[IL, IR] = rectifyStereoImages(I1, I2, stereoParams);


figure; 
imshowpair(I1,I2,'montage'); 
title('Extracted Portion of Original Images');


J1=rgb2gray(J1);
J2=rgb2gray(J2);

dispRange = [0, 16];
disparityMap = disparity(J1, J2, ...
    'DisparityRange', dispRange, ...
    'BlockSize', 15, ...
    'ContrastThreshold', 0.5, ...
    'UniquenessThreshold', 15 );
	
% show disparity map

figure 
imshow(disparityMap, dispRange);
colormap(gca,jet) 
colorbar

points3D = reconstructScene(disparityMap, stereoParams);

% % expand gray image to three channels (simulate RGB)
% 
% J1_col = cat(3, J1, J1, J1);
% 
% Convert to meters and create a pointCloud object


    points3D = points3D ./ 1000;
    ptCloud = pointCloud(points3D, 'Color', IL);

for i=1:7
    z=[5*i, 10+5*i];
    y=[-4, 4+i];
    % Create a streaming point cloud viewer
    % player3D = pcplayer([-5, 5], [-5, 5], [0, 50], 'VerticalAxis', 'y', ...

    player3D = pcplayer([-5, 5], y, z, 'VerticalAxis', 'y', ...
        'VerticalAxisDir', 'down');

    % Visualize the point cloud
    view(player3D, ptCloud);
% lb = 10;
%     ub = 15;
    
    lb = z(1);
    ub = z(2);
    Z = points3D(:,:, 3);
    mask = repmat(Z>lb & Z<ub, [1,1,3]);
    KL = IL;
    KL(~mask) = 0;

    % figure; 
    % imshow(KL); 
    % title('Distance Thresholded Image')





    figure
    imshow(KL)
    COD = vision.CascadeObjectDetector('CarDetector.xml','UseROI',true);
    [nr,nc,~] = size(KL);
    xleft = 380;
    yupper = 160;
    roi = [xleft yupper nc-2*xleft nr-yupper+1];
    frame = insertObjectAnnotation(KL,'rectangle',roi,'ROI'); % title
    bboxes = step(COD,KL,roi);
    frame = insertObjectAnnotation(frame,'rectangle',bboxes,'Car'); % title
    imshow(frame)
    title('Bounding Boxes for Car detected with Cascade Object Detector');

    % Extract a roi from z layer of point cloud
    x1 = bboxes(:,1);
    x2 = bboxes(:,1)+bboxes(:,3);
    y1 = bboxes(:,2);
    y2 = bboxes(:,2)+bboxes(:,4);
    ptCloudZRoi = points3D(y1:y2,x1:x2,3);

    % Calculate the average z value or distance
    distance = mean(ptCloudZRoi(:),'omitnan');
    frame = insertObjectAnnotation(KL,'rectangle',bboxes,num2str(distance));


end
% % Overlay the average distance onto the image
% frame = insertObjectAnnotation(KL,'rectangle',bboxes,num2str(distance));
% figure
% imshow(frame)


