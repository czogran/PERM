
imageRegionAnalyzer(logical(BW1))

stats = regionprops(CC,'all');
stats_binary = regionprops(CC_binary,'all');

hsv_image=rgb2hsv(segmentedImage);
hsv_image(:,:,1)=hsv_image(:,:,1)*360; % zamiena 'hue' z wartości <0,1> na stopnie
h=zeros(1,size(stats,1));

for i=1:size(stats,1)
   
    % określenie koloru
    x=zeros(1,size(CC_binary.PixelIdxList{1,i},1));
    y=zeros(1,size(CC_binary.PixelIdxList{1,i},1));
    pixel_hue=zeros(1,size(CC_binary.PixelIdxList{1,i},1));
    for j=1:size(CC_binary.PixelIdxList{1,i},1)
        x(j)=ceil(CC_binary.PixelIdxList{1,i}(j)/size(hsv_image,1)); % size(hsv_image,1) to wysokość obrazu czyli 'y', dziwne ale w obrazie 'y' jest na pierwszej pozycji
        y(j)=CC_binary.PixelIdxList{1,i}(j)-size(hsv_image,1)*(x(j)-1);
        pixel_hue(j)=hsv_image(y(j), x(j), 1);
    end    
    h(i)=mean(pixel_hue);
    if ( (h(i)>=0) && (h(i)<=25) ) || ( (h(i)>=135) && (h(i)<=136) ) || ( (h(i)>=55) && (h(i)<=62) ) || ( (h(i)>=110) && (h(i)<=112) )
        data(i).kolor='czerwony';
    
    elseif ( (h(i)>=30) && (h(i)<=55) )
        data(i).kolor='żółty';
    
    elseif ( (h(i)>=155) && (h(i)<=170) )
        data(i).kolor='zielony';
    
    elseif ( (h(i)>=188) && (h(i)<=213) )
        data(i).kolor='jasnoniebieski';
    
    elseif ( (h(i)>=230) && (h(i)<=250) )
        data(i).kolor='ciemnoniebieski';
        
    elseif ( (h(i)>=300) && (h(i)<=330) )
        data(i).kolor='różowy';
    
    elseif ( (h(i)>=212) && (h(i)<=214) ) || ( (h(i)>=171) && (h(i)<=172) )
        data(i).kolor='biały';
    else
        data(i).kolor='nieznany';
    end    
    
    
    % położenie środka ciężkości
    data(i).polozenie=stats(i).Centroid(1:2);
    
    % określenie kształtu
    if stats_binary(i).Circularity>0.9537
        data(i).ksztalt='okrag';
        fig(i)=1;
    else
        data(i).ksztalt='kwadrat';
        fig(i)=2;
    end    
    
    % określenie rozmiaru
    if fig(i)==1
        data(i).rozmiar=sqrt(stats(i).Area*4/pi); % średnica
    end
    if fig(i)==2
        data(i).rozmiar=sqrt(stats(i).Area); % długość boku
    end 
    
    % określenie orientacji    
    if fig(i)==1
        data(i).orientacja='--'; % dla okręgu nie określamy orientacji
    end
    if fig(i)==2
        data(i).orientacja=stats_binary(i).Orientation;
    end    
    
end
