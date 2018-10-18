
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

% emotionsUsed = [6]; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% EXTRACT DATA %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[imagesData shapeData labels] = extractData('../CKDB', emotionsUsed);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% DIVIDE DATA (TRAIN/TEST) WITH CROSS VALIDATION  %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 3;
indexesCrossVal = crossvalind('Kfold',size(imagesData,1),K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TEST DIFFERENT TEMPLATES METHODS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[accuracy confMatrix] = testMethod(imagesData , labels, emotionsUsed ,  'grayscaleMean', 'euclidean', indexesCrossVal)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% EXTRACT FEATURE EYES & MOUTH %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[features] = extractFeaturesFromData(imagesData, shapeData, 'eyesMouth');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% DIVIDE DATA (TRAIN/TEST) WITH CROSS VALIDATION  %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 3;
indexesCrossVal = crossvalind('Kfold',size(features,1),K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TEST DIFFERENT TEMPLATES METHODS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'eyesMouthMean', 'euclidean', indexesCrossVal);
% error [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthMedian', 'seuclidean', indexesCrossVal)
disp('EYES & MOUTH FEATURE Accuracy');
disp(accuracy);
disp('EYES & MOUTH  FEATURE ConfMatrix')
disp(confMatrix);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% EXTRACT FEATURE MOUTH %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[features] = extractFeaturesFromData(imagesData, shapeData, 'mouth');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% DIVIDE DATA (TRAIN/TEST) WITH CROSS VALIDATION  %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 3;
indexesCrossVal = crossvalind('Kfold',size(features,1),K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TEST DIFFERENT TEMPLATES METHODS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthMean', 'euclidean', indexesCrossVal);
% error [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthMedian', 'seuclidean', indexesCrossVal)
disp('MOUTH FEATURE Accuracy');
disp(accuracy);
disp('MOUTH FEATURE ConfMatrix')
disp(confMatrix);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% EXTRACT FEATURE EYES %%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[features] = extractFeaturesFromData(imagesData, shapeData, 'eyes');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% DIVIDE DATA (TRAIN/TEST) WITH CROSS VALIDATION  %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = 3;
indexesCrossVal = crossvalind('Kfold',size(features,1),K);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% TEST DIFFERENT TEMPLATES METHODS %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'eyesMean', 'euclidean', indexesCrossVal);

disp('EYES FEATURE Accuracy');
disp(accuracy);
disp('EYES FEATURE ConfMatrix')
disp(confMatrix);
% error [accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthMedian', 'seuclidean', indexesCrossVal)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Contour Mouth %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[features] = extractFeaturesFromData(imagesData, shapeData, 'mouthContour');
K = 3;
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
[accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthContourMean', 'euclidean', indexesCrossVal);
disp('Lip contour  accuracy');
disp(accuracy);
disp('Lip contour confMatrix')
disp(confMatrix);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Control point %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[features] = extractFeaturesFromData(imagesData, shapeData, 'mouthControlPoints');
K = 3;
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
[accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthControlPointMean', 'euclidean', indexesCrossVal);
disp('Lip control points distance accuracy');
disp(accuracy);
disp('Lip control points distance confMatrix')
disp(confMatrix);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Control point#2 %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[features] = extractFeaturesFromData(imagesData, shapeData, 'mouthControlPoints4960');
K = 3;
indexesCrossVal = crossvalind('Kfold',size(features,1),K);
[accuracy confMatrix] = testMethod(features , labels, emotionsUsed ,  'mouthControlPoint4960Mean', 'euclidean', indexesCrossVal);
disp('Mouth control points#2 accuracy');
disp(accuracy);
disp('Mouth control points#2 confMatrix')
disp(confMatrix);