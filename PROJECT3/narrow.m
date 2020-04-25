% Auto-generated by cameraCalibrator app on 25-Apr-2020
%-------------------------------------------------------


% Define images to process
imageFileNames = {'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0000.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0001.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0002.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0003.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0004.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0005.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0006.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0007.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0008.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0009.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0010.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0011.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0012.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0013.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0014.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0015.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0016.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0017.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0018.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0019.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0021.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0024.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0025.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0027.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0028.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0029.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0030.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0031.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0032.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0033.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0034.png',...
    'D:\PAWEL\STUDIA\PERM\PERM\PROJECT3\calib_narrow\left-0035.png',...
    };
% Detect checkerboards in images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the first image to obtain image size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate world coordinates of the corners of the squares
squareSize = 40;  % in units of 'millimeters'
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the camera
[cameraParams, imagesUsed, estimationErrors] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% View reprojection errors
h1=figure; showReprojectionErrors(cameraParams);

% Visualize pattern locations
h2=figure; showExtrinsics(cameraParams, 'CameraCentric');

% Display parameter estimation errors
displayErrors(estimationErrors, cameraParams);

% For example, you can use the calibration data to remove effects of lens distortion.
undistortedImage = undistortImage(originalImage, cameraParams);

% See additional examples of how to use the calibration data.  At the prompt type:
% showdemo('MeasuringPlanarObjectsExample')
% showdemo('StructureFromMotionExample')

saveas(h1,'.\img\task1ReprojectionErrors\narrowReprojectionErrors.png');
saveas(h2,'.\img\task1Extrinsics\narrowExtrinsics.png');