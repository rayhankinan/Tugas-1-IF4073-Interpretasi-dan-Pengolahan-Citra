classdef PowerTransformationController < components.PowerTransformationComponent
    %CONTROLLER Provides an interactive control to generate new data.
    
    properties (Access = private)
        % Text input for the a and b parameters.
        InputC(1, 1) matlab.ui.control.NumericEditField
        InputGamma(1, 1) matlab.ui.control.NumericEditField
        
        % Listener object used to respond dynamically to model events.
        CListener(:, 1) event.listener
        GammaListener(:, 1) event.listener
    end
    
    methods
        function obj = PowerTransformationController(model, namedArgs)
            % CONTROLLER Controller constructor.
            
            arguments
                model(1, 1) models.PowerTransformationModel
                namedArgs.?controllers.PowerTransformationController
            end % arguments
            
            % Call the superclass constructor.
            obj@components.PowerTransformationComponent(model);
            
            % Create a listener for the a parameter.
            obj.CListener = listener(obj.Model, "CVarChanged", @obj.onCModelChanged);
            obj.GammaListener = listener(obj.Model, "GammaVarChanged", @obj.onGammaModelChanged);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
            
            % Update the view.
            obj.onCModelChanged();
            obj.onGammaModelChanged();
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the controller.
            
            % Create a grid layout.
            g = uigridlayout("Parent", obj, "RowHeight", {"1x", "1x"}, "ColumnWidth", {"1x", "1x", "1x"}, "Padding", 0);
            
            % Create input "a" parameter.
            obj.InputC = uieditfield("numeric", "Parent", g,"ValueChangedFcn", @obj.onInputCChanged);
            
            % Create input "b" parameter.
            obj.InputGamma = uieditfield("numeric", "Parent", g, "ValueChangedFcn", @obj.onInputGammaChanged);
            
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
            imageData = inputWrapper.GetPowerTransformation(obj.Model.C, obj.Model.Gamma);
            
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
        
        function onGammaModelChanged(obj, ~, ~)
            %ONGAMMAMODELCHANGED Update the "gamma" input field.
            
            % Update the input field.
            set(obj.InputGamma, "Value", obj.Model.Gamma);
        end
        
        function onInputCChanged(obj, ~, ~)
            %ONINPUTCCHANGED Update the "c" parameter.
            
            % Update the model.
            obj.Model.SetC(obj.InputC.Value);
        end
        
        function onInputGammaChanged(obj, ~, ~)
            %ONINPUTGAMMACHANGED Update the "gamma" parameter.
            
            % Update the model.
            obj.Model.SetGamma(obj.InputGamma.Value);
        end
    end
end