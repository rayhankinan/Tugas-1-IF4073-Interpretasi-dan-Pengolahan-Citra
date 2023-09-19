classdef Histogram
    methods (Static)
        function histogram = hist(imageData)
            arguments
                imageData uint8
            end % arguments
            
            % Make an 1 dimensional array of zeros with length 256
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
    end
end