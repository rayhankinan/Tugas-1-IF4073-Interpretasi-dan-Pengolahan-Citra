classdef AppLayout < handle
    properties
        PageMap containers.Map;
        f(1, 1) matlab.ui.Figure;
    end
    
    methods
        function obj = AppLayout(f)
            %LAUNC Launch the Histogram application.
            
            arguments
                f(1, 1) matlab.ui.Figure = uifigure()
            end % arguments
            
            obj.PageMap = containers.Map();
            
            obj.PageMap("Histogram") = pages.HistogramPage("Parent", f, "Visible", "off");
        end
        
        function Run(obj)
            set(obj.PageMap("Histogram"), "Visible", "on");
        end
    end
end