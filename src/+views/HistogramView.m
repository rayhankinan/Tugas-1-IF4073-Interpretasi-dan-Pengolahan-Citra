classdef HistogramView < components.HistogramComponent
    %VIEW Visualizes the data, responding to any relevant model events.
    
    properties (Access = private)
        % Bar chart object used to visualize the data.
        BarChart(1, 1) matlab.graphics.chart.primitive.Bar
        % Listener object used to respond dynamically to model events.
        Listener(:, 1) event.listener {mustBeScalarOrEmpty}
    end % properties (Access = private)
    
    methods
        function obj = HistogramView(model, namedArgs)
            %VIEW Construct a view object.
            
            arguments
                model(1, 1) models.HistogramModel
                namedArgs.?views.HistogramView
            end
            
            % Call the superclass constructor.
            obj@components.HistogramComponent(model);
            
            % Listen for changes to the data.
            obj.Listener = listener(obj.Model, "DataChanged", @obj.onDataChanged);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
            
            % Refresh the view.
            obj.onDataChanged();
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the view.
            
            % Create the view graphics.
            ax = axes("Parent", obj);
            obj.BarChart = bar("Parent", ax, "XData", NaN, "YData", NaN);
        end % setup
        
        function update(~)
            %UPDATE Update the view. This method is empty because there are
            %no public properties of the view.
            
        end % update
    end % methods (Access = protected)
    
    methods (Access = private)
        function onDataChanged(obj, ~, ~)
            %ONDATACHANGED Update the view in response to a change in the
            %model.
            
            % Retrieve the most recent data and update the bar.
            hist = obj.Model.Histogram;
            set(obj.BarChart,"XData", 1:numel(hist), "YData", hist);
        end % onDataChanged
    end % methods (Access = private)
end