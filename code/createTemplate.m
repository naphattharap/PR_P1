function [ pattern ] = createTemplate( data , namePattern )
%CREATETEMPLATE Given the samples in the data matrix, create a template
%using the namePattern method.
switch namePattern
    case 'grayscaleMean'
        %mean of the grayscale images
        pattern = squeeze(mean(data));
    case 'grayscaleMedian'
        %mean of the grayscale images
        pattern = squeeze(median(data));
    case Constants.TEMPLATE_MOUTH_MEAN
        %mean of the grayscale images
        pattern = squeeze(mean(data));
        
    case Constants.TEMPLATE_MOUTH_MEDIAN
        %mean of the grayscale images
        pattern = squeeze(median(data));
        
    case Constants.TEMPLATE_EYES_MEAN
        %mean of the grayscale images
        pattern = squeeze(mean(data));

    case Constants.TEMPLATE_EYES_AND_MOUTH_MEAN
        %mean of the grayscale images
        pattern = squeeze(mean(data));
        
    case Constants.TEMPLATE_MOUTH_CONTROL_POINT_MEAN
        %mean of the grayscale images
        pattern = squeeze(mean(data));
        
    case Constants.TEMPLATE_MOUTH_CONTROL_POINT_MEAN
        %mean of the grayscale images
        pattern = squeeze(median(data));
        
    case Constants.TEMPLATE_MOUTH_CONTOUR_MEAN
        %mean of the grayscale images
        pattern = squeeze(mean(data));
        
   case Constants.TEMPLATE_BINARY_IMAGES_MEAN
        %mean of the grayscale images
        pattern = squeeze(mean(data));
end

