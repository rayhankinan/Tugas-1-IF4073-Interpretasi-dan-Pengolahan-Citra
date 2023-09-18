classdef AppLayout < matlab.ui.componentcontainer.ComponentContainer
    properties (Access = private)
        % Map of page names to page objects.
        PageMap containers.Map;
        CurrentPage string;
    end
    
    methods
        function obj = AppLayout(namedArgs)
            %APPLAYOUT Construct an instance of this class.
            
            arguments
                namedArgs.?pages.HistogramPage
            end
            
            % Call the superclass constructor.
            obj@matlab.ui.componentcontainer.ComponentContainer("Parent", [], "Units", "normalized", "Position", [0, 0, 1, 1]);
            
            % Initialize the application.
            obj.PageMap = containers.Map();
            
            % Initialize the current page selection.
            obj.CurrentPage = "Histogram";
            
            % Set any user-specified properties.
            set(obj, namedArgs);
        end % constructor
    end
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the page.
            
            % Populate the pages.
            obj.PageMap("Histogram") = pages.HistogramPage("Parent", obj, "Visible", "On");
        end % setup
        
        function update(~)
            %UPDATE Update the layout. This method is empty because
            %there are no public properties of the layout.
            
        end % update
    end % methods (Access = protected)
end