classdef HistogramModel < handle
    %MODEL Application data model.
    
    properties (SetAccess = private)
        % Application data.
        ImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
    end % properties (SetAccess = private)
    
    events (NotifyAccess = private)
        % Event broadcast when the data is changed.
        DataChanged
    end % events (NotifyAccess = private)
    
    methods
        function SetWrapper(obj, imageWrapper)
            arguments
                obj models.HistogramModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.ImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % setFilepath
        
        function ResetModel(obj)
            arguments
                obj models.HistogramModel
            end
            
            % Reset the image wrapper.
            obj.ImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % reset
    end % methods
end % classdef