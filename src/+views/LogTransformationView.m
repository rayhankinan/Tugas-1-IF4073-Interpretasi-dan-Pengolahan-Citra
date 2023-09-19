classdef LogTransformationView < components.LogTransformationComponent
    %VIEW Visualizes the data, responding to any relevant model events.
    
    properties (Access = private)
        % Bar chart object used to visualize the data.
        InputBarChartRed(1, 1) matlab.graphics.chart.primitive.Bar
        InputBarChartGreen(1, 1) matlab.graphics.chart.primitive.Bar
        InputBarChartBlue(1, 1) matlab.graphics.chart.primitive.Bar
        OutputBarChartRed(1, 1) matlab.graphics.chart.primitive.Bar
        OutputBarChartGreen(1, 1) matlab.graphics.chart.primitive.Bar
        OutputBarChartBlue(1, 1) matlab.graphics.chart.primitive.Bar
        
        % Image object used to visualize the data.
        InputImage(1, 1) matlab.graphics.primitive.Image
        OutputImage(1, 1) matlab.graphics.primitive.Image
        
        % Listener object used to respond dynamically to model events.
        InputListener(:, 1) event.listener {mustBeScalarOrEmpty}
        OutputListener(:, 1) event.listener {mustBeScalarOrEmpty}
    end % properties (Access = private)
    
    methods
        function obj = LogTransformationView(model, namedArgs)
            %VIEW Construct a view object.
            
            arguments
                model(1, 1) models.LogTransformationModel
                namedArgs.?views.LogTransformationView
            end
            
            % Call the superclass constructor.
            obj@components.LogTransformationComponent(model);
            
            % Listen for changes to the data.
            obj.InputListener = listener(obj.Model, "DataChanged", @obj.onDataChanged);
            obj.OutputListener = listener(obj.Model, "ResultChanged", @obj.onResultChanged);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
            
            % Refresh the view.
            obj.onDataChanged();
            obj.onResultChanged();
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the view.
            
            % Create a bar chart for each color channel for input.
            inputRedAxes = uiaxes("Parent", obj, "Position", [0 150 250 150]);
            title(inputRedAxes, "Red");
            xlabel(inputRedAxes, "Intensity");
            ylabel(inputRedAxes, "Pixels");
            
            obj.InputBarChartRed = bar(NaN, "Parent", inputRedAxes, "FaceColor", "r", "EdgeColor", "none");
            
            inputGreenAxes = uiaxes("Parent", obj, "Position", [250 150 250 150]);
            title(inputGreenAxes, "Green");
            xlabel(inputGreenAxes, "Intensity");
            ylabel(inputGreenAxes, "Pixels");
            
            obj.InputBarChartGreen = bar(NaN, "Parent", inputGreenAxes, "FaceColor", "g", "EdgeColor", "none");
            
            inputBlueAxes = uiaxes("Parent", obj, "Position", [0 0 250 150]);
            title(inputBlueAxes, "Blue");
            xlabel(inputBlueAxes, "Intensity");
            ylabel(inputBlueAxes, "Pixels");
            
            obj.InputBarChartBlue = bar(NaN, "Parent", inputBlueAxes, "FaceColor", "b", "EdgeColor", "none");
            
            % Create image input preview.
            inputImageAxes = uiaxes("Parent", obj, "Position", [0 300 360 320], "Colormap", gray(256), "Visible", "off", "YDir", "reverse");
            obj.InputImage = imagesc("Parent", inputImageAxes, "CData", NaN);
            
            % Create a bar chart for each color channel for output.
            outputRedAxes = uiaxes("Parent", obj, "Position", [600 150 250 150]);
            title(outputRedAxes, "Red");
            xlabel(outputRedAxes, "Intensity");
            ylabel(outputRedAxes, "Pixels");
            
            obj.OutputBarChartRed = bar(NaN, "Parent", outputRedAxes, "FaceColor", "r", "EdgeColor", "none");
            
            outputGreenAxes = uiaxes("Parent", obj, "Position", [850 150 250 150]);
            title(outputGreenAxes, "Green");
            xlabel(outputGreenAxes, "Intensity");
            ylabel(outputGreenAxes, "Pixels");
            
            obj.OutputBarChartGreen = bar(NaN, "Parent", outputGreenAxes, "FaceColor", "g", "EdgeColor", "none");
            
            outputBlueAxes = uiaxes("Parent", obj, "Position", [600 0 250 150]);
            title(outputBlueAxes, "Blue");
            xlabel(outputBlueAxes, "Intensity");
            ylabel(outputBlueAxes, "Pixels");
            
            obj.OutputBarChartBlue = bar(NaN, "Parent", outputBlueAxes, "FaceColor", "b", "EdgeColor", "none");
            
            % Create image output preview.
            outputImageAxes = uiaxes("Parent", obj, "Position", [600 300 360 320], "Colormap", gray(256), "Visible", "off", "YDir", "reverse");
            obj.OutputImage = imagesc("Parent", outputImageAxes, "CData", NaN);
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
            wrapper = obj.Model.InputImageWrapper;
            
            % Update the bar chart data.
            if ~wrapper.IsEmpty()
                % Compute the histogram of each color channel.
                [histRed, histGreen, histBlue] = wrapper.GetHistogram();
                
                % Update the bar chart data.
                set(obj.InputBarChartRed, "XData", 1:numel(histRed), "YData", histRed);
                set(obj.InputBarChartGreen, "XData", 1:numel(histGreen), "YData", histGreen);
                set(obj.InputBarChartBlue, "XData", 1:numel(histBlue), "YData", histBlue);
                
                % Get image data.
                imageData = wrapper.GetImageData();
                
                % Update the image preview.
                set(obj.InputImage, "CData", imageData);
            else
                % Clear the bar chart data.
                set(obj.InputBarChartRed, "XData", NaN, "YData", NaN);
                set(obj.InputBarChartGreen, "XData", NaN, "YData", NaN);
                set(obj.InputBarChartBlue, "XData", NaN, "YData", NaN);
                
                % Clear the image preview.
                set(obj.InputImage, "CData", NaN);
            end
            
        end % onDataChanged
        
        function onResultChanged(obj, ~, ~)
            %ONRESULTCHANGED Update the view in response to a change in the
            %model.
            
            % Retrieve the most recent image wrapper.
            wrapper = obj.Model.OutputImageWrapper;
            
            % Update the bar chart data.
            if ~wrapper.IsEmpty()
                % Compute the histogram of each color channel.
                [histRed, histGreen, histBlue] = wrapper.GetHistogram();
                
                % Update the bar chart data.
                set(obj.OutputBarChartRed, "XData", 1:numel(histRed), "YData", histRed);
                set(obj.OutputBarChartGreen, "XData", 1:numel(histGreen), "YData", histGreen);
                set(obj.OutputBarChartBlue, "XData", 1:numel(histBlue), "YData", histBlue);
                
                % Get image data.
                imageData = wrapper.GetImageData();
                
                % Update the image preview.
                set(obj.OutputImage, "CData", imageData);
            else
                % Clear the bar chart data.
                set(obj.OutputBarChartRed, "XData", NaN, "YData", NaN);
                set(obj.OutputBarChartGreen, "XData", NaN, "YData", NaN);
                set(obj.OutputBarChartBlue, "XData", NaN, "YData", NaN);
                
                % Clear the image preview.
                set(obj.OutputImage, "CData", NaN);
            end
        end
    end % methods (Access = private)
end