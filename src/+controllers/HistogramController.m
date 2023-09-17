classdef HistogramController < components.HistogramComponent
    %CONTROLLER Provides an interactive control to generate new data.
    
    methods
        function obj = HistogramController(model, namedArgs)
            % CONTROLLER Controller constructor.
            
            arguments
                model(1, 1) models.HistogramModel
                namedArgs.?controllers.HistogramController
            end % arguments
            
            % Call the superclass constructor.
            obj@components.HistogramComponent(model);
            
            % Set any user-specified properties.
            set(obj, namedArgs)
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the controller.
            
            % Create grid and button.
            g = uigridlayout("Parent", obj, "RowHeight", "1x", "ColumnWidth", "1x", "Padding", 0);
            uibutton("Parent", g, "Text", "Upload new image", "ButtonPushedFcn", @obj.onButtonPushed);
        end % setup
        
        function update(~)
            %UPDATE Update the controller. This method is empty because
            %there are no public properties of the controller.
            
        end % update
    end % methods (Access = protected)
    
    methods (Access = private)
        function onButtonPushed(obj, ~, ~)
            
            % Get the image file.
            [filename, pathname] = uigetfile("*.bmp", "Select an image");
            
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
            obj.Model.setWrapper(wrapper);
        end % onButtonPushed
    end
end