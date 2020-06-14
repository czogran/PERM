% ------------------------------------------------------------------------%
% ----WYZNACZANIE CECH HOG DLA KAŻDEGO Z SYMBOLI Z PRZYKŁADOWEGO OBRAZKA--%
%-------------------------------------------------------------------------%

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
% dla k:1:7 wykrywa liczby od 0 do 6
% 7 k=20
% 8 k= 35
% x k=12
% + l=10
% - k=11
% / (dzielenie) k=13
ekstract_vector=[1:7,20,35,12,10,11,13];
for k=ekstract_vector
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
%     length_a=length_a-10;
    % proba ze stala dlugoscia boku- nie wiem czy tak nie powinno byc
    length_a=120;
    position=floor(stats_binary(k).Centroid(1:2));
        position=position-0.5*length_a;

%     position=position-length_a*sqrt(2)/3;
    rect_dimension=[position,length_a,length_a];
    I_cut = imcrop(image,rect_dimension);
%     figure
%     imshow(I_cut)
    
    [hog_4x4, vis4x4]=extractHOGFeatures(I_cut,'CellSize',[10 10]);

%     figure
%     plot(vis4x4)
%     
   
    filename= "HOG_features/hog_feature"+(k-1);
 if(k==10)
      filename= "HOG_features/hog_feature+";
 elseif (k==11)
         filename= "HOG_features/hog_feature-";
 elseif (k==12)
      filename= "HOG_features/hog_featureX";
 elseif (k==20)
      filename= "HOG_features/hog_feature7";
  elseif (k==35)
      filename= "HOG_features/hog_feature8";
      elseif (k==13)
      filename= "HOG_features/hog_featureDiv";

 end
    save (filename,'hog_4x4', 'vis4x4');
    
        filename= "HOG_images/hog_image"+(k-1)+".jpg";
 if(k==10)
      filename= "HOG_images/hog_image+"+".jpg";
 elseif (k==11)
         filename= "HOG_images/hog_image-"+".jpg";
 elseif (k==12)
      filename= "HOG_images/hog_imageX"+".jpg";
 elseif (k==20)
      filename= "HOG_images/hog_image7"+".jpg";
  elseif (k==35)
      filename= "HOG_images/hog_image8"+".jpg";
  elseif (k==13)
      filename= "HOG_images/hog_imageDiv"+".jpg";

 end
    imwrite (I_cut,filename);
    
    
 filename= "HOG_images/hog"+(k-1)+".jpg";
 if(k==10)
      filename= "HOG_images/hog+"+".jpg";
 elseif (k==11)
         filename= "HOG_images/hog-"+".jpg";
 elseif (k==12)
      filename= "HOG_images/hogX"+".jpg";
 elseif (k==20)
      filename= "HOG_images/hog7"+".jpg";
  elseif (k==35)
      filename= "HOG_images/hog8"+".jpg";
  elseif (k==13)
      filename= "HOG_images/hogDiv"+".jpg";

 end
     fig1=figure
     plot(vis4x4);
     hold off
    saveas(fig1,filename,'png')
end

