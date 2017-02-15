classdef utils
    %UTILS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        function Acc=Acc(X,Y)% X and Y are colume vectors(each column represents 1 sample)
            [m,I]=max(X);
            [m,DI]=max(Y);
            Acc=sum(I==DI)/size(I,2);
        end
    end
    
end

