function Classify_RGB_Image()
try
	clc;    % Clear the command window.
	close all;  % Close all figures (except those of imtool.)
	clear;  % Erase all existing variables. Or clearvars if you want.
	workspace;  % Make sure the workspace panel is showing.
	format long g;
	format compact;
	fontSize = 20;
	
	% Check that user has the specified Toolbox installed and licensed.
	hasLicenseForToolbox = license('test', 'image_toolbox');
	if ~hasLicenseForToolbox
		% User does not have the toolbox installed, or if it is, there is no available license for it.
		% For example, there is a pool of 10 licenses and all 10 have been checked out by other people already.
		message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
		reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
		if strcmpi(reply, 'No')
			% User said No, so exit.
			return;
		end
	end
	
	% Check that user has the specified Toolbox installed and licensed.
	hasLicenseForToolbox = license('test', 'Statistics_toolbox');
	if ~hasLicenseForToolbox
		% User does not have the toolbox installed, or if it is, there is no available license for it.
		% For example, there is a pool of 10 licenses and all 10 have been checked out by other people already.
		message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
		reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
		if strcmpi(reply, 'No')
			% User said No, so exit.
			return;
		end
	end
	
	%-----------------------------------------------------------------------------------------------------------------------------
	% Have user browse for a file, from a specified "starting folder."
	% For convenience in browsing, set a starting folder from which to browse.
