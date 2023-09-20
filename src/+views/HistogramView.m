classdef HistogramView < components.HistogramComponent
    %VIEW Visualizes the data, responding to any relevant model events.
    
    properties (Access = private)
        % Bar chart object used to visualize the data.
        BarChartRed(1, 1) matlab.graphics.chart.primitive.Bar
        BarChartGreen(1, 1) matlab.graphics.chart.primitive.Bar
        BarChartBlue(1, 1) matlab.graphics.chart.primitive.Bar
        
        % Image object used to visualize the data.
        Image(1, 1) matlab.graphics.primitive.Image
        
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
            
            % Create a bar chart for each color channel.
            redAxes = uiaxes("Parent", obj, "Position", [0 150 250 150]);
            title(redAxes, "Red");
            xlabel(redAxes, "Intensity");
            ylabel(redAxes, "Pixels");
            
            obj.BarChartRed = bar(NaN, "Parent", redAxes, "FaceColor", "r", "EdgeColor", "none");
            
            greenAxes = uiaxes("Parent", obj, "Position", [250 150 250 150]);
            title(greenAxes, "Green");
            xlabel(greenAxes, "Intensity");
            ylabel(greenAxes, "Pixels");
            
            obj.BarChartGreen = bar(NaN, "Parent", greenAxes, "FaceColor", "g", "EdgeColor", "none");
            
            blueAxes = uiaxes("Parent", obj, "Position", [0 0 250 150]);
            title(blueAxes, "Blue");
            xlabel(blueAxes, "Intensity");
            ylabel(blueAxes, "Pixels");
            
            obj.BarChartBlue = bar(NaN, "Parent", blueAxes, "FaceColor", "b", "EdgeColor", "none");
            
            % Create image preview.
            imagesAxes = uiaxes("Parent", obj, "Position", [0 300 360 320], "Colormap", gray(256), "Visible", "off", "YDir", "reverse");
            obj.Image = image("Parent", imagesAxes, "CData", NaN);
            
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
            
            % Retrieve the most recent image wrapper.
            wrapper = obj.Model.ImageWrapper;
            
            % Update the bar chart data.
            if ~wrapper.IsEmpty()
                % Compute the histogram of each color channel.
                [histRed, histGreen, histBlue] = wrapper.GetHistogram();
                
                % Update the bar chart data.
                set(obj.BarChartRed, "XData", 1:numel(histRed), "YData", histRed);
                set(obj.BarChartGreen, "XData", 1:numel(histGreen), "YData", histGreen);
                set(obj.BarChartBlue, "XData", 1:numel(histBlue), "YData", histBlue);
                
                % Get image data.
                imageData = wrapper.GetImageData();
                
                % Update the image preview.
                set(obj.Image, "CData", imageData);
            else
                % Clear the bar chart data.
                set(obj.BarChartRed, "XData", NaN, "YData", NaN);
                set(obj.BarChartGreen, "XData", NaN, "YData", NaN);
                set(obj.BarChartBlue, "XData", NaN, "YData", NaN);
                
                % Clear the image preview.
                set(obj.Image, "CData", NaN);
            end
            
        end % onDataChanged
    end % methods (Access = private)
end