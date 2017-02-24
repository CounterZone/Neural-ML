%BPlearn=train
%BPrecall=test

p5=network('p5.config');
p5_2=network('p5.config');
p5_3=network('p5.config');


eror_train=[];
%eror_train2=[];
%eror_train3=[];
eror_test1=[];%The same distribution as training
eror_test2=[];%2(2).1
eror_test3=[];%2(2).2


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generate training set
%traininput:the input of f(x)
%Trainx: the output of f(x)
%f(x)=x+.2x^2
%Trainy: the output of MLP, ideally the same as traininput
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
traininput = 2 *sin(2*pi*[1:20]/20);
trainx=(traininput+0.2*(traininput.^2)-0.8)/2;
trainy=traininput/2;

traininput_v = 2 *sin(2*pi*[1:0.1:20]/20);
trainx_v=(traininput_v+0.2*(traininput_v.^2)-0.8)/2;% desired output viewing
trainy_v=traininput_v/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generate scaled testing set No.1 -- The same distribution as training
%x:-0.8, then/2
%y:/2
%In order to drop the point into [-1,1] range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

testinput_1=2 *sin(2*pi*rand([1,20]));
testx_1 = (testinput_1+0.2*(testinput_1.^2)-0.8)/2;
testy_1=testinput_1/2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generate scaled testing set No.2
%x:-0.19, then/1.016
%y:+0.023, then/1.023
%In order to drop the point into [-1,1] range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

testinput_2 = 0.8*sin(2*pi*[1:25]/10)+0.25*cos(2*pi*[1:25]/25);

testx_2 = (testinput_2+0.2*(testinput_2.^2)-0.19)/1.016;

testy_2 = (testinput_2+0.023)/1.023;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Generate testing set No.3
%x:[-1,1]
%y:/max absolute value
%In order to drop the point into [-1,1] range
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

testinput_3 =sqrt(1)*randn(1,50);

[ma,I1]=max(testinput_3);

[mi,I2]=min(testinput_3);

if mi+ma>0
    
testy_3 = testinput_3/ma;
elseif mi+ma<=0

testy_3 =testinput_3/mi*(-1);

end


testx_3 = testinput_3+0.2*(testinput_3.^2);
[ma_testx_3,I2]=max(testx_3);
[mi_testx_3,I3]=min(testx_3);
testx_3=(testx_3-0.5*(ma_testx_3+mi_testx_3))*2/(ma_testx_3-mi_testx_3);

%trainmatrix=p5.train(trainx,trainy,0.9,0.01,1);%BPlearn
%input, output, momentum,learning rate,learning steps(per epoch)

for i=1:60
    trainmatrix=p5.train(trainx,trainy,0.9,0.01,50);%BPlearn
    er_train=p5.test(trainx,trainy)*p5.test(trainx,trainy); 
    %BPrecall(train), what we have is RMSD, so we need to calculate the
    %square
    eror_train=[eror_train,er_train];
  
    er_test1=p5.test(testx_1,testy_1)*p5.test(testx_1,testy_1); %BPrecall(test)for test1
    eror_test1=[eror_test1,er_test1];
    
    er_test2=p5.test(testx_2,testy_2)*p5.test(testx_2,testy_2); %BPrecall(test)for test2
    eror_test2=[eror_test2,er_test2];
    
    er_test3=p5.test(testx_3,testy_3)*p5.test(testx_3,testy_3); %BPrecall(test)for test3
    eror_test3=[eror_test3,er_test3];
    

    
    if er_train<0.0015%Stop condition
        disp(i*200);
        disp(er_train);
        %disp(er_test);
        break
    end
    
end



