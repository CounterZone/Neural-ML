classdef Biaslayer<layer
    %BIASLAYER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        updating
    end
    
    methods
        function blayer=Biaslayer()
            blayer.updating=false;
        end
        function y=forward(blayer,x)
                y=[x;ones(1,size(x,2))];
        end
        function delta=BP(blayer,updelta,upy,downy)
            
            delta=updelta(1:(size(updelta,1)-1),:);
        end
    end
    
end

