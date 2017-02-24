(* ::Package:: *)

%   We modefied our codes to be more abstract. we use config files to give
%   the parameters for network constructors. Though the codes may look massive in one   
%   file, the actual file organization is clear and easy to use.

%p3.config
Biaslayer
FClayer,2x10
Tanhlayer
Biaslayer
FClayer,11x1
Tanhlayer
% p4.config
Biaslayer
FClayer,5x2
Tanhlayer
Biaslayer
FClayer,3x3
Tanhlayer


%   p3_main.m
% BPlearn=train
% BPrecall=test

p3=network('p3.config');
eror_train=[];
eror_test=[];

% generate test and train set
trainx=rand([1,200])*0.9+0.1;
trainy=2*((1./(trainx)-1)./9)-1;


testx=rand([1,100])*0.9+0.1;
testy=2*((1./(testx)-1)./9)-1;

% er=p3.train(trainx,trainy,0.4,0.008,5);% input, output, momentum,learning rate, 
% plot(er)
% er(size(er,2))

% er=p3.train(trainx,trainy,0.68,0.006,1);
er=p3.train(trainx,trainy,0.68,0.006,1);

for i=1:100
    er_train=p3.test(trainx,trainy);
    eror_train=[eror_train,er_train];
    
    er_test=p3.test(testx,testy);
    eror_test=[eror_test,er_test];
    
    er=p3.train(trainx,trainy,0.68,0.006,50);
    
    if er_train<0.01 || er_test<0.01
        disp(i*200);
        disp(er_train);
        disp(er_test);
        break
    end
    
end
% disp(eror_train);


p5=network('p3.config');
eror_train3=[];
eror_test3=[];

er3=p5.train(trainx,trainy,0.1,0.01,1);

for i=1:100
    er_train3=p5.test(trainx,trainy);
    eror_train3=[eror_train3,er_train3];
    
    er_test3=p5.test(testx,testy);
    eror_test3=[eror_test3,er_test3];
    
    er3=p5.train(trainx,trainy,0.1,0.01,50);
    
    if er_train3<0.01 || er_test3<0.01
        disp(i*200);
        disp(er_train3);
        disp(er_test3);
        break
    end
    
end


p6=network('p3.config');
eror_train4=[];
eror_test4=[];

er4=p6.train(trainx,trainy,0.3,0.015,1);

for i=1:100
    er_train4=p6.test(trainx,trainy);
    eror_train4=[eror_train4,er_train4];
    
    er_test4=p6.test(testx,testy);
    eror_test4=[eror_test4,er_test4];
    
    er4=p6.train(trainx,trainy,0.8,0.006,50);
    
    if er_train4<0.01 || er_test4<0.01
        disp(i*200);
        disp(er_train4);
        disp(er_test4);
        break
    end
    
end





% a=[]

% for i=1:0.01:10
 %   p3=network('p3.config');
  %  er=p3.train(trainx,trainy,0.7,0.001*i,000);
   % plot(er)
    % a=[a, er(size(er,2))];
% end

