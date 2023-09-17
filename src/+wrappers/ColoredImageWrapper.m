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
        function [histRed, histGreen, histBlue] = GetHistogram(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            histRed = imhist(obj.ImageData(:, :, 1));
            histGreen = imhist(obj.ImageData(:, :, 2));
            histBlue = imhist(obj.ImageData(:, :, 3));
        end
        
        % Get Histogram Equalized
        function [histRed, histGreen, histBlue] = GetHistogramEqualized(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            histRed = histeq(obj.ImageData(:, :, 1));
            histGreen = histeq(obj.ImageData(:, :, 2));
            histBlue = histeq(obj.ImageData(:, :, 3));
        end
        
        % Get Histogram Specification
        function [histRed, histGreen, histBlue] = GetHistogramSpecification(obj, target)
            arguments
                obj wrappers.ColoredImageWrapper
                target wrappers.ColoredImageWrapper
            end
            
            histRed = histeq(obj.ImageData(:, :, 1), target.ImageData(:, :, 1));
            histGreen = histeq(obj.ImageData(:, :, 2), target.ImageData(:, :, 2));
            histBlue = histeq(obj.ImageData(:, :, 3), target.ImageData(:, :, 3));
        end
    end
end