addpath('.\colornames\');

% UWAGA- należy ustawić numer obrazka w zadaniu 1
zadanie1

stats = regionprops(CC,'all');
stats_binary = regionprops(CC_binary,'all');

img_size=size(segmentedImage); 
position=[];
shape=[];
for k=1:size(stats_binary,1)
    index=CC_binary.PixelIdxList{k};
    [row column]=ind2sub(img_size(1:2),index);

    % określenie kształtu
    if stats_binary(k).Circularity>0.9537
        radius=round(sqrt(stats_binary(k).Area*4/pi)); % średnica
       shape=[shape; "circle, r:"+radius];
    else
        square_a=round( sqrt(stats_binary(k).Area)); % długość boku
        square_orient=round(stats_binary(k).Orientation);
        shape=[shape; k+"square a:"+square_a+newline+"orientation:"+square_orient];
    end    
    
    position=[position; stats_binary(k).Centroid(1:2)];
end

img_param =insertText(segmentedImage,position,shape,'FontSize',20);
figure
  imshow(img_param)
hold off
