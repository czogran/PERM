% -------------------------------------------------------------------------%
% ----WYZNACZANIE CECH HOG DLA WSZYSTKICH SYMBOLI Z PRZYKŁADOWEGO OBRAZKA--%
%--------------------------------------------------------------------------%

close all;
clear all;
clc;

image = load('./segmented_image/segmented.mat');
image=image.J;
CC_binary=load('segmented_image/CC_binary.mat');
CC_binary=CC_binary.CC_binary;

stats_binary = regionprops(CC_binary,'all');


img_size=size(image); 
position=[];
shape=[];

for k=1:length(CC_binary.PixelIdxList)
    index=CC_binary.PixelIdxList{k};
    [row column]=ind2sub(img_size(1:2),index);

    % określenie kształtu
    if stats_binary(k).Circularity>0.9537
        length_a=round(sqrt(stats_binary(k).Area*4/pi)); % średnica
    else
       length_a=round( sqrt(stats_binary(k).Area)); % długość boku
        square_orient=round(stats_binary(k).Orientation);
    end    
    % zmniejszenie dlugosci boku, eksperymentalne
    length_a=length_a-10;
    % proba ze stala dlugoscia boku- nie wiem czy tak nie powinno byc
    length_a=120;
    position=floor(stats_binary(k).Centroid(1:2));
    position=position-length_a*0.5;
    rect_dimension=[position,length_a,length_a];
    I_cut = imcrop(image,rect_dimension);
    figure
    imshow(I_cut)
    
    [hog_4x4, vis4x4]=extractHOGFeatures(I_cut,'CellSize',[4 4]);

   
    filename= "test_features/hog_test"+(k);
    save (filename,'hog_4x4', 'vis4x4');
    
    filename= "test_img/test_image"+(k)+".jpg";
    imwrite (I_cut,filename);

end

