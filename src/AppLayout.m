classdef AppLayout < matlab.ui.componentcontainer.ComponentContainer
    properties (Access = private)
        % Page objects.
        Histogram(1, 1) pages.HistogramPage
        Brightening(1, 1) pages.BrighteningPage
        Negative(1, 1) pages.NegativePage
        LogTransformation(1, 1) pages.LogTransformationPage
        PowerTransformation(1, 1) pages.PowerTransformationPage
        HistogramEqualization(1, 1) pages.HistogramEqualizationPage
        HistogramMatching(1, 1) pages.HistogramMatchingPage
        
        % UI components.
        DropDown(1, 1) matlab.ui.control.DropDown
        
        % App Model.
        Model(1, 1) models.AppModel
        
        % Listener object used to respond dynamically to model events.
        Listener(:, 1) event.listener {mustBeScalarOrEmpty}
    end
    
    methods
        function obj = AppLayout(namedArgs)
            %APPLAYOUT Construct an instance of this class.
            
            arguments
                namedArgs.?pages.HistogramPage
            end
            
            % Call the superclass constructor.
            obj@matlab.ui.componentcontainer.ComponentContainer("Parent", [], "Units", "normalized", "Position", [0, 0, 1, 1]);
            
            % Create a listener for the a parameter.
            obj.Listener = listener(obj.Model, "KeyChanged", @obj.onKeyChanged);
            
            % Set any user-specified properties.
            set(obj, namedArgs);
            
            % Refresh the layout.
            obj.onKeyChanged();
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
            obj.Negative = pages.NegativePage("Parent", pagePanel, "Visible", "Off");
            obj.LogTransformation = pages.LogTransformationPage("Parent", pagePanel, "Visible", "Off");
            obj.PowerTransformation = pages.PowerTransformationPage("Parent", pagePanel, "Visible", "Off");
            obj.HistogramEqualization = pages.HistogramEqualizationPage("Parent", pagePanel, "Visible", "Off");
            obj.HistogramMatching = pages.HistogramMatchingPage("Parent", pagePanel, "Visible", "Off");
            
            % Fill the drop-down menu with the page names.
            obj.DropDown = uidropdown("Parent", dropdownPanel, "Items", ["Histogram" "Brightening" "Negative" "LogTransformation" "PowerTransformation" "HistogramEqualization" "HistogramMatching"], "ValueChangedFcn", @obj.onDropDownValueChanged);
        end % setup
        
        function update(~)
            %UPDATE Update the layout. This method is empty because
            %there are no public properties of the layout.
            
        end % update
    end % methods (Access = protected)
    
    methods (Access = private)
        function onKeyChanged(obj, ~, ~)
            %ONKEYCHANGED Respond to a change in the model key.
            
            % Show the new page.
            set(get(obj, obj.Model.CurrentPageKey), "Visible", "On");
            
            % Update the drop-down menu.
            set(obj.DropDown, "Value", obj.Model.CurrentPageKey);
        end % onKeyChanged
        
        function onDropDownValueChanged(obj, ~, ~)
            %ONDROPDOWNVALUECHANGED Respond to a change in the drop-down
            %menu selection.
            
            % Hide the current page.
            set(get(obj, obj.Model.CurrentPageKey), "Visible", "Off");
            
            % Update the model.
            obj.Model.SetCurrentPageKey(obj.DropDown.Value);
        end % onDropDownValueChanged
    end % methods
end