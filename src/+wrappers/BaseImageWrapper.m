classdef (Abstract) BaseImageWrapper
    properties
        ImageData {mustBeNumeric}
        Type {mustBeMember(Type, ['grayscale', 'color'])}
    end
    
    methods
        % Get Histogram
        getHistogram(obj)
        
        % Get Histogram Equalized
        getHistogramEqualized(obj)
        
        % Get Histogram Specification
        getHistogramSpecification(obj, target)
        
        % Save Image
        saveImage(obj, path)
    end
end