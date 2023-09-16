classdef (Abstract) BaseImageWrapper
    properties
        ImageData {mustBeNumeric}
        Type {mustBeMember(Type, ['grayscale', 'color'])}
    end
    
    methods
        % Get Histogram
        GetHistogram(obj)
        
        % Get Histogram Equalized
        GetHistogramEqualized(obj)
        
        % Get Histogram Specification
        GetHistogramSpecification(obj, target)
        
        % Save Image
        SaveImage(obj, path)
    end
end