classdef GrayscaleImageWrapper < wrappers.BaseImageWrapper
    methods
        % Constructor
        function obj = GrayscaleImageWrapper(imageData)
            arguments
                imageData uint8
            end
            
            obj.ImageData = imageData;
            obj.Type = 'grayscale';
        end
        
        % Check if Image is empty
        function isEmpty = IsEmpty(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            isEmpty = isempty(obj.ImageData);
        end
        
        % Get Image Data
        function data = GetImageData(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            data = obj.ImageData;
        end
        
        % Get Type
        function type = GetType(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            type = obj.Type;
        end
        
        % Get Histogram
        function [histRed, histGreen, histBlue] = GetHistogram(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            histRed = imhist(obj.ImageData);
            histBlue = imhist(obj.ImageData);
            histGreen = imhist(obj.ImageData);
        end
        
        % Get Histogram Equalized Image
        function imageData = GetHistogramEqualizedImage(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            imageData = histeq(obj.ImageData);
        end
        
        % Get Histogram Specification Image
        function imageData = GetHistogramSpecificationImage(obj, target)
            arguments
                obj wrappers.GrayscaleImageWrapper
                target wrappers.GrayscaleImageWrapper
            end
            
            imageData = histeq(obj.ImageData, target.ImageData);
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
        
        % Get Power Law Transformation
        function imageData = GetPowerLawTransformation(obj, c, gamma)
            arguments
                obj wrappers.ColoredImageWrapper
                c double;
                gamma double;
            end
            
            imageData = c * double(obj.ImageData) .^ gamma;
        end
    end
end