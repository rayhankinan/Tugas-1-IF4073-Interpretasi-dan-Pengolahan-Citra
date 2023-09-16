classdef ColoredImageWrapperModel < ImageWrapperModel
    methods
        % Constructor
        function obj = ColoredImageWrapperModel(image)
            obj = obj@ImageWrapperModel(image, "Colored");
        end
        
        % Get Histogram
        function hist = getHistogram(obj)
            hist = imhist(obj.ImageData);
        end
        
        % Get Histogram Equalized
        function hist = getHistogramEqualized(obj)
            hist = histeq(obj.ImageData);
        end
        
        % Get Histogram Specification
        function hist = getHistogramSpecification(obj, target)
            hist = histeq(obj.ImageData, target.ImageData);
        end
    end
end