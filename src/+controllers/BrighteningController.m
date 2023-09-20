classdef BrighteningController < components.BrighteningComponent
    %CONTROLLER Provides an interactive control to generate new data.
    
    properties (Access = private)
        % Text input for the a and b parameters.
        InputA(1, 1) matlab.ui.control.NumericEditField
        InputB(1, 1) matlab.ui.control.NumericEditField
        
        % Listener object used to respond dynamically to model events.
        AListener(:, 1) event.listener {mustBeScalarOrEmpty}
        BListener(:, 1) event.listener {mustBeScalarOrEmpty}
    end
    
    methods
        function obj = BrighteningController(model, namedArgs)
            % CONTROLLER Controller constructor.
            
            arguments
                model(1, 1) models.BrighteningModel
                namedArgs.?controllers.BrighteningController
            end % arguments
            
            % Call the superclass constructor.
            obj@components.BrighteningComponent(model);
            
            % Create a listener for the a parameter.
            obj.AListener = listener(obj.Model, "AVarChanged", @obj.onAModelChanged);
            obj.BListener = listener(obj.Model, "BVarChanged", @obj.onBModelChanged);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
            
            % Refresh the view.
            obj.onAModelChanged();
            obj.onBModelChanged();
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the controller.
            
            % Create a grid layout.
            g = uigridlayout("Parent", obj, "RowHeight", {"1x", "1x"}, "ColumnWidth", {"1x", "1x", "1x"}, "Padding", 0);
            
            % Create input "a" parameter.
            obj.InputA = uieditfield("numeric", "Parent", g, "ValueChangedFcn", @obj.onInputAChanged);
            
            % Create input "b" parameter.
            obj.InputB = uieditfield("numeric", "Parent", g, "ValueChangedFcn", @obj.onInputBChanged);
            
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
                return
            end
            
            % Construct the full file path.
            filepath = fullfile(pathname, filename);
            
            % Read the image.
            imageData = imread(filepath);
            
            % Create an image wrapper object.
            wrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetInputWrapper(wrapper);
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
            
            % Get the brightened image data.
            imageData = inputWrapper.GetBrightening(obj.Model.A, obj.Model.B);
            
            % Create an image wrapper object.
            outputWrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetOutputWrapper(outputWrapper);
        end
        
        function onAModelChanged(obj, ~, ~)
            %ONAMODELCHANGED Update the "a" input field.
            
            % Update the input field.
            set(obj.InputA, "Value", obj.Model.A);
        end
        
        function onBModelChanged(obj, ~, ~)
            % ONBMODELCHANGED Update the "b" input field.
            
            % Update the input field.
            set(obj.InputB, "Value", obj.Model.B);
        end
        
        function onInputAChanged(obj, ~, ~)
            %ONINPUTACHANGED Update the "a" parameter.
            
            % Update the model.
            obj.Model.SetA(obj.InputA.Value);
        end
        
        function onInputBChanged(obj, ~, ~)
            %ONINPUTBCHANGED Update the "b" parameter.
            
            % Update the model.
            obj.Model.SetB(obj.InputB.Value);
        end
    end
end