classdef BrighteningModel < handle
    %MODEL Application data model.
    
    properties (SetAccess = private)
        % Application data.
        InputImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
        OutputImageWrapper(1, 1) wrappers.BaseImageWrapper = wrappers.GrayscaleImageWrapper([]) % Empty image.
        A double = 0 % Brightening factor.
        B double = 0 % Brightening bias.
    end % properties (SetAccess = private)
    
    events (NotifyAccess = private)
        % Event broadcast when the data is changed.
        DataChanged
        
        % Event broadcast when the result is changed.
        ResultChanged
        
        % Event broadcast when the parameter is changed.
        AChanged
        BChanged
    end % events (NotifyAccess = private)
    
    methods
        function SetInputWrapper(obj, imageWrapper)
            arguments
                obj models.BrighteningModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.InputImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % SetWrapper
        
        function SetOutputWrapper(obj, imageWrapper)
            arguments
                obj models.BrighteningModel
                imageWrapper wrappers.BaseImageWrapper
            end
            
            % Set the image wrapper.
            obj.OutputImageWrapper = imageWrapper;
            
            % Broadcast the event.
            obj.notify("ResultChanged");
        end % SetOutputWrapper
        
        function SetA(obj, A)
            arguments
                obj models.BrighteningModel
                A double
            end
            
            % Set the parameter.
            obj.A = A;
            
            % Broadcast the event.
            obj.notify("AChanged");
        end % SetA
        
        function SetB(obj, B)
            arguments
                obj models.BrighteningModel
                B double
            end
            
            % Set the parameter.
            obj.B = B;
            
            % Broadcast the event.
            obj.notify("BChanged");
        end % SetB
        
        function ResetModel(obj)
            arguments
                obj models.BrighteningModel
            end
            
            % Reset the image wrapper.
            obj.InputImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            obj.OutputImageWrapper = wrappers.GrayscaleImageWrapper([]); % Empty image.
            
            % Broadcast the event.
            obj.notify("DataChanged");
            obj.notify("ResultChanged");
        end % reset
    end % methods
end % classdef