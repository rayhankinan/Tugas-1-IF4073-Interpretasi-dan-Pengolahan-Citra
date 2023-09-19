classdef AppModel < handle
    %MODEL Application data model.
    
    properties (SetAccess = private)
        % Application data.
        CurrentPageKey string = "Histogram" % Key to the current page.
    end % properties (SetAccess = private)
    
    events (NotifyAccess = private)
        % Event broadcast when the data is changed.
        KeyChanged
    end % events (NotifyAccess = private)
    
    methods
        function SetCurrentPageKey(obj, key)
            %SETCURRENTPAGEKEY Set the current page key.
            arguments
                obj models.AppModel
                key string
            end % arguments
            
            % Set the current page key.
            obj.CurrentPageKey = key;
            
            % Broadcast the change.
            obj.notify("KeyChanged");
        end % SetCurrentPageKey
    end % methods
end