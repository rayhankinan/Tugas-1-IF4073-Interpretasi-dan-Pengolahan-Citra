classdef ColoredImageWrapper < wrappers.BaseImageWrapper
    methods
        % Constructor
        function obj = ColoredImageWrapper(image)
            obj.ImageData = image;
            obj.Type = 'color';
        end
        
        % Get Histogram
        function hist = GetHistogram(obj)
            hist = imhist(obj.ImageData);
        end
        
        % Get Histogram Equalized
        function hist = GetHistogramEqualized(obj)
            hist = histeq(obj.ImageData);
        end
        
        % Get Histogram Specification
        function hist = GetHistogramSpecification(obj, target)
            hist = histeq(obj.ImageData, target.ImageData);
        end
        
        % Save Image
        function SaveImage(obj, path)
            imwrite(obj.ImageData, path);
        end
    end
end