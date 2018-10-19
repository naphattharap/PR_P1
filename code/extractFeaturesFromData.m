function [ features ] = extractFeaturesFromData( data , shapeData, featureType )
%EXCTRACTFEATURESFROMDATA Summary of this function goes here
%   Detailed explanation goes here
switch featureType
    case 'grayscale'
        features = reshape(data,size(data,1),128*128);
        
    case Constants.EXTRACT_GRAYSCALE_MOUTH
        rowIdx = 70;
        columnIdx = 35; % row, column
        height = 35;
        width = 60; % heigh, width
        features = extractFeature(data, rowIdx, columnIdx, width, height);
        
        
    case Constants.EXTRACT_GRAYSCALE_EYES
        % pixel location
        rowIdx = 1;
        columnIdx = 10;
        height = 35;
        width = 110;
        features = extractFeature(data, rowIdx, columnIdx, width, height);
        
        
    case Constants.EXTRACT_GRAYSCALE_EYES_AND_MOUTH
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
            %imshow(image)
            
            extractedFeature(numberImage,:,:) = image;
        end
        features = extractedFeature;
        %features = reshape(extractedFeature,size(extractedFeature,1),(heightMouth+heightEyes)*width);
        
    case Constants.EXTRACT_CONTROL_POINTS_MOUTH1
        % take shape data
        [totalNumberData,row,column] = size(data);
        mouthEdgeDinstance = zeros(totalNumberData, 1,2);
        
        for i = 1:totalNumberData
            % mxImage = data(i, : , : ); % get image data from matrix Nx128x128
            % oriImage = reshape(mxImage, row, column);
            % convertedImage = uint8(oriImage);
            
            % get control point at number 49, 55 and 52, 58
            lipEdge1 = shapeData(i, 52, 1:2);
            x1 = lipEdge1(1, :, 1);
            y1 = lipEdge1(1, :, 2);
            lipEdge2 = shapeData(i, 58, 1:2);
            x2 = lipEdge2(1, :, 1);
            y2 = lipEdge2(1, :, 2);
            distance1 = sqrt((x2-x1)^2+(y2-y1)^2);
            
            % imshow(convertedImage);
            % hold on;
            % plot([lipEdge1(:,:,1) lipEdge2(:,:,1)], [lipEdge1(:,:,2) lipEdge2(:,:,2)], 'r*', 'LineWidth', 20, 'MarkerSize', 15);
            % hold off;
            lipEdge49 = shapeData(i, 49, 1:2);
            x3 = lipEdge49(1, :, 1);
            y3 = lipEdge49(1, :, 2);
            
            lipEdge55 = shapeData(i, 55, 1:2);
            x4 = lipEdge55(1, :, 1);
            y4 = lipEdge55(1, :, 2);
            distance2 = sqrt((x4-x3)^2+(y4-y3)^2);
            
            mouthEdgeDinstance(i,1,1) = distance1;
            mouthEdgeDinstance(i,1,2) = distance2;
            
            %disp(['distance1 ', num2str(distance1)]);
            %disp(['distance2 ', num2str(distance2)]);
        end
        features = mouthEdgeDinstance;
        
    case Constants.EXTRACT_CONTROL_POINTS_MOUTH2
        % find distance of landmark 49 to 60
        % take shape data
        [totalNumberData,row,column] = size(data);
        mouthPointDistance = zeros(totalNumberData, 1,1);
        
        for i = 1:totalNumberData
            % mxImage = data(i, : , : ); % get image data from matrix Nx128x128
            % oriImage = reshape(mxImage, row, column);
            % convertedImage = uint8(oriImage);
            
            % get control point at number 49, 55 and 52, 58
            sumDistance = 0;
            for j = 49:59
                point1 = shapeData(i, j, 1:2);
                x1 = point1(1, :, 1);
                y1 = point1(1, :, 2);
                
                point2 = shapeData(i, j+1, 1:2);
                x2 = point2(1, :, 1);
                y2 = point2(1, :, 2);
                
                sumDistance =  sumDistance + sqrt((x2-x1)^2+(y2-y1)^2);
            end
            % from point number 60 to 49
            point1 = shapeData(i, 60, 1:2);
            x1 = point1(1, :, 1);
            y1 = point1(1, :, 2);
            
            point2 = shapeData(i,49, 1:2);
            x2 = point2(1, :, 1);
            y2 = point2(1, :, 2);
            sumDistance =  sumDistance + sqrt((x2-x1)^2+(y2-y1)^2);
            mouthPointDistance(i, 1, 1) = sumDistance;
            %disp(['sum of distance: ', num2str(sumDistance)]);
        end
        features = mouthPointDistance;
        
    case Constants.EXTRACT_CONTROL_POINTS_MOUTH3
        % find distance of landmark 34 and 58
        % take shape data
        [totalNumberData,row,column] = size(data);
        mouthPointsDistance = zeros(totalNumberData, 1,1);
        sumDistance = 0;
        for i = 1:totalNumberData
            
            % get control point data at number 34 (nose) 58 (bottom lip)
            point1 = shapeData(i, 34, 1:2);
            x1 = point1(1, :, 1);
            y1 = point1(1, :, 2);
            
            point2 = shapeData(i, 58, 1:2);
            x2 = point2(1, :, 1);
            y2 = point2(1, :, 2);
            sumDistance =  sumDistance + sqrt((x2-x1)^2+(y2-y1)^2);
            mouthPointsDistance(i, 1, 1) = sumDistance;
            %disp(['sum of distance: ', num2str(sumDistance)]);
        end
        features = mouthPointsDistance;
        
    case Constants.EXTRACT_PICTURE_CONTOUR
        [m,n,o] = size(data);
        rowIdx = 70;
        columnIdx = 30;
        height = 35;
        width = 70;
        [totalNumberData,row,column] = size(data);
        mouthContourImages = zeros(totalNumberData, height,width);
        for i = 1:m
            mxImage = data(i, : , : ); % get image data from matrix Nx128x128
            oriImage = reshape(mxImage, row, column);
            convertedImage = uint8(oriImage);
            featureImage = imcrop(convertedImage,[columnIdx rowIdx width-1 height-1]); % crop image
            % imshow(edge(featureImage));
            % imshow(featureImage);
            mask = zeros(size(featureImage));
            mask(1:height,1:width) = 1;
            bw = activecontour(featureImage, mask, 100);%, 'edge'
            % imshow(bw);
            mouthContourImages(i,:,:) = bw;
        end
        features = mouthContourImages;
        
    case Constants.EXTRACT_PICTURE_BINARY
        [m,n,o] = size(data);
        rowIdx = 72;
        columnIdx = 32;
        height = 38;
        width = 65;
        [totalNumberData,row,column] = size(data);
        mouthImages = zeros(totalNumberData, height,width);
        for i = 1:m
            mxImage = data(i, : , : ); % get image data from matrix Nx128x128
            oriImage = reshape(mxImage, row, column);
            convertedImage = uint8(oriImage);
            featureImage = imcrop(convertedImage,[columnIdx rowIdx width-1 height-1]); % crop image
            bw1 = imbinarize(featureImage);
            bw1 = bwareaopen(bw1,50);
            % imshow(bw1)
            mouthImages(i,:,:) = bw1;
            % bw = imadjust(featureImage);
            % imshow(bw);
            % mouthImages(i,:,:) = bw;
        end
        features = mouthImages;
        
end
end
