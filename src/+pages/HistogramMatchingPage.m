classdef HistogramMatchingPage < components.HistogramMatchingComponent
    %PAGE Provides a component to wrap view and controller for data.
    
    methods
        function obj = HistogramMatchingPage(namedArgs)
            % PAGE Page constructor.
            
            arguments
                namedArgs.?pages.HistogramMatchingPage
            end
            
            % Call the superclass constructor.
            obj@components.HistogramMatchingComponent(models.HistogramMatchingModel());
            
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
            views.HistogramMatchingView(obj.Model, "Parent", g);
            
            % Create the controller.
            controllers.HistogramMatchingController(obj.Model, "Parent", g);
        end % setup
        
        function update(~)
            %UPDATE Update the controller. This method is empty because
            %there are no public properties of the controller.
            
        end % update
    end % methods (Access = protected)
end