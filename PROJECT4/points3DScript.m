% zadanie 1
disparityMapScript;
points3D = reconstructScene(disparityMap, stereoParams);

% expand gray image to three channels (simulate RGB)

J1_col = cat(3, J1, J1, J1);

% Convert to meters and create a pointCloud object

points3D = points3D ./ 1000;
ptCloud = pointCloud(points3D, 'Color', J1_col);

% Create a streaming point cloud viewer

player3D = pcplayer([-3, 3], [-3, 3], [0, 8], 'VerticalAxis', 'y', ...
    'VerticalAxisDir', 'down');

% Visualize the point cloud

view(player3D, ptCloud);