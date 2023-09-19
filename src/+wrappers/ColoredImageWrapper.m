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
            
            histRed = utils.Histogram.hist(obj.ImageData(:, :, 1));
            histGreen = utils.Histogram.hist(obj.ImageData(:, :, 2));
            histBlue = utils.Histogram.hist(obj.ImageData(:, :, 3));
        end
        
        % Get Histogram Equalized Image
        function imageData = GetHistogramEqualizedImage(obj)
            arguments
                obj wrappers.ColoredImageWrapper
            end
            
            % Equalize the histogram for each channel
            redChan = utils.Histogram.histeq(obj.ImageData(:, :, 1));
            greenChan = utils.Histogram.histeq(obj.ImageData(:, :, 2));
            blueChan = utils.Histogram.histeq(obj.ImageData(:, :, 3));
            
            imageData = cat(3, redChan, greenChan, blueChan);
        end
        
        % Get Histogram Specification Image
        function imageData = GetHistogramSpecificationImage(obj, target)
            arguments
                obj wrappers.ColoredImageWrapper
                target wrappers.ColoredImageWrapper
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
