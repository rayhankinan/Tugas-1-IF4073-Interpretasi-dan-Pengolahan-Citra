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
            
            histRed = utils.Histogram.hist(obj.ImageData);
            histBlue = utils.Histogram.hist(obj.ImageData);
            histGreen = utils.Histogram.hist(obj.ImageData);
        end
        
        % Get Histogram Equalized Image
        function imageData = GetHistogramEqualizedImage(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            imageData = utils.Histogram.histeq(obj.ImageData);
        end
        
        % Get Histogram Specification Image
        function imageData = GetHistogramSpecificationImage(obj, target)
            arguments
                obj wrappers.GrayscaleImageWrapper
                target wrappers.BaseImageWrapper
            end
            
            if isa(target, 'wrappers.ColoredImageWrapper')
                redChan = utils.Histogram.histmatch(obj.ImageData, target.ImageData(:, :, 1));
                greenChan = utils.Histogram.histmatch(obj.ImageData, target.ImageData(:, :, 2));
                blueChan = utils.Histogram.histmatch(obj.ImageData, target.ImageData(:, :, 3));

                imageData = cat(3, redChan, greenChan, blueChan);
            else
                imageData = utils.Histogram.hismatch(obj.ImageData, target.ImageData);
            end
        end
        
        % Get Image Brightening
        function imageData = GetBrightening(obj, a, b)
            arguments
                obj wrappers.GrayscaleImageWrapper
                a double;
                b double;
            end
            
            imageData = a * obj.ImageData + b;
        end
        
        % Get Negative Image
        function imageData = GetNegative(obj)
            arguments
                obj wrappers.GrayscaleImageWrapper
            end
            
            imageData = 255 - obj.ImageData;
        end
        
        % Get Log Transformation
        function imageData = GetLogTransformation(obj, c)
            arguments
                obj wrappers.GrayscaleImageWrapper
                c double;
            end
            
            doubleImageData = im2double(obj.ImageData);
            
            doubleImageDataProcessed = c * log(1 + doubleImageData);
            
            imageData = im2uint8(doubleImageDataProcessed);
        end
        
        % Get Power Law Transformation
        function imageData = GetPowerTransformation(obj, c, gamma)
            arguments
                obj wrappers.GrayscaleImageWrapper
                c double;
                gamma double;
            end
            
            doubleImageData = im2double(obj.ImageData);
            
            doubleImageDataProcessed = c * doubleImageData .^ gamma;
            
            imageData = im2uint8(doubleImageDataProcessed);
        end
    end
end