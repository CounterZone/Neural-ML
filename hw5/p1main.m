p4={};
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           data I/O

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
file=fopen('iris-train.txt');
d=fscanf(file,'%f %f %f %f & %f %f %f',[7,Inf]);
trax=d(1:4,:);
tray=d(5:7,:);
file=fopen('iris-test.txt');
d=fscanf(file,'%f %f %f %f & %f %f %f',[7,Inf]);
testx=d(1:4,:);
testy=d(5:7,:);
X=[trax,testx];
Y=[tray,testy];
cv=utils.cross_val(X,Y,3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Training, record the history

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trainer={[],[],[]};
tester={[],[],[]};
rmse={[],[],[]};
testrmse={[],[],[]};

for f=1:3
p4{f}=network('p4.config');

testx=cv{1,f};
testy=cv{2,f};
trainx=cv{3,f};
trainy=cv{4,f};
for i=1:500
    p4{f}.train(trainx,trainy,0.7,0.01,5,100);
    rmse{f}=[rmse{f},p4{f}.test(trainx,trainy)];
    testrmse{f}=[testrmse{f},p4{f}.test(testx,testy)];
    trainer{f}=[trainer{f},utils.Acc(trainy,p4{f}.recall(trainx))];
    tester{f}=[tester{f},utils.Acc(testy,p4{f}.recall(testx))];

end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Plot the training history

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for f=1:3
h1=figure;

plot(5*(1:500),tester{f})
hold on;
plot(5*(1:500),trainer{f});
legend('AccTest','AccTrain','Location','best') 
xlabel('Steps','FontName','Times New Roman','FontSize',14);
ylabel('Accurancy','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training & Test accuracy','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
hold off;

saveas(h1,['Acc_',int2str(f),'.png']);
h2=figure;

plot(5*(1:500),testrmse{f})
hold on;
plot(5*(1:500),rmse{f});
legend('RMSETest','RMSETrain','Location','best') 
xlabel('Steps','FontName','Times New Roman','FontSize',14);
ylabel('Error','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training & Test RMSE','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
saveas(h2,['RMSE_',int2str(f),'.png']);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Analyse the final output of the Test set

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for f=1:3
testx=cv{1,f};
testy=cv{2,f};
yy=p4{f}.recall(testx);
utils.Acc(yy,testy)
utils.ConfusionMatrix(utils.NorClass(yy),testy)
end

for f=1:3
testx=cv{3,f};
testy=cv{4,f};
yy=p4{f}.recall(testx);
utils.Acc(yy,testy)
utils.ConfusionMatrix(utils.NorClass(yy),testy)
end