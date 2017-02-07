classdef layer<handle
    %Layer
    
    properties(Abstract=true)
        insize;
        outsize;
    end
    
    methods(Abstract=true)
       forward;
        
    end
    
end

