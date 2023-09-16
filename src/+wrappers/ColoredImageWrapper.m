classdef ColoredImageWrapper < wrappers.BaseImageWrapper
    methods
        % Constructor
        function obj = ColoredImageWrapper(image)
            obj.ImageData = image;
            obj.Type = 'color';
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
        
        % Save Image
        function saveImage(obj, path)
            imwrite(obj.ImageData, path);
        end
    end
end