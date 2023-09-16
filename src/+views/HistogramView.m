classdef HistogramView < views.BaseView
    methods
        % Get input from GUI
        function data = GetInput(obj)
            [filename, pathname] = uigetfile('*.bmp', 'Select an image!');
            
            if isequal(filename,0) || isequal(pathname,0)
                data = [];
            else
                data = imread(fullfile(pathname, filename));
            end
        end
        
        % Show output to GUI
        function SetOutput(obj, data)
            bar(data);
        end
    end
end