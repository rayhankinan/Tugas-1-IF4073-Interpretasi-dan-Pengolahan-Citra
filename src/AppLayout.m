classdef AppLayout < matlab.ui.componentcontainer.ComponentContainer
    properties (Access = private)
        % Page objects.
        Histogram pages.HistogramPage
        Brightening pages.BrighteningPage
        
        % Key to the current page.
        CurrentPageKey string
        
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
            
            % Set any user-specified properties.
            set(obj, namedArgs);
        end % constructor
    end
    
    methods (Access = protected)
        function setup(obj)
            %SETUP Initialize the page.
            
            % Create the layout.
            g = uigridlayout("Parent", obj, "RowHeight", {50, "1x"}, "ColumnWidth", "1x");
            
            % Create panels.
            dropdownPanel = uipanel("Parent", g, "Position", [0, 0, 50, 50]);
            pagePanel = uipanel("Parent", g, "Position", [0, 0, 50, 50]);
            
            % Populate the pages.
            obj.Histogram = pages.HistogramPage("Parent", pagePanel, "Visible", "On");
            obj.Brightening = pages.BrighteningPage("Parent", pagePanel, "Visible", "Off");
            
            % Set the current page.
            obj.CurrentPageKey = "Histogram";
            
            % Fill the drop-down menu with the page names.
            obj.DropDown = uidropdown("Parent", dropdownPanel, "Items", ["Histogram" "Brightening"], "Value", obj.CurrentPageKey, "ValueChangedFcn", @obj.onDropDownValueChanged);
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
            set(get(obj, obj.CurrentPageKey), "Visible", "Off");
            
            % Update the current page.
            obj.CurrentPageKey = obj.DropDown.Value;
            
            % Show the new page.
            set(get(obj, obj.CurrentPageKey), "Visible", "On");
        end % onDropDownValueChanged
    end % methods
end