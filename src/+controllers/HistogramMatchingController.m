classdef HistogramMatchingController < components.HistogramMatchingComponent
    %CONTROLLER Provides an interactive control to generate new data.
    
    properties (Access = private)
        % Text input for the a and b parameters.
        InputA(1, 1) matlab.ui.control.NumericEditField
        InputB(1, 1) matlab.ui.control.NumericEditField
    end
    
    methods
        function obj = HistogramMatchingController(model, namedArgs)
            % CONTROLLER Controller constructor.
            
            arguments
                model(1, 1) models.HistogramMatchingModel
                namedArgs.?controllers.HistogramMatchingController
            end % arguments
            
            % Call the superclass constructor.
            obj@components.HistogramMatchingComponent(model);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the controller.
            
            % Create a grid layout.
            g = uigridlayout("Parent", obj, "RowHeight", "1x", "ColumnWidth", {"1x", "1x", "1x", "1x"}, "Padding", 0);
            
            % Create upload button for input image.
            uibutton("Parent", g, "Text", "Upload input image", "ButtonPushedFcn", @obj.onUploadInputButtonPushed);

            % Create upload button for reference image.
            uibutton("Parent", g, "Text", "Upload reference image", "ButtonPushedFcn", @obj.onUploadReferenceButtonPushed);
            
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
        function onUploadInputButtonPushed(obj, ~, ~)
            
            % Get the image file.
            [filename, pathname] = uigetfile("*.bmp;*.tif", "Select an image");
            
            % If the user cancels, return.
            if ~ischar(filename)
                uialert(obj, "No image selected.", "Error", "Icon", "error");
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

        function onUploadReferenceButtonPushed(obj, ~, ~)
            
            % Get the image file.
            [filename, pathname] = uigetfile("*.bmp;*.tif", "Select an image");
            
            % If the user cancels, return.
            if ~ischar(filename)
                uialert(obj, "No image selected.", "Error", "Icon", "error");
                return
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Create an image wrapper object.
            referenceWrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetReferenceWrapper(referenceWrapper);
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
            referenceWrapper = obj.Model.ReferenceImageWrapper;
            
            % Get the histogram equalized image.
            imageData = inputWrapper.GetHistogramSpecificationImage(referenceWrapper);
            
            % Create an image wrapper object.
            outputWrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetOutputWrapper(outputWrapper);
        end
    end
end