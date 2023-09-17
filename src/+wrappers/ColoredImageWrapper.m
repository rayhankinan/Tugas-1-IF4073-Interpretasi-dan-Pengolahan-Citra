classdef ColoredImageWrapper < wrappers.BaseImageWrapper
    methods
        % Constructor
        function obj = ColoredImageWrapper(imageData)
            arguments
                imageData uint8;
            end
            
            obj.ImageData = imageData;
            obj.Type = 'color';
        end
        
        % Get Image Data
        function data = GetImageData(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            data = obj.ImageData;
        end
        
        % Get Type
        function type = GetType(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            type = obj.Type;
        end
        
        % Get Histogram
        function hist = GetHistogram(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            hist = imhist(obj.ImageData);
        end
        
        % Get Histogram Equalized
        function hist = GetHistogramEqualized(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            hist = histeq(obj.ImageData);
        end
        
        % Get Histogram Specification
        function hist = GetHistogramSpecification(obj, target)
            arguments
                obj wrappers.ColoredImageWrapper
                target wrappers.ColoredImageWrapper
            end
            
            hist = histeq(obj.ImageData, target.ImageData);
        end
    end
end