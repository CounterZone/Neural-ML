classdef FClayer <layer
    %FCLAYER : Fully connected linear layer
    
    properties
        weight;
        Tfunc;
        Ffunc;
        insize;
        outsize;
    end
    
    methods
        function  nlayer=FClayer(insize,outsize,Tfunc,Ffunc)
            nlayer.insize=insize;
            nlayer.outsize=outsize;
            nlayer.Tfunc=Tfunc;
            nlayer.Ffunc=Ffunc;
        end
        function initiate(nlayer,scale)         % only support uniformly distributed values between -scale to scale
            W=rand([nlayer.outsize,nlayer.insize]);
            W=W-0.5*ones(size(W));
            W=W*scale*2;
            nlayer.weight=W; 
        end
        function out=forward(nlayer,input)
            out=nlayer.Tfunc(nlayer.weight*input); 
        end
        function [delta,dw]=BP(nlayer,updelta,upy,downy)
            delta=nlayer.weight'*(updelta.*nlayer.Ffunc(upy));
            dw=nlayer.Ffunc(upy).*updelta*downy';
        end
    end
    
end

