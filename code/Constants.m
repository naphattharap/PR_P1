classdef Constants
    properties( Constant = true )
        % constant for selecting feature from original images.
        EXTRACT_GRAYSCALE_MOUTH = "grayscaleMouth";
        EXTRACT_GRAYSCALE_EYES = "grayscaleEyes";
        EXTRACT_GRAYSCALE_EYES_AND_MOUTH = "grayscaleEyesMouth";
        EXTRACT_CONTROL_POINTS_MOUTH1 = "controlPointMouth1";
        EXTRACT_CONTROL_POINTS_MOUTH2 = "controlPointMouth2";
        EXTRACT_CONTROL_POINTS_MOUTH3 = "controlPointMouth3";
        EXTRACT_PICTURE_CONTOUR = "pictureContour";
        EXTRACT_PICTURE_BINARY = "pictureBinary";
        
        % constant for template method creation
        % mouth
        TEMPLATE_MOUTH_MEAN = "mouthMean";
        TEMPLATE_MOUTH_MEDIAN = "mouthMedian";
        TEMPLATE_MOUTH_CONTOUR_MEAN = "mouthContourMean";
        TEMPLATE_MOUTH_CONTROL_POINT_MEAN = "mouthControlPointMean";
        % eyes
        TEMPLATE_EYES_MEAN = "eyesMean";
        TEMPLATE_EYES_MEDIAN = "eyesMedian";
        % mouth and eyes
        TEMPLATE_EYES_AND_MOUTH_MEAN = "eyesMouthMean";
        
        TEMPLATE_BINARY_IMAGES_MEAN = "binaryImageMean";
        
    end
end
