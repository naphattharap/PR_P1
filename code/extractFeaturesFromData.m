function [ features ] = extractFeaturesFromData( data , featureType )
%EXCTRACTFEATURESFROMDATA Summary of this function goes here
%   Detailed explanation goes here
    switch featureType
        case 'grayscale'
            features = reshape(data,size(data,1),128*128);
        case 'mouth'
            rowIdx = 70; 
            columnIdx = 35; % row, column
            height = 35; 
            width = 60; % heigh, width
            features = extractFeature(data, rowIdx, columnIdx, width, height);
        case 'eyes'  
            % pixel location
            rowIdx = 1; 
            columnIdx = 10; 
            height = 40; 
            width = 110;
            features = extractFeature(data, rowIdx, columnIdx, width, height);
         case 'eyesMouth'
             % pixel location for eyes
             rowIdxEyes = 1; 
             columnIdxEyes = 18;
             heightEyes = 32; 
    
             % pixel location for mouth
             rowIdxMouth = 72; 
             columnIdxMouth = columnIdxEyes; % row, column
             heightMouth = 30;
             % use the same width for 2 images
             width = 100; 
             [numberImage,row, col] = size(data);
             % initialize matrix to store extracted feature.
             extractedFeature = zeros(numberImage, (heightEyes + heightMouth), width);
             for i = 1:numberImage
                mxImage = data(i, : , : ); % get image data from matrix Nx128x128
                oriImage = reshape(mxImage, row, col);
                convertedImage = uint8(oriImage);
                % eyes
                image1 = convertedImage(rowIdxEyes:rowIdxEyes+heightEyes-1, columnIdxEyes:columnIdxEyes+width-1,:);
                % mouth
                image2 = convertedImage(rowIdxMouth:rowIdxMouth+heightMouth-1, columnIdxMouth:columnIdxMouth+width-1,:);
                % join eyes and mouth
                image = [image1;image2];
%                 imshow(image)
           
                extractedFeature(numberImage,:,:) = image;  
            end
            features = extractedFeature;
            %features = reshape(extractedFeature,size(extractedFeature,1),(heightMouth+heightEyes)*width);
 
    end
end
