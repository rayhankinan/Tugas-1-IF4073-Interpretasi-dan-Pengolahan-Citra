classdef HistogramMatchingModel < handle
    %MODEL Application data model.
    
    properties (SetAccess = private)
        % Application data.
        InputImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
        ReferenceImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
        OutputImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
    end % properties (SetAccess = private)
    
    events (NotifyAccess = private)
        % Event broadcast when the data is changed.
        DataChanged
        
        % Event broadcast when the result is changed.
        ResultChanged
    end % events (NotifyAccess = private)
    
    methods
        function SetInputWrapper(obj, imageWrapper)
            arguments
                obj models.HistogramMatchingModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.InputImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % SetWrapper
        
        function SetReferenceWrapper(obj, imageWrapper)
            arguments
                obj models.HistogramMatchingModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.ReferenceImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % SetWrapper
        
        function SetOutputWrapper(obj, imageWrapper)
            arguments
                obj models.HistogramMatchingModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.OutputImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("ResultChanged");
        end % SetOutputWrapper
        
        function ResetModel(obj)
            arguments
                obj models.HistogramMatchingModel
            end
            
            % Reset the image wrapper.
            obj.InputImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            obj.ReferenceImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            obj.OutputImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            
            % Broadcast the event.
            obj.notify("DataChanged");
            obj.notify("ResultChanged");
        end % ResetModel
    end % methods
end