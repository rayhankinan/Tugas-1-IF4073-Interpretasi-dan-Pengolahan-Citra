classdef ImageWrapperFactory
    methods (Static)
        function wrapper = create(imageData)
            if size(imageData, 3) == 3
                wrapper = wrappers.ColoredImageWrapper(imageData);
            else
                wrapper = wrappers.GrayscaleImageWrapper(imageData);
            end
        end
    end
end