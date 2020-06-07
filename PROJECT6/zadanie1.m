clc
clear all
close all

% Load the idx'th images from the directories
image1 = imread('./learn_img/img1.jpg');
image2 = imread('./learn_img/img2.jpg');

rgbImage={image1, image2};
for i=1:2
    redChannel = rgbImage{i}(:, :, 1);
    greenChannel = rgbImage{i}(:, :, 2);
    blueChannel = rgbImage{i}(:, :, 3);

    % Get means
    meanR(i) =mean( mean(redChannel(1:50,:)));
    meanG(i) =mean( mean(greenChannel(1:50,:)));
    meanB(i) = mean(mean(blueChannel(1:50,:)));
end

avgR=mean(meanR);
avgG=mean(meanG);
avgB=mean(meanB);

I1 = (image1);
I1(:,:,1)=I1(:,:,1)*(avgR/meanR(1));
I1(:,:,2)=I1(:,:,2)*(avgG/meanG(1));
I1(:,:,3)=I1(:,:,3)*(avgB/meanB(1));

I2 = (image2);
I2(:,:,1)=I2(:,:,1)*(avgR/meanR(2));
I2(:,:,2)=I2(:,:,2)*(avgG/meanG(2));
I2(:,:,3)=I2(:,:,3)*(avgB/meanB(2));


% Wybor obrazka do analizy
I=I1;

[BW,maskedRGBImage]=createMask(I);
% figure;
% imshow(BW);
% hold off;
% figure;
% imshow(maskedRGBImage);
% hold off;


[BW1,segmentedImage]=segmentImage(I,BW);
figure;
imshow(BW1);
hold off;
figure;
imshow(segmentedImage);
hold off;

CC=bwconncomp(segmentedImage)

CC_binary=bwconncomp(BW1)
