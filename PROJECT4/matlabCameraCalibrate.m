% Auto-generated by stereoCalibrator app on 10-May-2020
%-------------------------------------------------------


% Define images to process
imageFileNames1 = {'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_01.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_02.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_16.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_19.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_22.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_25.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_28.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_31.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_34.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_37.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_43.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_46.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_49.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_28_55.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_01.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_04.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_07.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_10.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_13.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_16.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_19.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_22.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_25.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_28.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_31.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_37.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_40.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_43.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_46.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_49.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_52.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_55.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_29_58.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_01.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_07.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_10.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_13.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_16.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_19.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_22.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_25.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_28.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_31.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_34.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_37.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_40.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_43.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_46.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_49.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\left\frameL_12_Jan_2016_13_30_55.jpg',...
    };
imageFileNames2 = {'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_01.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_02.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_16.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_19.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_22.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_25.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_28.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_31.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_34.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_37.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_43.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_46.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_49.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_28_55.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_01.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_04.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_07.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_10.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_13.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_16.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_19.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_22.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_25.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_28.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_31.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_37.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_40.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_43.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_46.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_49.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_52.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_55.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_29_58.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_01.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_07.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_10.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_13.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_16.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_19.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_22.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_25.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_28.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_31.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_34.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_37.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_40.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_43.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_46.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_49.jpg',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT4\CalibrationImages\right\frameR_12_Jan_2016_13_30_55.jpg',...
    };

% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames1, imageFileNames2);

% Generate world coordinates of the checkerboard keypoints
squareSize = 30;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Read one of the images from the first stereo pair
I1 = imread(imageFileNames1{1});
[mrows, ncols, ~] = size(I1);

% Calibrate the camera
[stereoParams, pairsUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(stereoParams);

% Visualize pattern locations
h2=figure; showExtrinsics(stereoParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, stereoParams);

% You can use the calibration data to rectify stereo images.
I2 = imread(imageFileNames2{1});
[J1, J2] = rectifyStereoImages(I1, I2, stereoParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('StereoCalibrationAndSceneReconstructionExample')
% showdemo('DepthEstimationFromStereoVideoExample')

stereoParams.CameraParameters1.ImageSize=[];
stereoParams.CameraParameters2.ImageSize=[];

save('stereoParams.mat','stereoParams');