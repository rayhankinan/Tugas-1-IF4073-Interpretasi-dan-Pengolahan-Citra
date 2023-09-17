function varargout = launchHistogramApp(f)
%LAUNCHMVCAPP Launch the Histogram application.

arguments
    f(1, 1) matlab.ui.Figure = uifigure()
end % arguments

% Rename figure.
f.Name = "Histogram App";

% Create the layout.
g = uigridlayout("Parent", f, "RowHeight", {"1x", 40}, "ColumnWidth", "1x");

% Create the model.
m = models.HistogramModel();

% Create the view.
views.HistogramView(m, "Parent", g);

% Create the controller.
controllers.HistogramController(m, "Parent", g);

% Create toolbar to reset the model.
icon = fullfile(matlabroot, "toolbox", "matlab", "icons", "tool_rotate_3d.png");
tb = uitoolbar("Parent", f);
uipushtool("Parent", tb, "Icon", icon, "Tooltip", "Reset the data.", "ClickedCallback", @onReset);

% Function to reset the model.
    function onReset(~, ~)
        %ONRESET Callback function for the toolbar reset button.
        
        % Reset the model.
        m.reset()
        
    end % onReset

% Return the figure handle if requested.
if nargout > 0
    nargoutchk(1, 1)
    varargout{1} = f;
end % if

end % launchHistogramApp