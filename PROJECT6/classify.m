clc;
clear all;
close all;
% imds = {'./HOG_features/hog_image0.jpg'};

% TEST KLASYFIKATORA

filePath ={...
    './HOG_images/hog_image0.jpg',...
    './HOG_images/hog_image1.jpg',...
    './HOG_images/hog_image2.jpg',...
    './HOG_images/hog_image3.jpg',...
    './HOG_images/hog_image4.jpg',...
    './HOG_images/hog_image5.jpg',...
    './HOG_images/hog_image6.jpg',...
    './HOG_images/hog_image7.jpg',...
    './HOG_images/hog_image8.jpg',...
    './HOG_images/hog_image+.jpg',...
    './HOG_images/hog_image-.jpg',...
    './HOG_images/hog_imageX.jpg',...
    './HOG_images/hog_imageDiv.jpg',...
    };

testFilePath = {52};
testImages={52};

% które obrazki testujemy
first =1;
last=52;

for k=first:last
    fileName="./test_img/test_image"+k+".jpg";
    fileName=char(fileName);
    testFilePath{k}=fileName;
    testImages{k}=imread(testFilePath{k});
end
testSet=imageDatastore(testFilePath(first:last));

% img = readimage(imds,13);
labels =[0,1,2,3,4,5,6,7,8,"plus","minus","X","Div"];
% przypisywane gdy sie obraca obrazki
trainingLabels=[];

numImages = numel(filePath);

trainingSet={numImages};
for k=1:numImages
    trainingSet{k}=imread(filePath{k});
end

cellSize = [20 20];

[hog_4x4, vis4x4] = extractHOGFeatures((trainingSet{1}),'CellSize',cellSize);
hogFeatureSize = length(hog_4x4);

rotation=[0 1 2 3 4 5 8 10 15 20:10:170];

trainingFeatures = zeros(numImages*size(rotation,2), hogFeatureSize, 'single');

% zalozenie ze wszystkie obrazki do nauka sa takie same, kwadratowe
background = ones(size(trainingSet{1}))*255;
i_size=size(trainingSet{1});
i_dim=[i_size(1) i_size(1) i_size(1)-1 i_size(1)-1];
indeks=1;

for i = 1:numImages
    img =trainingSet{i};
    
    img=[background background background; background img background; background background background];
    
    img = rgb2gray(img);
    
    % Apply pre-processing steps
    img = imbinarize(img);

    for k=rotation
        i_rotate=imrotate(img,k);
        i_cut = imcrop(img,i_dim);
        trainingFeatures(indeks, :) = extractHOGFeatures(i_cut, 'CellSize', cellSize); 
        trainingLabels=[trainingLabels labels(i)];
        indeks=indeks+1;
    end
end



% fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
classifier = fitcecoc(trainingFeatures, trainingLabels);

[testFeatures] = helperExtractHOGFeatures(testSet, hogFeatureSize, cellSize);

% Make class predictions using the test features.
[predictedLabels, score] = predict(classifier, testFeatures);

% % Tabulate the results using a confusion matrix.
% confMat = confusionmat(trainingLabels, predictedLabels);
% 
% displayConfusionMatrix(confMat,trainingLabels)

indeks=1;
images={};
for k=first:last
%     tekst="sign:"+string(predictedLabels{indeks})+"  score:"+score{indeks};
   img_colors =insertText(testImages{k},[50 50; 50 50],predictedLabels{indeks},'FontSize',25);
   indeks=indeks+1;
   images{k}= img_colors;
%    figure
%    imshow(img_colors)
%    hold off
end    

montage(images);








% classifier={};
% 
% classifier =load('./HOG_features/hog_feature1').hog_4x4;
% 
% 
% image = load('./segmented_image/segmented.mat');
% image=image.J;
% CC_binary=load('segmented_image/CC_binary.mat');
% CC_binary=CC_binary.CC_binary;
% stats_binary = regionprops(CC_binary,'all');
% 
% 
% img_size=size(image); 
% position=[];
% shape=[];
% % for k=1:size(stats_binary,1)
% % dla k:1:7 wykrywa liczby od 0 do 6
% % 7 k=20
% % 8 k= 35
% % x k=12
% % + l=10
% % - k=11
% % / (dzielenie) k=
% for k=1:1
%     index=CC_binary.PixelIdxList{k};
%     [row column]=ind2sub(img_size(1:2),index);
% 
%     % określenie kształtu
%     if stats_binary(k).Circularity>0.9537
%         length_a=round(sqrt(stats_binary(k).Area*4/pi)); % średnica
%     else
%        length_a=round( sqrt(stats_binary(k).Area)); % długość boku
%         square_orient=round(stats_binary(k).Orientation);
%     end    
%     % zmniejszenie dlugosci boku, eksoerymentalne
%     length_a=length_a-10;
%     position=floor(stats_binary(k).Centroid(1:2));
%     position=position-length_a*sqrt(2)/3;
%     rect_dimension=[position,length_a,length_a];
%     I_cut = imcrop(image,rect_dimension);
% %     figure
% %     imshow(I_cut)
% %     
%     [hog_4x4, vis4x4]=extractHOGFeatures(I_cut,'CellSize',[4 4]);
% 
% %     figure
% %     plot(vis4x4)
%     
%     X=classifier';
%     Y=hog_4x4';
% 
%     Idx=knnsearch(X,Y);
% 
%     amount= sum(ismember(Idx,1));
% 
%     diffrence(k)=length(Y)-amount;
% 
% end

% X=classifier';
% Y=hog_4x4';
% 
% Idx=knnsearch(X,Y);
% 
% amount= sum(ismember(Idx,1));
% 
% diffrence=length(Y)-amount;
% 
