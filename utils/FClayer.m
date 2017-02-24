classdef FClayer <layer
    %FCLAYER : Fully connected linear layer
    
    properties
        weight;
        insize;
        outsize;% size of input and output vectors
        updating
    end
    
    methods
        function  nlayer=FClayer(insize,outsize)
    
            nlayer.insize=insize;
            nlayer.outsize=outsize;
            nlayer.updating=true;

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
            out=nlayer.weight*input;
        end
        function [delta,dw]=BP(nlayer,updelta,upy,downy)
            %upy:output of this layer
            %downy:input of this layer
            
            %backpropagation. 
            %updelta: delta of the next layer
            %upy downy: output and input of this layer
            %return delta and dw of this layer
            
        
            delta=nlayer.weight'*updelta;
           
            dw=updelta*downy';
        end
        function update(nlayer,dw,lr)
            nlayer.weight=nlayer.weight+dw.*lr;
        end
    end
    
end

