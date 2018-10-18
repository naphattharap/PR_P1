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
        case 'mouthMean'
            %mean of the grayscale images
            pattern = squeeze(mean(data));
        case 'mouthMedian'
            %mean of the grayscale images
            pattern = squeeze(median(data));
        case 'eyesMean'
            %mean of the grayscale images
            pattern = squeeze(mean(data));
        case 'eyesMedian'
            %mean of the grayscale images
            pattern = squeeze(median(data));
        case 'eyesMouthMean'
            %mean of the grayscale images
            pattern = squeeze(mean(data));
        case 'eyesMouthMedian'
            %mean of the grayscale images
            pattern = squeeze(median(data));
end

