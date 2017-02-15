classdef hw4net<handle
 % Network for hw4. Containing 2 FC layers.
    properties(Access=private)
    lastdw1;
    lastdw2;
    end
    properties
        layer1;
        layer2;
    end
    
    methods
        function hw=hw4net()
            % 1input + 1bias->10PE + 1bias->1output
            hw.layer1=FClayer(2,10,@tanh,@Ffunc,0.01);
            hw.layer1.initiate(0.1);
            hw.layer2=FClayer(10,1,@tanh,@Ffunc,0.01);
            hw.layer2.initiate(0.1);
            hw.lastdw1=0;
            hw.lastdw2=0;
        end
        function y=forward(hw,x)
        y1=hw.layer1.forward(x);
        
        y=hw.layer2.forward(y1);
        end
            
        function err=train(hw,X,Y,alpha)
            % should i put some comments here?
            yy1=hw.layer1.forward(X);
            yy=hw.layer2.forward(yy1);
            D=Y-yy;
            err=sqrt(mean(D.*D));
            disp(err);
 
            [D2,dw2]=hw.layer2.BP(D,yy,yy1);
            [D1,dw1]=hw.layer1.BP(D2,yy1,X);
             hw.lastdw1=dw1+alpha*hw.lastdw1;
             hw.lastdw2=dw2+alpha*hw.lastdw1;
            hw.layer1.update( hw.lastdw1);
            hw.layer2.update( hw.lastdw2);
        end
        
        function errt=test(hw,X,Y)
            % should i put some comments here?
            yy1=hw.layer1.forward(X);
            yy=hw.layer2.forward(yy1);
            D=Y-yy;
            errt=sqrt(mean(D.*D));
            %disp(err);
 
        end

    end
    
end

