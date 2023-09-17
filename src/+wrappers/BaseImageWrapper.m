classdef (Abstract) BaseImageWrapper
    properties
        ImageData uint8 {mustBeNumeric}
        Type string {mustBeMember(Type, {'grayscale', 'color'})}
    end
    
    methods
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
    end
end