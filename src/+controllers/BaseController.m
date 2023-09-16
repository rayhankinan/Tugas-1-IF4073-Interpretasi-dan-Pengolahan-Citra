classdef (Abstract) BaseController
    properties
        Model {mustBeA(Model, 'BaseModel')}
        View {mustBeA(View, 'BaseView')}
    end
    
    methods
        % Run the controller
        run(obj)
    end
end