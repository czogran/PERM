addpath('.\colornames\');

% UWAGA- należy ustawić numer obrazka w zadaniu 1
zadanie1

stats = regionprops(CC,'all');
stats_binary = regionprops(CC_binary,'all');

img_size=size(segmentedImage); 
position=[];
shape=[];
for k=1:size(stats,1)

    index=CC_binary.PixelIdxList{k};
    [row column]=ind2sub(img_size(1:2),index);

    color_R=[];
    color_G=[];
    color_B=[];
    for i=1:length(index)
            color_R=[color_R segmentedImage(row(i),column(i),1)];
            color_G=[color_G segmentedImage(row(i),column(i),2)];
            color_B=[color_B segmentedImage(row(i),column(i),3)];
    end
    
    color_R=mean(color_R)/255;
    color_G=mean(color_G)/255;
    color_B=mean(color_B)/255;

    colors(k)=colornames('MATLAB',[color_R,color_G,color_B]);
    
    % określenie kształtu
    if stats_binary(k).Circularity>0.9537
        radius=round(sqrt(stats(k).Area*4/pi)); % średnica
       shape=[shape; "circle, r:"+radius];
    else
        square_a=round( sqrt(stats(k).Area)); % długość boku
        square_orient=round(stats_binary(k).Orientation);
        shape=[shape; "square a:"+square_a+newline+"orientation:"+square_orient];
    end    
    
    position=[position; stats(k).Centroid(1:2)];
end

img_colors =insertText(segmentedImage,position,colors,'FontSize',25);
figure
  imshow(img_colors)
hold off

img_param =insertText(segmentedImage,position,shape,'FontSize',20);
figure
  imshow(img_param)
hold off
