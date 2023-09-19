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

        function newImage = histeq(imageData)
            arguments
                imageData uint8
            end %arguments

            % Compute histogram value
            oldHistogram = utils.Histogram.hist(imageData)

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
            newImage = zeros(m, n, 'uint8');
            for i = 1:m
                for j = 1:n
                    val = imageData(i, j);
                    newImage(i, j) = uint8(255 * cumulativeProbabilities(val + 1));
                end
            end
        end
    end
end