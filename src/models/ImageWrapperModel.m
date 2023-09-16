classdef (Abstract) ImageWrapperModel
    properties (Abstract)
        ImageData {mustBeNumeric}
        Type {mustBeMember(Type, {"Colored", "Grayscale"})}
    end
    methods (Abstract)
        % Constructor
        function obj = ImageWrapperModel(imageData, type)
            obj.ImageData = imageData;
            obj.Type = type;
        end
        
        % Get Histogram
        getHistogram(obj)
        
        % Get Histogram Equalized
        getHistogramEqualized(obj)
        
        % Get Histogram Specification
        getHistogramSpecification(obj, target)
    end
end