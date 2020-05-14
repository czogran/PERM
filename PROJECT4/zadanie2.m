clc;
clear all;
close all;

load stereoParams

idx=133;
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


h0=figure; 
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

points3D = points3D ./ 1000;
ptCloud = pointCloud(points3D, 'Color', IL);

for i=1:1
    z=[5*i, 10+5*i];
%         z=[5*i, 30+5*i];

    y=[-4, 4+i];
    
    player3D = pcplayer([-5, 5], y, z, 'VerticalAxis', 'y', ...
        'VerticalAxisDir', 'down');

    % Visualize the point cloud
    view(player3D, ptCloud);
    
    lb = z(1);
    ub = z(2);
    Z = points3D(:,:, 3);
    mask = repmat(Z>lb & Z<ub, [1,1,3]);
    KL = IL;
    KL(~mask) = 0;

   h1= figure
    imshow(IL)
    COD = vision.CascadeObjectDetector('CarDetector.xml','UseROI',true);
    [nr,nc,~] = size(IL);
    xleft = 400;
    yupper = 100;
    roi = [xleft yupper nc-2*xleft nr-2*yupper+1];
    frame = insertObjectAnnotation(IL,'rectangle',roi,'ROI'); % title
    bboxes = step(COD,IL,roi);
    frame = insertObjectAnnotation(frame,'rectangle',bboxes,'Car'); % title
    imshow(frame)
    title('Bounding Boxes for Car detected with Cascade Object Detector');

    
    % Extract a roi from z layer of point cloud
    x1 = bboxes(:,1);
    x2 = bboxes(:,1)+bboxes(:,3);
    y1 = bboxes(:,2);
    y2 = bboxes(:,2)+bboxes(:,4);
    ptCloudZRoi = points3D(y1:y2,x1:x2,3);
    
    indeks=1;
    ptCloudZRoiNoInf=0
    for k=1:size(ptCloudZRoi,1)
            for j=1:size(ptCloudZRoi,2)
                if(ptCloudZRoi(k,j)~=inf)
                    ptCloudZRoiNoInf(indeks)=ptCloudZRoi(k,j);
                    indeks= indeks+1;
                end
            end
    end


    % Calculate the average z value or distance
    h2=figure

    distance = mean(ptCloudZRoiNoInf(:),'omitnan');
     frame = insertObjectAnnotation(IL,'rectangle',bboxes,num2str(distance));
    imshow(frame)
    title('Avarage disctamce to car');





    h3=figure
    imshow(KL)
    COD = vision.CascadeObjectDetector('CarDetector.xml','UseROI',true);
    [nr,nc,~] = size(KL);
%     xleft = 380;
%     yupper = 160;
%     roi = [xleft yupper nc-2*xleft nr-yupper+1];
    xleft = 400;
    yupper = 100;
    roi = [xleft yupper nc-2*xleft nr-2*yupper+1];
    frame = insertObjectAnnotation(KL,'rectangle',roi,'ROI'); % title
    bboxes = step(COD,KL,roi);
    frame = insertObjectAnnotation(frame,'rectangle',bboxes,'Car'); % title
    imshow(frame)
    title('Bounding Boxes for Car detected with Cascade Object Detector');

%     % Extract a roi from z layer of point cloud
%     x1 = bboxes(:,1);
%     x2 = bboxes(:,1)+bboxes(:,3);
%     y1 = bboxes(:,2);
%     y2 = bboxes(:,2)+bboxes(:,4);
%     ptCloudZRoi = points3D(y1:y2,x1:x2,3);
% 
%     % Calculate the average z value or distance
%     distance = mean(ptCloudZRoi(:),'omitnan');
%     frame = insertObjectAnnotation(KL,'rectangle',bboxes,num2str(distance));
% 
%     %     Overlay the average distance onto the image
%     figure
%     frame = insertObjectAnnotation(IL,'rectangle',bboxes,num2str(distance));
%     imshow(frame)

end
% Overlay the average distance onto the image
% frame = insertObjectAnnotation(IL,'rectangle',bboxes,num2str(distance));
% figure
% imshow(frame)
% 
% % Overlay the average distance onto the image
% frame = insertObjectAnnotation(KL,'rectangle',bboxes,num2str(distance));
% figure
% imshow(frame)
% 
% % saveas(h0,'.\img\zadanie2\disparityMap.png');

%     saveas(h1,'.\img\zadanie2\ramkiObrazek1.png');
% 
%     saveas(h2,'.\img\zadanie2\odleglosc1.png');
% 
%     saveas(h3,'.\img\zadanie2\wyciety1.png');
