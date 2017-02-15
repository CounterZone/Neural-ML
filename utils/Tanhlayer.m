classdef Tanhlayer <layer
    properties
        updating
    end
    methods
        function Thlayer=Tanhlayer()
            Thlayer.updating=false;
        end
        function y=forward(Thlayer,x)
                y=tanh(x);
        end
        function delta=BP(Thlayer,updelta,upy,downy)
            delta=(1-upy.*upy).*updelta;
        end
    end
end