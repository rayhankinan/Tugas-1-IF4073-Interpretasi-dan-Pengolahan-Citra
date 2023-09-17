classdef HistogramModel < handle
    %MODEL Application data model.
    
    properties (SetAccess = private)
        % Application data.
        Histogram(:, 1) double = double.empty(0, 1)
    end % properties (SetAccess = private)
    
    events (NotifyAccess = private)
        % Event broadcast when the data is changed.
        DataChanged
    end % events (NotifyAccess = private)
    
    methods
        function setHistogram(obj, hist)
            arguments
                obj models.HistogramModel
                hist(:, 1) double
            end
            
            % Set the histogram.
            obj.Histogram = hist;
            obj.notify("DataChanged");
        end % setFilepath
        
        function reset(obj)
            arguments
                obj models.HistogramModel
            end
            
            % Reset the histogram.
            obj.Histogram = double.empty(0, 1);
            obj.notify("DataChanged");
        end % reset
    end % methods
end % classdef