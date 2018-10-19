function [features] = extractFeature(data, rowIdx, columnIdx, width, height)
%extractFeature Extract feature from original image data at specific location
%

%out = im(r:r+h-1, c:c+w-1,:);
[totalNumberImages,mxRow,mxColumn] = size(data);
featuresData = zeros(totalNumberImages,height,width);
numberImage = 1;

for i = 1:totalNumberImages
    mxImage = data(i, : , : ); % get image data from matrix Nx128x128
    oriImage = reshape(mxImage, mxRow, mxColumn);
    convertedImage = uint8(oriImage);
    % imshow(convertedImage);
    % image = image(r:r+h-1, c:c+w-1,:); % crop image
    featureImage = imcrop(convertedImage,[columnIdx rowIdx width-1 height-1]); % crop image
    % image = imadjust(image,[0.3 0.9],[]); % adjust
    
    % imshow(featureImage)
    % store grayscale image
    featuresData(numberImage,:,:) = featureImage;
    numberImage = numberImage + 1;
    
end
features = reshape(featuresData,size(featuresData,1),height*width);
end

