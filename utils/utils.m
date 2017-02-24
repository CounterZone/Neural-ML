classdef utils
% some reuseable functions

    properties
    end
    
    methods(Static)
        function Acc=Acc(X,Y)% X and Y are colume vectors(each column represents 1 sample)
            [m,I]=max(X);
            [m,DI]=max(Y);
            Acc=sum(I==DI)/size(I,2);
        end
            function out=NorClass(Y)% set maximum element to 1, others to 0
            [m,I]=max(Y);
            out=zeros(size(Y));
            for i=1:size(Y,2) % TODO  matrix form
                out(I(i),i)=1;
            end
            end

        function m=ConfusionMatrix(yy,Y)
            % give the confusion matrix
            % yy:actual  Y:desired
            % actual output is the column
            m=zeros(size(yy,1));
            for i=1:size(yy,2)% TODO matrix form
                for j=1:size(yy,1)
                    if yy(j,i)==1
                        for k=1:size(Y,1)
                            if Y(k,i)==1
                                m(j,k)=m(j,k)+1;
                            end
                        end
                    end
                end
            
            end
            
        end
        
        
        function out=rescale(min,max,X)
        out=(X-min)./(max-min);
        out=2*out-1;
        end
        function out=anti_rescale(min,max,X)
        out=(X+1)./2;
        out=out*(max-min)+min;
        end
    end
    
end

