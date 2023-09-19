classdef Histogram
    methods (Static)
        function histogram = hist(imageData)
            arguments
                imageData uint8
            end % arguments
            
            % Make a 1 dimensional array of zeros with length 256
            histogram = zeros(1, 256);
            
            % Loop through the image
            [m, n] = size(imageData);
            for i = 1:m
                for j = 1:n
                    % val + 1 because of arrays in MATLAB are one-indexed
                    % not zero-indexed
                    val = imageData(i, j);
                    histogram(val + 1) = histogram(val + 1) + 1;
                end
            end
        end
        
        function newImageData = histeq(imageData)
            arguments
                imageData uint8
            end %arguments
            
            % Compute histogram value
            oldHistogram = utils.Histogram.hist(imageData);
            
            % Make a 1 dimensional array of zeros with length 256 to store
            % probability values
            probabilities = zeros(1, 256, 'double');
            
            % Compute probabilities
            [m, n] = size(imageData);
            imageSize = m * n;
            for i = 1:256
                probabilities(i) = oldHistogram(i) / imageSize;
            end
            
            % Make a 1 dimensional array of zeros with length 256 to store
            % cumulative probability values
            cumulativeProbabilities = zeros(1, 256, 'double');
            for i = 1:256
                if i == 1
                    cumulativeProbabilities(i) = probabilities(i);
                else
                    cumulativeProbabilities(i) = cumulativeProbabilities(i - 1) + probabilities(i);
                end
            end
            
            % Compute new image data
            doubleImageData = zeros(m, n, 'double');
            for i = 1:m
                for j = 1:n
                    val = imageData(i, j);
                    doubleImageData(i, j) = cumulativeProbabilities(val + 1);
                end
            end
            
            % Convert to uint8
            newImageData = im2uint8(doubleImageData);
        end

        function newImageData = histmatch(inputData, referenceData)
            arguments
                inputData uint8
                referenceData uint8
            end %arguments

            % Process inputData
            
            % Compute histogram value
            inputHistogram = utils.Histogram.hist(inputData);
            
            % Make a 1 dimensional array of zeros with length 256 to store
            % probability values
            inputProbabilities = zeros(1, 256, 'double');
            
            % Compute probabilities
            [m, n] = size(inputData);
            imageSize = m * n;
            for i = 1:256
                inputProbabilities(i) = inputHistogram(i) / imageSize;
            end
            
            % Make a 1 dimensional array of zeros with length 256 to store
            % cumulative probability values
            cumulativeInputProbabilities = zeros(1, 256, 'double');
            for i = 1:256
                if i == 1
                    cumulativeInputProbabilities(i) = inputProbabilities(i);
                else
                    cumulativeInputProbabilities(i) = cumulativeInputProbabilities(i - 1) + inputProbabilities(i);
                end
            end

            % Find the corresponding map for each possible grayscale
            % value
            inputMap = zeros(1, 256, 'uint8');
            for i = 1:256
                inputMap(i) = uint8(round(cumulativeInputProbabilities(i) * 255));
            end

            % Process referenceData
            
            % Compute histogram value
            referenceHistogram = utils.Histogram.hist(referenceData);
            
            % Make a 1 dimensional array of zeros with length 256 to store
            % probability values
            referenceProbabilities = zeros(1, 256, 'double');
            
            % Compute probabilities
            [m, n] = size(referenceData);
            imageSize = m * n;
            for i = 1:256
                referenceProbabilities(i) = referenceHistogram(i) / imageSize;
            end
            
            % Make a 1 dimensional array of zeros with length 256 to store
            % cumulative probability values
            cumulativeReferenceProbabilities = zeros(1, 256, 'double');
            for i = 1:256
                if i == 1
                    cumulativeReferenceProbabilities(i) = referenceProbabilities(i);
                else
                    cumulativeReferenceProbabilities(i) = cumulativeReferenceProbabilities(i - 1) + referenceProbabilities(i);
                end
            end

            % Find the corresponding map for each possible grayscale
            % value
            referenceMap = zeros(1, 256, 'uint8');
            for i = 1:256
                referenceMap(i) = uint8(round(cumulativeReferenceProbabilities(i) * 255));
            end

            % Create inverse mapping
            inverseMap = zeros(1, 256, 'uint8');
            for i = 1:256
                s = inputMap(i);
                currMin = abs(s - cumulativeReferenceProbabilities(1) * 255);
                currMinIdx = 1;
                for j = 1:256
                    if abs(s - cumulativeReferenceProbabilities(j) * 255) < currMin
                        currMin = abs(s - cumulativeReferenceProbabilities(j) * 255);
                        currMinIdx = j;
                    end
                end

                inverseMap(i) = currMinIdx;
            end

            % Generate image data
            [m, n] = size(inputData);
            newImageData = zeros(m, n, 'uint8');
            for i = 1:m
                for j = 1:n
                    newImageData(i, j) = inverseMap(inputMap(inputData(i, j) + 1) + 1);
                end
            end
        end
    end
end