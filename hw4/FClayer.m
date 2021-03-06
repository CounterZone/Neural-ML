classdef FClayer <layer
    %FCLAYER : Fully connected linear layer
    
    properties
        weight;
        Tfunc;
        Ffunc;
        insize;
        outsize;
        lr;
    end
    
    methods
        function  nlayer=FClayer(insize,outsize,Tfunc,Ffunc,lr)
            % constructor. Tfunc is transfer function, Ffunc is the derivative
            % of Tfunc(with respect to Tfunc)
            nlayer.insize=insize;
            nlayer.outsize=outsize;
            nlayer.Tfunc=Tfunc;
            nlayer.Ffunc=Ffunc;
            nlayer.lr=lr;

        end
        function initiate(nlayer,scale)        
            %now, it only supports uniformly distributed values from -scale to scale
            W=rand([nlayer.outsize,nlayer.insize]);
            W=W-0.5*ones(size(W));
            W=W*scale*2;
            nlayer.weight=W; 
        end
        function out=forward(nlayer,input)
            % recall
            out=nlayer.Tfunc(nlayer.weight*input); 
        end
        function [delta,dw]=BP(nlayer,updelta,upy,downy)
            %backpropagation. 
            %updelta: delta of the next layer
            %upy downy: output and input of this layer
            %return delta and dw of this layer
            delta=nlayer.weight'*(updelta.*nlayer.Ffunc(upy));
            dw=nlayer.Ffunc(upy).*updelta*downy';
        end
        function update(nlayer,dw)
            nlayer.weight=nlayer.weight+dw.*nlayer.lr;
        end
    end
    
end

