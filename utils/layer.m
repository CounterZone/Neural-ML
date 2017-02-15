classdef layer<handle
    %Abstract layer class
    
    properties(Abstract=true)
        updating
    end
    
    methods(Abstract=true)
       forward;
       BP;
    end
    
end

