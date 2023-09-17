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
        
        % Get Histogram Equalized
        function [histRed, histGreen, histBlue] = GetHistogramEqualized(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            histRed = histeq(obj.ImageData);
            histBlue = histeq(obj.ImageData);
            histGreen = histeq(obj.ImageData);
        end
        
        % Get Histogram Specification
        function [histRed, histGreen, histBlue] = GetHistogramSpecification(obj, target)
            arguments
                obj wrappers.GrayscaleImageWrapper
                target wrappers.GrayscaleImageWrapper
            end
            
            histRed = histeq(obj.ImageData, target.ImageData);
            histBlue = histeq(obj.ImageData, target.ImageData);
            histGreen = histeq(obj.ImageData, target.ImageData);
        end
    end
end