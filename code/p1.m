
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%% P1 - RECONEIXEMENT DE PATRONS %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%    TEMPLATE MATCHING          %%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%choose the emotion labels we want to classify in the database
% 0:Neutral
% 1:Angry
% 2:Bored
% 3:Disgust
% 4:Fear
% 5:Happiness
% 6:Sadness
% 7:Surprise
emotionsUsed = [0 1 3 4 5 6 7];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% EXTRACT DATA %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% extract all data (images, control points of facial landmarks
% and labels from database under folder name CKDB
[imagesData shapeData labels] = extractData('../CKDB', emotionsUsed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% DIVIDE DATA (TRAIN/TEST) WITH CROSS VALIDATION  %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3-Fold Cross Validation will shuffle data and split into 3 groups.
K = 3;
indexesCrossVal = crossvalind('Kfold',size(imagesData,1),K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TEST DIFFERENT TEMPLATES METHODS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Test all data with grayscale mean and measure by euclidean distance.
[accuracy confMatrix] = testMethod(imagesData , labels, emotionsUsed , 'grayscaleMean', 'euclidean', indexesCrossVal);
reportResult("Grayscale", "euclidean", accuracy, confMatrix);



% Start experiments
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Template: CONTROL POINT (facial landmarks)
% Experiment in 3 patterns
% 1) MOUTH1: sum of distance between facial landmark  
%    49, 55 and 52, 58
% 2) MOUTH2: sum of distance from facial landmark number 49 to 60
% 3) MOUTH3: sum of distance from facial landmark number 34 and 58
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% "chebychev" "spearman"
compareMethods = ["euclidean", "minkowski", "cityblock", "hamming","jaccard"];


% Pattern 3 gives the best result.
[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_CONTROL_POINTS_MOUTH3);
% shuffle and split data into k folder.
indexesCrossVal = crossvalind('Kfold',size(features,1),K);

% test pattern mouth 3 with different comparison methods.
for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthControlPointMean', compareMethods(i), indexesCrossVal);
    reportResult("Control point 34, 58 mean", compareMethods(i), accuracy, confMatrix);
    %[accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthControlPointMedian', compareMethods(i), indexesCrossVal);
    %reportResult("Control point 34, 58 median ", compareMethods(i), accuracy, confMatrix)
end

% Pattern 1
[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_CONTROL_POINTS_MOUTH1);
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  Constants.TEMPLATE_MOUTH_CONTROL_POINT_MEAN, compareMethods(i), indexesCrossVal);
    reportResult("Control point pattern#1", compareMethods(i), accuracy, confMatrix);
end

% Pattern 2
[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_CONTROL_POINTS_MOUTH2);
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  Constants.TEMPLATE_MOUTH_CONTROL_POINT_MEAN, compareMethods(i), indexesCrossVal);
    reportResult("Control point pattern#2", compareMethods(i), accuracy, confMatrix);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Template: Eyes and Mouth Grayscale
% Experiment in 3 patterns
% 1) Eyes 
% 2) Mouth (best result)
% 3) Eyes and Mouth 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_GRAYSCALE_EYES_AND_MOUTH);
% shuffle and split data into k folder.
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
compareMethods = ["euclidean", "minkowski", "cityblock", "hamming"];
for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  Constants.TEMPLATE_EYES_AND_MOUTH_MEAN, compareMethods(i), indexesCrossVal);
    reportResult("Template: Eyes and Mouth", compareMethods(i), accuracy, confMatrix);
end

% Mouth
[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_GRAYSCALE_MOUTH);
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  Constants.TEMPLATE_MOUTH_MEAN, compareMethods(i), indexesCrossVal);
    reportResult("Template: Grayscale mouth", compareMethods(i), accuracy, confMatrix);
end

% Eyes 
[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_GRAYSCALE_EYES);
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  Constants.TEMPLATE_EYES_MEAN, compareMethods(i), indexesCrossVal);
    reportResult("Template: Grayscale eyes", compareMethods(i), accuracy, confMatrix);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Binary image at mouth area
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_PICTURE_BINARY);
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
compareMethods = ["euclidean", "minkowski", "cityblock", "hamming"];
for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  Constants.TEMPLATE_BINARY_IMAGES_MEAN, compareMethods(i), indexesCrossVal);
    reportResult("Template: Binary image", compareMethods(i), accuracy, confMatrix);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Template Contour Mouth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[features] = extractFeaturesFromData(imagesData, shapeData, Constants.EXTRACT_PICTURE_CONTOUR);
indexesCrossVal = crossvalind('Kfold',size(features,1),K);

for i = 1:length(compareMethods)
    [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  Constants.TEMPLATE_MOUTH_CONTOUR_MEAN, compareMethods(i), indexesCrossVal);
    reportResult("Template: Contour mouth", compareMethods(i), accuracy, confMatrix);
end
