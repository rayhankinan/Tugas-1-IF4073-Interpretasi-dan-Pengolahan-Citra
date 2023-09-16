classdef GrayscaleImageWrapperModel < ImageWrapperModel
    methods
        % Constructor
        function obj = GrayscaleImageWrapperModel(image)
            obj = obj@ImageWrapperModel(image, "Grayscale");
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