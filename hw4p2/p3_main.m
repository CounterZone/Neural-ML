%BPlearn=train
%BPrecall=test

p3=network('p3.config');
eror_train=[];
eror_test=[];

% generate test and train set
trainx=rand([1,200])*0.9+0.1;
trainy=2*((1./(trainx)-1)./9)-1;


testx=rand([1,100])*0.9+0.1;
testy=2*((1./(testx)-1)./9)-1;

%er=p3.train(trainx,trainy,0.4,0.008,5);%input, output, momentum,learning rate, 
%plot(er)
%er(size(er,2))

%er=p3.train(trainx,trainy,0.68,0.006,1);
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
%disp(eror_train);


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





%a=[]

%for i=1:0.01:10
 %   p3=network('p3.config');
  %  er=p3.train(trainx,trainy,0.7,0.001*i,000);
   % plot(er)
    %a=[a, er(size(er,2))];
%end

figure(1);
%disp(errall);
%plot(trainx,trainy,'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

plot(trainx,p3.recall(trainx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
hold on
%plot(testx,testy,'+b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
plot(testx,p3.recall(testx),'*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

x_1=0.1:0.001:1;
y_1=2*((1./(x_1)-1)./9)-1;
plot(x_1,y_1,'-');

hold off
axis auto
legend('Training output','Testing output','Desired output','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training and Testing Actual vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
%Plot actual vs desired output end

figure(2);
plot(eror_train,'+-r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
hold on
plot(eror_test,'*-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
hold off
axis auto

legend('Error training','Error testing','Location','best') 
xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);
ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training error and testing error history in every 10000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)


%{

figure(3);

plot(error_train_5,'-r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

hold on

plot(error_test_5,'*r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

 

plot(error_train_8,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);

plot(error_test_8,'*b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);

 

plot(error_train_9,'-c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

plot(error_test_9,'*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

 

plot(error_train_11,'-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

plot(error_test_11,'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

 

plot(error_train_20,'-g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);

plot(error_test_20,'*g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);

hold off

axis auto

 

legend('#PE=5,training','#PE=5,testing','#PE=8,training','#PE=8,testing','#PE=9,training','#PE=9,testing','#PE=11,training','#PE=11,testing','#PE=20,training','#PE=20,testing','Location','best') 

xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);

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

xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);

ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);

title('Testing error history in every 10000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);

set(gca,'FontName','Times New Roman','FontSize',14)

 

 

figure(5);

plot(testx,p3.recall(testx),'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

hold on

plot(testx,p4.recall(testx),'*k','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);

plot(testx,p5.recall(testx),'xc','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

plot(testx,p6.recall(testx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

 

plot(x_1,y_1,'-');

 

hold off

axis auto

 

legend('momentum=0.2 actural output','momentum=0.4 actural output','momentum=0.6 actural output','momentum=0.8 actural output','Desired output','Location','best') 

xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);

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
xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);
ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Testing error history in every 10000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)

 

figure(7);
plot(testx,p3.recall(testx),'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
hold on
plot(testx,p5.recall(testx),'xk','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',4);
plot(testx,p6.recall(testx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
 
plot(x_1,y_1,'-');
hold off
axis auto
legend('Set1 Testing, momentum=0.68,learning rate=0.006','Set2 Testing, momentum=0.1,learning rate=0.01','Set3 Testing, momentum=0.3,learning rate=0.015','Desired output','Location','best') 
xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);
ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Testing actual vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)

