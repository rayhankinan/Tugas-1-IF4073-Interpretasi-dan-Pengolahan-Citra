classdef HistogramModel < handle
    %MODEL Application data model.
    
    properties (SetAccess = private)
        % Application data.
        HistogramRed(:, 1) double = double.empty(0, 1)
        HistogramGreen(:, 1) double = double.empty(0, 1)
        HistogramBlue(:, 1) double = double.empty(0, 1)
    end % properties (SetAccess = private)
    
    events (NotifyAccess = private)
        % Event broadcast when the data is changed.
        DataChanged
    end % events (NotifyAccess = private)
    
    methods
        function setHistogram(obj, histRed, histGreen, histBlue)
            arguments
                obj models.HistogramModel
                histRed(:, 1) double
                histGreen(:, 1) double
                histBlue(:, 1) double
            end
            
            % Set the histogram.
            obj.HistogramRed = histRed;
            obj.HistogramGreen = histGreen;
            obj.HistogramBlue = histBlue;
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % setFilepath
        
        function reset(obj)
            arguments
                obj models.HistogramModel
            end
            
            % Reset the histogram.
            obj.HistogramRed = double.empty(0, 1);
            obj.HistogramGreen = double.empty(0, 1);
            obj.HistogramBlue = double.empty(0, 1);
            
            % Broadcast the event.
            obj.notify("DataChanged");
        end % reset
    end % methods
end % classdef