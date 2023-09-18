classdef HistogramPage < components.HistogramComponent
    %PAGE Provides a component to wrap view and controller for data.
    
    methods
        function obj = HistogramPage(namedArgs)
            % PAGE Page constructor.
            
            arguments
                namedArgs.?pages.HistogramPage
            end
            
            % Call the superclass constructor.
            obj@components.HistogramComponent(models.HistogramModel());
            
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
            views.HistogramView(obj.Model, "Parent", g);
            
            % Create the controller.
            controllers.HistogramController(obj.Model, "Parent", g);
        end % setup
        
        function update(~)
            %UPDATE Update the controller. This method is empty because
            %there are no public properties of the controller.
            
        end % update
    end % methods (Access = protected)
end