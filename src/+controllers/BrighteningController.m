classdef BrighteningController < components.BrighteningComponent
    %CONTROLLER Provides an interactive control to generate new data.
    
    properties (Access = private)
        % Text input for the a and b parameters.
        InputA(1, 1) matlab.ui.control.NumericEditField
        InputB(1, 1) matlab.ui.control.NumericEditField
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
            
            % Set any user-specified properties.
            set(obj, namedArgs);
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the controller.
            
            % Create a grid layout.
            g = uigridlayout("Parent", obj, "RowHeight", {"1x", "1x"}, "ColumnWidth", {"1x", "1x", "1x"}, "Padding", 0);
            
            % Create input "a" parameter.
            obj.InputA = uieditfield("numeric", "Parent", g, "Value", 0);
            
            % Create input "b" parameter.
            obj.InputB = uieditfield("numeric", "Parent", g, "Value", 0);
            
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
            [filename, pathname] = uigetfile("*.bmp", "Select an image");
            
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
            
            % Get the brightened image data.
            imageData = obj.Model.GetBrightening(obj.InputA.Value, obj.InputB.Value);
            
            % Create an image wrapper object.
            wrapper = utils.ImageWrapperFactory.create(imageData);
            
            % Update the model.
            obj.Model.SetOutputWrapper(wrapper);
        end
    end
end