% zadanie 1
stereoCameraCalib;

% dispRange = [0, 64];
dispRange = [64, 400];
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