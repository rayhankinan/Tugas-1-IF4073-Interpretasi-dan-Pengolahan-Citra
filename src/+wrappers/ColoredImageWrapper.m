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
        
        % Check if Image is empty
        function isEmpty = IsEmpty(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            isEmpty = isempty(obj.ImageData);
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
        function [histRed, histGreen, histBlue] = GetHistogram(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            histRed = imhist(obj.ImageData(:, :, 1));
            histGreen = imhist(obj.ImageData(:, :, 2));
            histBlue = imhist(obj.ImageData(:, :, 3));
        end
        
        % Get Histogram Equalized Image
        function result = GetHistogramEqualizedImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            result = histeq(obj.ImageData);
        end
        
        % Get Histogram Specification Image
        function result = GetHistogramSpecificationImage(obj, target)
            arguments
                obj wrappers.ColoredImageWrapper
                target wrappers.ColoredImageWrapper
            end
            
            result = histeq(obj.ImageData, target.ImageData);
        end
        
        % Get Image Brightening
        function imageData = GetBrightening(obj, a, b)
            arguments
                obj wrappers.ColoredImageWrapper
                a double;
                b double;
            end
            
            imageData = a * obj.ImageData + b;
        end
        
        % Get Negative Image
        function imageData = GetNegative(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            imageData = 255 - obj.ImageData;
        end
        
        % Get Log Transformation
        function imageData = GetLogTransformation(obj, c)
            arguments
                obj wrappers.ColoredImageWrapper
                c double;
            end
            
            imageData = c * log(1 + double(obj.ImageData));
        end
    end
end
