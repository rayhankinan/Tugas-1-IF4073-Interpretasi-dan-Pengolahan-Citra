classdef AppLayout < matlab.ui.componentcontainer.ComponentContainer
    properties (Access = private)
        % Map of page names to page objects.
        PageMap containers.Map
        CurrentPage string
        
        % UI components.
        DropDown matlab.ui.control.DropDown
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
            
            % Set any user-specified properties.
            set(obj, namedArgs);
        end % constructor
    end
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the page.
            
            % Create the layout.
            g = uigridlayout("Parent", obj, "RowHeight", {50, "1x"}, "ColumnWidth", "1x");
            
            % Create the axes for the dropdown.
            panel = uipanel("Parent", g, "Position", [0, 0, 50, 50]);
            
            % Populate the pages.
            obj.PageMap("Histogram") = pages.HistogramPage("Parent", g, "Visible", "On");
            
            % Setup the current page.
            obj.CurrentPage = "Histogram";
            
            % Fill the drop-down menu with the page names.
            obj.DropDown = uidropdown("Parent", panel, "Items", obj.PageMap.keys, "Value", obj.CurrentPage, "ValueChangedFcn", @obj.onDropDownValueChanged);
        end % setup
        
        function update(~)
            %UPDATE Update the layout. This method is empty because
            %there are no public properties of the layout.
            
        end % update
    end % methods (Access = protected)
    
    methods (Access = private)
        function onDropDownValueChanged(obj, ~, ~)
            %ONDROPDOWNVALUECHANGED Respond to a change in the drop-down
            %menu selection.
            
            % Hide the current page.
            set(obj.PageMap(obj.CurrentPage), "Visible", "Off");
            
            % Update the current page selection.
            obj.CurrentPage = obj.DropDown.Value;
            
            % Show the new page.
            set(obj.PageMap(obj.CurrentPage), "Visible", "On");
        end % onDropDownValueChanged
    end % methods
end