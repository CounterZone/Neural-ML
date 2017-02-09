classdef layer<handle
    %Abstract layer class
    
    properties(Abstract=true)
        insize;
        outsize;% size of input and output vectors
    end
    
    methods(Abstract=true)
       forward;
        
    end
    
end

