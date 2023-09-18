function varargout = launchApp(f)
%LAUNCHMVCAPP Launch the Histogram application.

arguments
    f(1, 1) matlab.ui.Figure = uifigure()
end % arguments

% Create the model.
m = models.HistogramModel();

% Create the page.
pages.HistogramPage(m, "Parent", f);

% Return the figure handle if requested.
if nargout > 0
    nargoutchk(1, 1)
    varargout{1} = f;
end % if

end % launchHistogramApp