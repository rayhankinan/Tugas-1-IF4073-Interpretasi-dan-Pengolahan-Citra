classdef HistogramController < controllers.BaseController
    methods
        % Constructor
        function obj = HistogramController()
            obj.Model = models.HistogramModel();
            obj.View = views.HistogramView();
        end
        
        % Run
        function Run(obj)
            % Get the image path
            path = obj.View.GetInput();
            
            % Load the image
            obj.Model = factories.ImageWrapperFactory.create(path);
            
            % Compute the histogram
            hist = obj.Model.GetHistogram();
            
            % Display the histogram
            obj.View.SetOutput(hist);
        end
    end
end