classdef (Abstract) HistogramEqualizationComponent < matlab.ui.componentcontainer.ComponentContainer
    %COMPONENT Superclass for implementing views and controllers.
    
    properties (SetAccess = immutable, GetAccess = protected)
        % Application data model.
        Model(1, 1) models.HistogramEqualizationModel
    end % properties (SetAccess = immutable, GetAccess = protected)
    
    methods
        function obj = HistogramEqualizationComponent(model)
            %COMPONENT Component constructor.
            
            arguments
                model(1, 1) models.HistogramEqualizationModel
            end % arguments
            
            % Do not create a default figure parent for the component, and
            % ensure that the component spans its parent. By default,
            % ComponentContainer objects are auto-parenting - that is, a
            % figure is created automatically if no parent argument is
            % specified.
            obj@matlab.ui.componentcontainer.ComponentContainer("Parent", [], "Units", "normalized", "Position", [0, 0, 1, 1])
            
            % Store the model.
            obj.Model = model;
        end % constructor
    end % methods
end % classdef