classdef NegativePage < components.NegativeComponent
    %PAGE Provides a component to wrap view and controller for data.
    
    methods
        function obj = NegativePage(namedArgs)
            % PAGE Page constructor.
            
            arguments
                namedArgs.?pages.NegativePage
            end
            
            % Call the superclass constructor.
            obj@components.NegativeComponent(models.NegativeModel());
            
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
            views.NegativeView(obj.Model, "Parent", g);
            
            % Create the controller.
            controllers.NegativeController(obj.Model, "Parent", g);
        end % setup
        
        function update(~)
            %UPDATE Update the controller. This method is empty because
            %there are no public properties of the controller.
            
        end % update
    end % methods (Access = protected)
end