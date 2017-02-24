%% data I/O
trainy = 2 *sin(2*pi*[1:20]/20);
trainy=sort(trainy);
trainx=trainy+0.2*(trainy.^2);

test1y = 0.8*sin(2*pi*[1:50]/10)+0.25*cos(2*pi*[1:50]/25);
test1y=sort(test1y);

test1x=test1y+0.2*(test1y.^2);

test2y=randn(1,50);
test2y=sort(test2y);

test2x=test2y+0.2*(test2y.^2);

p2=network('p2.config');
%% train
MSE=[];
test1MSE=[];
test2MSE=[];
for i=1:60
e=p2.train(trainx,trainy,0.9,0.01,50,20);
MSE=[MSE, p2.test(trainx,trainy)^2];
test1MSE=[test1MSE,p2.test(test1x,test1y)^2];
test2MSE=[test2MSE,p2.test(test2x,test2y)^2];

end

%% plot
h=figure;
plot(MSE,'+-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on
%plot(eror_test3,'*-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
hold off
axis auto

legend('Error training') 
xlabel('Steps(1000)','FontName','Times New Roman','FontSize',14);
ylabel('MSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training error history','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)

saveas(h,'MSEhistory_1.png')

%%%%%%%%%%%%
h=figure;

plot(MSE,'+-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on
%plot(eror_test2,'+-g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',8);
plot(test1MSE,'+-k','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
%plot(eror_test3,'*-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
hold off
axis auto

legend('Error training','Error test1','Location','best') 
xlabel('Steps(1000)','FontName','Times New Roman','FontSize',14);
ylabel('MSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training error and testing error history in every 1000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
saveas(h,'err_test1.png')

%%%%%%%%%%%%%%

%%%%%%%%%%%%
h=figure;

plot(MSE,'+-m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on
%plot(eror_test2,'+-g','MarkerEdgeColor','g','MarkerFaceColor','g','MarkerSize',8);
plot(test2MSE,'+-k','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',8);
%plot(eror_test3,'*-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
hold off
axis auto

legend('Error training','Error test2','Location','best') 
xlabel('Steps(1000)','FontName','Times New Roman','FontSize',14);
ylabel('MSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training error and testing error history in every 1000 steps','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
saveas(h,'err_test2.png')

%%%%%%%%%%%%%%


h=figure;
plot(trainx,p2.recall(trainx),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on
plot(trainx,trainy,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
axis auto
legend('Training output','Desired output','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training actural output vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
saveas(h,'TrainvsDesire_1.png')


hold off;

h=figure;
plot(test1x,p2.recall(test1x),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on;
plot(test1x,test1y,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
axis auto
legend('Test actual output','Desired output','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Test1 actural output vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
saveas(h,'output_test1.png')
h=figure;
plot(test2x,p2.recall(test2x),'*m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',8);
hold on;
plot(test2x,test2y,'-b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
axis auto
legend('Test actual output','Desired output','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Test2 actural output vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
saveas(h,'output_test2.png')


%{
plot(test2x,test2y,'*');
hold on;
e(size(e,2))
plot(test2x,p2.recall(test2x),'*');
%}

