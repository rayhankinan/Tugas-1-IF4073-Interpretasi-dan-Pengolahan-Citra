classdef HistogramEqualizationPage < components.HistogramEqualizationComponent
    %PAGE Provides a component to wrap view and controller for data.
    
    methods
        function obj = HistogramEqualizationPage(namedArgs)
            % PAGE Page constructor.
            
            arguments
                namedArgs.?pages.HistogramEqualizationPage
            end
            
            % Call the superclass constructor.
            obj@components.HistogramEqualizationComponent(models.HistogramEqualizationModel());
            
            % Set any user-specified properties.
            set(obj, namedArgs);
        end % constructor
    end % methods
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the page.
            
            % Create the layout.
            g = uigridlayout("Parent", obj, "RowHeight", {"1x", 50}, "ColumnWidth", "1x");
            
            % Create the view.
            views.HistogramEqualizationView(obj.Model, "Parent", g);
            
            % Create the controller.
            controllers.HistogramEqualizationController(obj.Model, "Parent", g);
        end % setup
        
        function update(~)
            %UPDATE Update the controller. This method is empty because
            %there are no public properties of the controller.
            
        end % update
    end % methods (Access = protected)
end