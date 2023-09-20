classdef HistogramStretchingController < components.HistogramStretchingComponent
    %CONTROLLER Provides an interactive control to generate new data.
    
    properties (Access = private)
        % Text input for the a and b parameters.
        InputA(1, 1) matlab.ui.control.NumericEditField
        InputB(1, 1) matlab.ui.control.NumericEditField
    end
    
    methods
        function obj = HistogramStretchingController(model, namedArgs)
            % CONTROLLER Controller constructor.
            
            arguments
                model(1, 1) models.HistogramStretchingModel
                namedArgs.?controllers.HistogramStretchingController
            end % arguments
            
            % Call the superclass constructor.
            obj@components.HistogramStretchingComponent(model);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the controller.
            
            % Create a grid layout.
            g = uigridlayout("Parent", obj, "RowHeight", "1x", "ColumnWidth", {"1x", "1x", "1x"}, "Padding", 0);
            
            % Create upload button.
            uibutton("Parent", g, "Text", "Upload new image", "ButtonPushedFcn", @obj.onUploadButtonPushed);
            
            % Create reset button.
            uibutton("Parent", g, "Text", "Reset", "ButtonPushedFcn", @obj.onResetButtonPushed);
            
            % Create execute button.
            uibutton("Parent", g, "Text", "Execute", "ButtonPushedFcn", @obj.onExecuteButtonPushed);
        end % setup
        
        function update(~)
            %UPDATE Update the controller. This method is empty because
            %there are no public properties of the controller.
            
        end % update
    end % methods (Access = protected)
    
    methods (Access = private)
        function onUploadButtonPushed(obj, ~, ~)
            
            % Get the image file.
            [filename, pathname] = uigetfile("*.bmp;*.tif", "Select an image");
            
            % If the user cancels, return.
            if ~ischar(filename)
                return
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Create an image wrapper object.
            inputWrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetInputWrapper(inputWrapper);
        end % onButtonPushed
        
        function onResetButtonPushed(obj, ~, ~)
            %ONRESETBUTTONPUSHED Reset the model.
            
            % Reset the model.
            obj.Model.ResetModel();
        end
        
        function onExecuteButtonPushed(obj, ~, ~)
            %ONEXECUTEBUTTONPUSHED Execute the model.
            
            % Get wrapper
            inputWrapper = obj.Model.InputImageWrapper;
            
            % Get the histogram stretched image.
            imageData = inputWrapper.GetHistogramStretchedImage();
            
            % Create an image wrapper object.
            outputWrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetOutputWrapper(outputWrapper);
        end
    end
end