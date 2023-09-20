classdef LogTransformationController < components.LogTransformationComponent
    %CONTROLLER Provides an interactive control to generate new data.
    
    properties (Access = private)
        % Text input for the a and b parameters.
        InputC(1, 1) matlab.ui.control.NumericEditField
        
        % Listener object used to respond dynamically to model events.
        CListener(:, 1) event.listener {mustBeScalarOrEmpty}
    end
    
    methods
        function obj = LogTransformationController(model, namedArgs)
            % CONTROLLER Controller constructor.
            
            arguments
                model(1, 1) models.LogTransformationModel
                namedArgs.?controllers.LogTransformationController
            end % arguments
            
            % Call the superclass constructor.
            obj@components.LogTransformationComponent(model);
            
            % Create a listener for the a parameter.
            obj.CListener = listener(obj.Model, "CVarChanged", @obj.onCModelChanged);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
            
            % Refresh the view.
            obj.onCModelChanged();
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the controller.
            
            % Create a grid layout.
            g = uigridlayout("Parent", obj, "RowHeight", {"1x", "1x"}, "ColumnWidth", {"1x", "1x"}, "Padding", 0);
            
            % Create input "c" parameter.
            obj.InputC = uieditfield("numeric", "Parent", g, "ValueChangedFcn", @obj.onInputCChanged);
            
            % Create execute button.
            uibutton("Parent", g, "Text", "Execute", "ButtonPushedFcn", @obj.onExecuteButtonPushed);
            
            % Create upload button.
            uibutton("Parent", g, "Text", "Upload new image", "ButtonPushedFcn", @obj.onUploadButtonPushed);
            
            % Create reset button.
            uibutton("Parent", g, "Text", "Reset", "ButtonPushedFcn", @obj.onResetButtonPushed);
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
        
        function onResetButtonPushed(obj, ~, ~)
            %ONRESETBUTTONPUSHED Reset the model.
            
            % Reset the model.
            obj.Model.ResetModel();
        end
        
        function onExecuteButtonPushed(obj, ~, ~)
            %ONEXECUTEBUTTONPUSHED Execute the model.
            
            % Get wrapper
            inputWrapper = obj.Model.InputImageWrapper;
            
            % Get the log transformed image data.
            imageData = inputWrapper.GetLogTransformation(obj.Model.C);
            
            % Create an image wrapper object.
            outputWrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetOutputWrapper(outputWrapper);
        end
        
        function onCModelChanged(obj, ~, ~)
            %ONCMODELCHANGED Update the "c" input field.
            
            % Update the input field.
            set(obj.InputC, "Value", obj.Model.C);
        end
        
        function onInputCChanged(obj, ~, ~)
            %ONINPUTCCHANGED Update the "c" parameter.
            
            % Update the model.
            obj.Model.SetC(obj.InputC.Value);
        end
    end
end