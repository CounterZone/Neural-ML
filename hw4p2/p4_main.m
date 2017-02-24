p4=network('p4.config');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           data I/O

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file=fopen('iris-train.txt');
d=fscanf(file,'%f %f %f %f & %f %f %f',[7,Inf]);
trainx=d(1:4,:);
trainy=d(5:7,:);
file=fopen('iris-test.txt');
d=fscanf(file,'%f %f %f %f & %f %f %f',[7,Inf]);
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