%{
%2
for i=1:60
    trainmatrix_2=p5_2.train(trainx,trainy,0.9,0.015,50);%BPlearn
    er_train_2=p5_2.test(trainx,trainy)*p5_2.test(trainx,trainy); 
    %BPrecall(train), what we have is RMSD, so we need to calculate the
    %square
    eror_train2=[eror_train2,er_train_2];
  
    er_test1=p5_2.test(testx_1,testy_1); %BPrecall(test)for test1
    eror_test1=[eror_test1,er_test1];
    
    er_test2=p5_2.test(testx_2,testy_2); %BPrecall(test)for test2
    eror_test2=[eror_test2,er_test2];
    
    er_test3=p5_2.test(testx_3,testy_3); %BPrecall(test)for test3
    eror_test3=[eror_test3,er_test3];
    

    
    if er_train_2<0.0015%Stop condition
        disp(i*200);
        disp(er_train_2);
        %disp(er_test);
        break
    end
    
end
%disp(eror_train);



%3
for i=1:60
    trainmatrix_3=p5_3.train(trainx,trainy,0.9,0.05,50);%BPlearn
    er_train_3=p5_3.test(trainx,trainy)*p5_3.test(trainx,trainy); 
    %BPrecall(train), what we have is RMSD, so we need to calculate the
    %square
    eror_train3=[eror_train3,er_train_3];
  
    er_test1=p5_3.test(testx_1,testy_1); %BPrecall(test)for test1
    eror_test1=[eror_test1,er_test1];
    
    er_test2=p5_3.test(testx_2,testy_2); %BPrecall(test)for test2
    eror_test2=[eror_test2,er_test2];
    
    er_test3=p5_3.test(testx_3,testy_3); %BPrecall(test)for test3
    eror_test3=[eror_test3,er_test3];
    

    
    if er_train_3<0.0015%Stop condition
        disp(i*200);
        disp(er_train_3);
        %disp(er_test);
        break
    end
    
end
%disp(eror_train);


%}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scale back:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

trainx_rs=trainx*2+0.8;
recalltrain_rs = p5.forward(trainx)*2;
trainy_rs=trainy*2;

testx_1_rs =testx_1*2+0.8;
recall_1_rs = p5.forward(testx_1)*2;

testx_2_rs =testx_2*1.016+0.19;
recall_2_rs = p5.forward(testx_2)*1.023-0.023;
testy_2_rs = testy_2*1.023-0.023;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Scale back end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%All the codes below are for drawing figures

figure(1);
%disp(errall);
%plot(trainx,trainy,'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

%plot(trainx_rs,recalltrain_rs,'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);
%hold on
%plot(trainx_rs,trainy_rs,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
%plot(testx_2_rs,recall_2_rs,'*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);
%plot(testx_2_rs,testy_2_rs,'-c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

plot(trainx,p5.forward(trainx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on
%plot(testx_2,p5.forward(testx_2),'+g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',8);
plot(testx_3,p5.forward(testx_3),'xk','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);

plot(trainx_v,trainy_v,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
%plot(testx_3,p5.forward(testx_3),'*g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);


hold off
axis auto
legend('Training output','Test set 2 output','Desired output','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training actural output vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
%Plot actual vs desired output end



figure(2);
plot(eror_train,'+-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on
%plot(eror_test2,'+-g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',8);
plot(eror_test3,'+-k','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
%plot(eror_test3,'*-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
hold off
axis auto

legend('Error training','Error test set 2','Location','best') 
xlabel('Steps(1000)','FontName','Times New Roman','FontSize',14);
ylabel('MSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training error and testing error history in every 1000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)


%{

figure(3);

%plot(error_0_01,'-r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

hold on

plot(error_0_01,'-*r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);

 

%plot(error_train_8,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);

plot(error_0_5,'-*b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);

 

%plot(error_train_9,'-c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

plot(error_0_1,'-*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

 

plot(error_0_80,'-*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

%plot(error_test_11,'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

 

%plot(error_train_20,'-g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);

%plot(error_0_80,'*g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',4);

hold off

axis auto

 

legend('#PE=1','#PE=5','#PE=10','#PE=80','Location','best') 

xlabel('Steps(1000)','FontName','Times New Roman','FontSize',14);

ylabel('MSE','FontName','Times New Roman','FontSize',14,'Rotation',90);

title('Training error in every 1000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);

set(gca,'FontName','Times New Roman','FontSize',14)
%}

%{
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
%}
