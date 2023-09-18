classdef (Abstract) BaseImageWrapper
    properties
        ImageData uint8 {mustBeNumeric}
        Type string {mustBeMember(Type, {'grayscale', 'color'})}
    end
    
    methods
        % Check if Image is empty
        IsEmpty(obj)
        
        % Get Image Data
        GetImageData(obj)
        
        % Get Image Type
        GetType(obj)
        
        % Get Histogram
        GetHistogram(obj)
        
        % Get Histogram Equalized
        GetHistogramEqualized(obj)
        
        % Get Histogram Specification
        GetHistogramSpecification(obj, target)
        
        % Get Image Brightening
        GetBrightening(obj, a, b)
        
        % Get Negative Image
        GetNegative(obj)
        
        % Get Log Transformation
        GetLogTransformation(obj, c)
        
        % Get Power Law Transformation
        GetPowerLawTransformation(obj, c, gamma)
    end
end