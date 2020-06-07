% clc
% close all
% clear all


% [featureVector,hogVisualization] = extractHOGFeatures(I);
% J=imrotate(segmentedImage,-83);



J=segmentedImage;
Z=ones(size(segmentedImage,1),size(segmentedImage,2));
for i=1:size(segmentedImage,1)
    for j=1:size(segmentedImage,2)
            if((J(i,j,1))>105 | J(i,j,2)>90 | J(i,j,3)>75)
                J(i,j,:)=255;
            else
                J(i,j,:)=0;
                Z(i,j)=0;
            end
            
    end
end

figure;
imshow(J); 