% 	startingFolder = 'C:\Users\Public\Pictures\Sample Pictures';
	startingFolder = pwd;
	startingFolder = fileparts(which('cameraman.tif')); % Determine where demo folder is (works with all versions).
	if ~exist(startingFolder, 'dir')
		% If that folder doesn't exist, just start in the current folder.
		startingFolder = pwd;
	end
	% Get the name of the file that the user wants to use.
	defaultFileName = fullfile(startingFolder, '*.*');
	[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
	if baseFileName == 0
		% User clicked the Cancel button.
		return;
	end
	fullFileName = fullfile(folder, baseFileName);
	rgbImage = imread(fullFileName);
	imshow(rgbImage);
	title('Original Image', 'FontSize', fontSize);
	% Need to put up a color bar to get the size and location of the image right so we can "flicker" between
	% classified images and original image without the image shifting.
	colorbar;
	% Get the dimensions of the image.
	% numberOfColorChannels should be = 1 for a gray scale image, and 3 for an RGB color image.
	[rows, columns, numberOfColorChannels] = size(rgbImage);
	% Display it again but just on the left half of the figure so we can display the classified image next to it.
	subplot(1, 2, 1);
	imshow(rgbImage);
	title('Original Image', 'FontSize', fontSize);

	%-----------------------------------------------------------------------------------------------------------------------------
	% Set up figure properties:
	% Enlarge figure to full screen.
	set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.15, 1, 0.8]);
	% Get rid of tool bar and pulldown menus that are along top of figure.
	% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
	% Give a name to the title bar.
	set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')
	
	%-----------------------------------------------------------------------------------------------------------------------------
	% Get training set by having the user lassoo regions in the image for each class.
	% Each drawn region will be of roughly the same color, e.g. greenish, bluish, etc.
	% Each pixel in the training set will have a known, assigned class number.
	[pixelColors, meanColors, outlines] = GetClassMeans(rgbImage);
	if isempty(pixelColors)
		return;
	end
	% Extract just the RGB values.
	training = pixelColors(:, 1:3);
	% Extract just the group/class number of the region.
	group = pixelColors(:, 4);
	% meanColors = grpstats(training, group, 'mean')
	% Draw outlines over image.
	hold on;
	numberOfClasses = length(outlines);
	for k = 1 : numberOfClasses
		thisOutline = outlines{k};
		x = thisOutline(:, 1);
		y = thisOutline(:, 2);
		% Need to add first point as the final point otherwise the curve is not closed.
		x(end + 1) = x(1);
		y(end + 1) = y(1);
		plot(x, y, 'r', 'LineWidth', 2);
	end

	%-----------------------------------------------------------------------------------------------------------------------------
	% Get test/sample/unknown set - basically the whole image.
	% First, extract the individual red, green, and blue color channels.
	redChannel = rgbImage(:, :, 1);
	greenChannel = rgbImage(:, :, 2);
	blueChannel = rgbImage(:, :, 3);
	% Now put them into an N-by-3 matrix of RGB values.
	sample = [redChannel(:), greenChannel(:), blueChannel(:)];
	
	%-----------------------------------------------------------------------------------------------------------------------------
	% Do the KNN Classification and create a classified image, which is an image where the pixel value is the predicted class number.
	classifiedImage = ClassifyImage(sample, training, group, meanColors, rows, columns);
	
	% Display classified image.
	subplot(1, 2, 2);
	imshow(classifiedImage, []);
	numClasses = double(max(group));  % Need to cast to double for later use in the for loop.
	caption = sprintf('Classified Image with %d Color Classes', numClasses);
	title(caption, 'FontSize', fontSize);
	% Apply colormap where each class appears in the mean color for that particular class.
	colormap(gca, meanColors/255);
	colorbar;
	caxis([1, numberOfClasses]);
	
	%-----------------------------------------------------------------------------------------------------------------------------
	% Bring up a window showing all the class maps along with the masked RGB image showing the individual classes.
	figure;
	fontSize = 15; % Make the font a bit smaller since we'll be displaying more images.
	nRows = ceil(sqrt(double(2*numClasses + 1))); % To be used by subplot().
	% Display the original image in axes #1
	subplot(nRows, nRows, 1);
	imshow(rgbImage, []);
	title('Original RGB Image', 'FontSize', fontSize);		
	axesNumber = 2;
	for k = 1 : numClasses
		thisClass = classifiedImage == k;
		subplot(nRows, nRows, axesNumber);
		imshow(thisClass, []);
		caption = sprintf('Map for Class %d', k);
		title(caption, 'FontSize', fontSize);		
		
		% Mask the image using bsxfun() function to multiply the mask by each channel individually.
		maskedRgbImage = bsxfun(@times, rgbImage, cast(thisClass, 'like', rgbImage));
		subplot(nRows, nRows, axesNumber+1);
		imshow(maskedRgbImage, []);
		caption = sprintf('RGB Image of Class %d Only', k);
		title(caption, 'FontSize', fontSize);		
		axesNumber = axesNumber + 2;
		drawnow;
	end
	
	%-----------------------------------------------------------------------------------------------------------------------------
	% Set up figure properties:
	% Enlarge figure to full screen.
	set(gcf, 'Units', 'Normalized', 'OuterPosition', [0, 0.04, 1, 0.96]);
	% Get rid of tool bar and pulldown menus that are along top of figure.
	% set(gcf, 'Toolbar', 'none', 'Menu', 'none');
	% Give a name to the title bar.
	set(gcf, 'Name', 'Demo by ImageAnalyst', 'NumberTitle', 'Off')
	
	%-----------------------------------------------------------------------------------------------------------------------------
	% Plot the color clouds for each region.
	numClasses = length(outlines);
	for k = 1 : numClasses
		classIndexes = (group == k);
		if isempty(classIndexes)
			continue;
		end
		% 		fprintf('There are %d pixels in class #%d.\n', sum(classIndexes), k);
		% Make a 1-D RGB image of this region/class so we can plot its gamut with colorcloud.
		thisImage = double(cat(3, training(classIndexes, 1), training(classIndexes, 2), training(classIndexes, 3))) / 255;
		colorcloud(thisImage); % Comes up in a new figure window (can't use subplot) - nothing we can do about that.
		% Give the figure a name in the titlebar.
		caption = sprintf('Gamut of Class #%d', k);
		set(gcf, 'Name', caption, 'NumberTitle', 'Off')
		% fit the clouds on screen.
		set(gcf, 'Units', 'Normalized', 'OuterPosition', [(k-1)/numClasses, 0.2, 1/numClasses, 0.7]);
		drawnow;
	end

catch ME
	errorMessage = sprintf('Error in program %s, function %s(), at line %d.\n\nError Message:\n%s', ...
		mfilename, ME.stack(1).name, ME.stack(1).line, ME.message);
	WarnUser(errorMessage);
end

function classifiedImage = ClassifyImage(sample, training, group, meanColors, rows, columns)
try
	classifiedImage = [];	% Initialize so any error won't also throw an error about this variable not being defined.
	fontSize = 20;
	
	% Classify the whole image.
	%-----------------------------------------------------------------------------------------------------------------
	% Now do a K Nearest Neighbor Search.
	% Get the classes of the unknown data.
	% First collect all the training data into one tall array
% 	trainingCoords = [trainingCoords1; trainingCoords2];
	[closestClassIndexes, distancesOfTheIndexes] = knnsearch(double(training), double(sample), ...
		'NSMethod', 'exhaustive',...
		'k', 5,... % Get indexes of the 5 nearest points
		'distance', 'euclidean'); % Regular Pythagorean formula for distance

	% predictedClassIndexes is the linear indexes of the closest neighbors.
	% But we need to know the class numbers of those closest indexes.
	predictedClassNumbers = zeros(length(sample), 1);
	for row = 1 : size(closestClassIndexes)	% for every pixel in our sample set...
		% Find out all the class numbers.
		% Find out the indexes of the k Nearest Neighbors
		thesePixelIndexes = closestClassIndexes(row, :);
		% Find out the class numbers of those k Nearest Neighbors;
		theseClassNumbers = group(thesePixelIndexes);
		% Assign the most common class number to this pixel.
		predictedClassNumbers(row) = mode(theseClassNumbers);
	end
	% At this point, predictedClassNumbers is a vector of N classes where N is the number of pixels in the sample set.
	% Now we need to reshape it into an image.
	
	% Recombine classes of each pixel into a single, indexed image
	% where the value is the class that each pixel got assigned.
	classifiedImage = reshape(predictedClassNumbers, rows, columns);
catch ME
	errorMessage = sprintf('Error in program %s, function %s(), at line %d.\n\nError Message:\n%s', ...
		mfilename, ME.stack(1).name, ME.stack(1).line, ME.message);
	WarnUser(errorMessage);
end
return;


function [pixelColors, meanColors, outlines] = GetClassMeans(rgbImage)
try
	meanColors = [];	% Initialize
	pixelColors = [];	% Initialize
	outlines = [];		% Initialize
	[rows, columns, numberOfColorChannels] = size(rgbImage);
	axis on;
	title('Click to sample pixels colors.  Press Enter key when done.', 'FontSize', 20);
	hold on;
	% Maximize the window via undocumented Java call.
	% Reference: http://undocumentedmatlab.com/blog/minimize-maximize-figure-window
% 	MaximizeFigureWindow;
	
	% Extract the individual red, green, and blue color channels.
	redChannel = rgbImage(:, :, 1);
	greenChannel = rgbImage(:, :, 2);
	blueChannel = rgbImage(:, :, 3);
	
	% Get the class names:
	[numClasses, classNames] = GetClassNames()
	if isempty(classNames)
		return;
	end
	meanColors = zeros(numClasses, 3);
	for classIndex = 1 : numClasses
		titleString = sprintf('Draw sample pixels colors for class #%d, %s.', classIndex, classNames{classIndex});
		title(titleString, 'FontSize', 20);
		message = sprintf('Draw the sample pixels colors for class #%d, %s.', classIndex, classNames{classIndex});
		reply = questdlg(message, 'Continue?', 'OK', 'Quit', 'OK');
		% reply = '' for Upper right X, otherwise it's the exact wording.
		if strcmpi(reply, 'Quit')
			meanColors = [];
			meanColors = [];	% Make meanColors null/empty if they quit.
			pixelColors = [];	% Make meanColors null/empty if they quit.
			outlines = [];	% Make meanColors null/empty if they quit.
			break;
		end
		
		% Ask user to draw points.
		numPoints = 0;
		while numPoints <= 3  % Need at least a triangle so there is an area.
			if classIndex == 1
				% Ask user to draw freehand mask.
				message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
				uiwait(msgbox(message));
			end
			hFH = imfreehand(); % Actual line of code to do the drawing.
			% Create a binary image ("mask") from the ROI object.
			mask = hFH.createMask();
			xy = hFH.getPosition;
			numPoints = size(xy, 1);
			% Save outlines so the calling program can overlay them on the image.
			outlines{classIndex} = xy;
		end
		
		% Get just the pixels of this image that are within
		% the user drawn mask for this class region.
		redPixels = redChannel(mask);
		greenPixels = greenChannel(mask);
		bluePixels = blueChannel(mask);
		
		% If the user drew outside the axes, then there will be nan values in the pixel arrays.  
		% Remove the nan values or it will cause problems in the classification step.
		nanPixels = isnan(redPixels);
		redPixels(nanPixels) = [];
		greenPixels(nanPixels) = [];
		bluePixels(nanPixels) = [];
		
		% Pack the remaining "good" pixels for this class into an array 
		% that will hold all training pixels from all classes.
		thesePixelColors = [redPixels, greenPixels, bluePixels, classIndex * ones(length(bluePixels), 1)];
		if classIndex == 1
			pixelColors = thesePixelColors;
		else
			pixelColors = [pixelColors; thesePixelColors];
		end
		% Get the mean of the "good" pixels for this class.
		meanR = mean(redPixels);
		meanG = mean(greenPixels);
		meanB = mean(bluePixels);
		% Put this class's means into the array that holds means for all classes.
		meanColors(classIndex,:) = [meanR, meanG, meanB];
		
		% Post the mean color as text into an overlay over the image.
		message = sprintf('Red mean = %.2f\nGreen mean = %.2f\nBlue mean = %.2f', meanR, meanG, meanB);
		x = 10;
		y = (classIndex - 1) * rows/numClasses + 50;
		text(x, y, message, 'FontSize', 12, 'FontWeight', 'bold', 'Color', 'r');
		% 		msgboxh(message);
		fprintf('For the %d pixels in class #%d ("%s"), Red mean = %6.2f, Green mean = %6.2f, Blue mean = %6.2f\n', ...
			length(redPixels), classIndex, classNames{classIndex}, meanR, meanG, meanB);		
	end
catch ME
	errorMessage = sprintf('Error in program %s, function %s(), at line %d.\n\nError Message:\n%s', ...
		mfilename, ME.stack(1).name, ME.stack(1).line, ME.message);
	WarnUser(errorMessage);
end
return; % from GetClassMeans

	
%==========================================================================================================================
function [numClasses, classNames] = GetClassNames()
try
	% Ask user for number of classes.
	defaultValue = 3;
	titleBar = 'Enter an integer value';
	userPrompt = 'Enter the number of classes';
	caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
	if isempty(caUserInput),return,end % Bail out if they clicked Cancel.
	% Round to nearest integer in case they entered a floating point number.
	numClasses = round(str2double(cell2mat(caUserInput)));
	% Check for a valid integer.
	if isnan(numClasses)
		% They didn't enter a number.
		% They clicked Cancel, or entered a character, symbols, or something else not allowed.
		numClasses = defaultValue;
		message = sprintf('I said it had to be an integer.\nTry replacing the user.\nI will use %d and continue.', numClasses);
		uiwait(warndlg(message));
	end
	
	% Now ask for names
	for k = 1 : numClasses
		defaultClassNames{k} = sprintf('Class%d', k);
		editFieldPrompt{k} = sprintf('Enter name of class #%d', k);
	end
	titleBar = 'Enter class names';
	classNames = inputdlg(editFieldPrompt, titleBar, 1, defaultClassNames);
	if isempty(classNames),return,end % Bail out if they clicked Cancel.
	% Find out how many classes actually have names in them.
	for classIndex = 1 : numClasses
		if isempty(classNames{classIndex})
			numClasses = classIndex - 1;
			break;
		end
	end
	% Strip off any blank names.
	classNames = classNames(1:numClasses);
	
catch ME
	errorMessage = sprintf('Error in program %s, function %s(), at line %d.\n\nError Message:\n%s', ...
		mfilename, ME.stack(1).name, ME.stack(1).line, ME.message);
	WarnUser(errorMessage);
end
return; % from GetClassMeans

%==========================================================================================================================
function WarnUser(warningMessage)
fprintf('%s\n', warningMessage);
uiwait(warndlg(warningMessage));