figure(1);
% disp(errall);
% plot(trainx,trainy,'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

plot(trainx,p3.recall(trainx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
hold on
% plot(testx,testy,'+b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
plot(testx,p3.recall(testx),'*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

x_ 1=0.1:0.001:1;
y_ 1=2*((1./(x_ 1)-1)./9)-1;
plot(x_ 1,y_ 1,'-');

hold off
axis auto
legend('Training output','Testing output','Desired output','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training and Testing Actual vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
% Plot actual vs desired output end

figure(2);
plot(eror_train,'+-r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
hold on
plot(eror_test,'*-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
hold off
axis auto

legend('Error training','Error testing','Location','best') 
xlabel('Steps (10000)','FontName','Times New Roman','FontSize',14);
ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training error and testing error history in every 10000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)


%{

figure(3);

plot(error_train _ 5,'-r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

hold on

plot(error_test _ 5,'*r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

 

plot(error_train _ 8,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);

plot(error_test _ 8,'*b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);

 

plot(error_train _ 9,'-c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

plot(error_test _ 9,'*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

 

plot(error_train _ 11,'-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

plot(error_test _ 11,'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

 

plot(error_train _ 20,'-g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);

plot(error_test _ 20,'*g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);

hold off

axis auto

 

legend('#PE=5,training','#PE=5,testing','#PE=8,training','#PE=8,testing','#PE=9,training','#PE=9,testing','#PE=11,training','#PE=11,testing','#PE=20,training','#PE=20,testing','Location','best') 

xlabel('Steps (10000)','FontName','Times New Roman','FontSize',14);

ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);

title('Training error and testing error history in every 10000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);

set(gca,'FontName','Times New Roman','FontSize',14)



figure(4);

plot(eror_test,'+-r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

hold on

plot(eror_test2,'*-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);

plot(eror_test3,'+-c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

plot(eror_test4,'*-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

 

hold off

axis auto

 

legend('momentum=0.2','momentum=0.4','momentum=0.6','momentum=0.8','Location','best') 

xlabel('Steps (10000)','FontName','Times New Roman','FontSize',14);

ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);

title('Testing error history in every 10000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);

set(gca,'FontName','Times New Roman','FontSize',14)

 

 

figure(5);

plot(testx,p3.recall(testx),'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

hold on

plot(testx,p4.recall(testx),'*k','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);

plot(testx,p5.recall(testx),'xc','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

plot(testx,p6.recall(testx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

 

plot(x_ 1,y_ 1,'-');

 

hold off

axis auto

 

legend('momentum=0.2 actural output','momentum=0.4 actural output','momentum=0.6 actural output','momentum=0.8 actural output','Desired output','Location','best') 

xlabel('Steps (10000)','FontName','Times New Roman','FontSize',14);

ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);

title('Testing Actual vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);

set(gca,'FontName','Times New Roman','FontSize',14)

%}


figure(6);

plot(eror_train,'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
hold on
plot(eror_test,'-r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

plot(eror_train3,'*b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
plot(eror_test3,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);


plot(eror_train4,'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
plot(eror_test4,'-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

hold off
axis auto
legend('Set1 Training, momentum=0.68,learning rate=0.006','Set1 Testing, momentum=0.68,learning rate=0.006','Set2 Training, momentum=0.1,learning rate=0.01','Set2 Testing, momentum=0.1,learning rate=0.01','Set3 Training, momentum=0.3,learning rate=0.015','Set3 Testing, momentum=0.3,learning rate=0.015','Location','best') 
xlabel('Steps (10000)','FontName','Times New Roman','FontSize',14);
ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Testing error history in every 10000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)

 

figure(7);
plot(testx,p3.recall(testx),'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
hold on
plot(testx,p5.recall(testx),'xk','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
plot(testx,p6.recall(testx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
 
plot(x_ 1,y_ 1,'-');
hold off
axis auto
legend('Set1 Testing, momentum=0.68,learning rate=0.006','Set2 Testing, momentum=0.1,learning rate=0.01','Set3 Testing, momentum=0.3,learning rate=0.015','Desired output','Location','best') 
xlabel('Steps (10000)','FontName','Times New Roman','FontSize',14);
ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Testing actual vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)

% p4_main.m
p4=network('p4.config');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           data I/O

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file=fopen('iris-train.txt');
d=fscanf(file,'% f % f % f % f & % f % f % f',[7,Inf]);
trainx=d(1:4,:);
trainy=d(5:7,:);
file=fopen('iris-test.txt');
d=fscanf(file,'% f % f % f % f & % f % f % f',[7,Inf]);
testx=d(1:4,:);
testy=d(5:7,:);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Training, record the history

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trainer=[];
tester=[];
rmse=[];

testrmse=[];
for i=1:500
    p4.train(trainx,trainy,0.7,0.01,5,75);
    rmse=[rmse,p4.test(trainx,trainy)];
    testrmse=[testrmse,p4.test(testx,testy)];
    trainer=[trainer,utils.Acc(trainy,p4.recall(trainx))];
    tester=[tester,utils.Acc(testy,p4.recall(testx))];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Plot the training history

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot(5*(1:500),tester)
hold on;
plot(5*(1:500),trainer);
legend('AccTest','AccTrain','Location','best') 
xlabel('Steps','FontName','Times New Roman','FontSize',14);
ylabel('Accurancy','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training & Test accuracy','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
hold off;
figure;

plot(5*(1:500),testrmse)
hold on;
plot(5*(1:500),rmse);
legend('RMSETest','RMSETrain','Location','best') 
xlabel('Steps','FontName','Times New Roman','FontSize',14);
ylabel('Error','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training & Test RMSE','FontName','Times New Roman','FontWeight','Bold','FontSize',16);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Analyse the final output of the Test set

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
yy=p4.recall(testx);
utils.Acc(yy,testy)
utils.ConfusionMatrix(utils.NorClass(yy),testy)



%     layer.m
%     an abstract defination of layer

classdef layer<handle
    % Abstract layer class
    
    properties(Abstract=true)
        updating
    end
    
    methods(Abstract=true)
       forward;
       BP;
    end
    
end

% FClayer.m
% implements the Fully connected linear layer
classdef FClayer <layer
    % FCLAYER : Fully connected linear layer
    
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
            % now, it only supports uniformly distributed values from -scale to scale
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
            % backpropagation. 
            %updelta: delta of the next layer
            % upy downy: output and input of this layer
            % return delta and dw of this layer
            
        
            delta=nlayer.weight'*updelta;
           
            dw=updelta*downy';
        end
        function update(nlayer,dw,lr)
            nlayer.weight=nlayer.weight+dw.*lr;
        end
    end
    
end


% Biaslayer.m
% implements the bias layer
classdef Biaslayer<layer
    % BIASLAYER 
    %   Add a Bias to the input
    
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


%  Tanhlayer.m
%  implements the tanh layer
classdef Tanhlayer <layer
    % Tanhlayer
    % Give tanh of the input
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

% utils.m
% some reuseable functions
classdef utils
    % some reuseable functions

    properties
    end
    
    methods(Static)
        function Acc=Acc(X,Y)% X and Y are colume vectors(each column represents 1 sample)
            [m,I]=max(X);
            [m,DI]=max(Y);
            Acc=sum (I==DI)/size(I,2);
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

    end
    
end


%   network.m
%   implements functions of a feedforward ANN
classdef network<handle
    % NETWORK
    
    properties
        layer
        nlayer % number of layers
    end
    
    methods
        function nw=network(config)
            % TODO:more parameters 
            % construct from a config file, which contains parameters of each layer
            nw.layer={};
        c=fopen(config); 
        i=0;
        while(1)
           l=fgetl(c);
           if l==-1
               break
           end
           i=i+1;
           l=regexp(l,',','split');
           if strcmp(l{1},'FClayer')
               l=regexp(l{2},'x','split');
             
               nw.layer{i}=FClayer(str2num(l{1}),str2num(l{2}));  % #ok<ST2NM>
               nw.layer{i}.initiate(1/sqrt(str2num(l{1})));
               % the initiation of weight is fixed: uniform distribution,
               % and the scale is determined by the dimensions  
           end
           if strcmp(l{1},'Tanhlayer')
               nw.layer{i}=Tanhlayer();
           end
           if strcmp(l{1},'Biaslayer')
               nw.layer{i}=Biaslayer();
           end    
           
        end
        nw.nlayer=i;
        end

        function [err,dw]=S_train(nw,X,Y,momentum,lastdw,lr)
            % one-step BP training. 
            % TODO:other training  methods?
            yy=cell(1,nw.nlayer+1);
            yy{1}=X;
            for i=1:nw.nlayer
                
                yy{i+1}=nw.layer{i}.forward(yy{i});
            end 
            err=sqrt(mean(sum((Y-yy{nw.nlayer+1}).^2,1)));
            
            delta=cell(1,nw.nlayer+1);
            delta{1}=Y-yy{nw.nlayer+1};
            dw=cell(1,nw.nlayer);
             for i=1:nw.nlayer
                 if nw.layer{i}.updating
                    [delta{i+1},dw{nw.nlayer-i+1}]=nw.layer{nw.nlayer-i+1}.BP(delta{i},yy{nw.nlayer-i+2},yy{nw.nlayer-i+1});
                 else
                    delta{i+1}=nw.layer{nw.nlayer-i+1}.BP(delta{i},yy{nw.nlayer-i+2},yy{nw.nlayer-i+1});
                 end
             end
             for i=1:nw.nlayer
                  if nw.layer{i}.updating
                      dw{i}=dw{i}+momentum.*lastdw{i};
                  nw.layer{i}.update(dw{i},lr);
                  end
             end 
           
        end
        function err_his=train(nw,X,Y,momentum,lr,max_epoch,epoch_size)
            % Train the network. 
            % TODO batch construct;epoch size;Training config ????
            lastdw=cell(1,nw.nlayer);
            for i=1:nw.nlayer               
                lastdw{i}=0;
            end 
           err_his=ones(1,max_epoch);
            for i=1:max_epoch
            [err_his(i),dw]=nw.S_train(X,Y,momentum,lastdw,lr);
            lastdw=dw;
           end
        end
        
        function Y=recall(nw,X)
            % nothing special
            Y=cell(1,nw.nlayer+1);
            Y{1}=X;
            for i=1:nw.nlayer
                Y{i+1}=nw.layer{i}.forward(Y{i});
            end
            Y=Y{nw.nlayer+1};
        end
        
        function err=test(nw,X,Y)
            % TODO  maybe more kinds of errors?
          err=sqrt(mean(sum((Y-nw.recall(X)).^2,1)));

        end
    end
    
end


%
%
%
%
%
