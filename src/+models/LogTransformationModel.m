classdef LogTransformationModel < handle
    %MODEL Application data model.
    
    properties (SetAccess = private)
        % Application data.
        InputImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
        OutputImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
        C = 1 % Coefficient.
    end % properties (SetAccess = private)
    
    events (NotifyAccess = private)
        % Event broadcast when the data is changed.
        DataChanged
        
        % Event broadcast when the result is changed.
        ResultChanged
        
        % Event broadcast when the parameter is changed.
        CVarChanged
    end % events (NotifyAccess = private)
    
    methods
        function SetInputWrapper(obj, imageWrapper)
            arguments
                obj models.LogTransformationModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.InputImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % SetWrapper
        
        function SetOutputWrapper(obj, imageWrapper)
            arguments
                obj models.LogTransformationModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.OutputImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("ResultChanged");
        end % SetOutputWrapper
        
        function SetC(obj, C)
            arguments
                obj models.LogTransformationModel
                C (1, 1) double
            end
            
            % Set the coefficient.
            obj.C = C;
            
            % Broadcast the event.
            obj.notify("CVarChanged");
        end % SetC
        
        function ResetModel(obj)
            arguments
                obj models.LogTransformationModel
            end
            
            % Reset the image wrapper.
            obj.InputImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            obj.OutputImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            obj.C = 1; % Coefficient.
            
            % Broadcast the event.
            obj.notify("DataChanged");
            obj.notify("ResultChanged");
            obj.notify("CVarChanged");
        end % ResetModel
    end % methods
end % classdef