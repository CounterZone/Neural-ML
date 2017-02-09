classdef hw4net<handle
 % Network for hw4. Containing 2 FC layers.
    
    properties
        layer1;
        layer2;
    end
    
    methods
        function hw=hw4net()
            hw.layer1=FClayer(2,10,@tanh,@Ffunc,0.005);
            hw.layer1.initiate(0.1);
            hw.layer2=FClayer(10,1,@tanh,@Ffunc,0.005);
            hw.layer2.initiate(0.1);

        end
        function y=forward(hw,x)
        y1=hw.layer1.forward(x);
        y=hw.layer2.forward(y1);
        end
        function err=train(hw,X,Y)
            % should i put some comments here?
        yy1=hw.layer1.forward(X);
        yy=hw.layer2.forward(yy1);
             D=Y-yy;
             err=(mean(D.*D))^0.5;
                [D2,dw2]=hw.layer2.BP(D,yy,yy1);
                [D1,dw1]=hw.layer1.BP(D2,yy1,X);
 
               hw.layer1.update(dw1);
               hw.layer2.update(dw2);
        end
    end
    
end

