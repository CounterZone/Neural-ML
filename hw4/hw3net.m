classdef hw3net<handle
    %NETWORK Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        layer1;
        layer2;
    end
    
    methods
        function hw=hw3net(scale)
            hw.layer1=FClayer(2,10,@tanh,@Ffunc);
            hw.layer1.initiate(scale);
            hw.layer2=FClayer(10,1,@tanh,@Ffunc);
            hw.layer2.initiate(scale);

        end
        function y=forward(hw,x)
        y1=hw.layer1.forward(x);
        y=hw.layer2.forward(y1);
        end
        function err=train(hw,X,Y,lr)
        yy1=hw.layer1.forward(X);
        yy=hw.layer2.forward(yy1);
             D=Y-yy;
             err=sum(D.*D);
                [D2,dw2]=hw.layer2.BP(D,yy,yy1);
                [D1,dw1]=hw.layer1.BP(D2,yy1,X);
 
               hw.layer1.weight=hw.layer1.weight+lr*dw1;
               hw.layer2.weight=hw.layer2.weight+lr*dw2;
        end
    end
    
end

