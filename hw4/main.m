net=hw4net();



t=0;%#steps
errtrain=zeros(1,400);
errtest=zeros(1,400);

% generate test and train set
t=rand([1,200])*0.9+0.1;
trainy=2*((1./(t)-1)./9)-1;
trainx=[t
    ones(size(t))];

t1=rand([1,100])*0.9+0.1;
testy=2*((1./(t1)-1)./9)-1;
testx=[t1
    ones(size(t1))];
% train


for i =1:19999
    err=net.train(trainx,trainy);
    t=i*200;
    if rem(i,50)==0
     errtrain(1,floor(i/50)+1) = err;
     
     %Trainning accuracy:Test error
     errtest(1,floor(i/50)+1) =      net.test(testx,testy);

     %end of Tranning accuracy
     
    end
    if errmax < 0  %Threshold
        disp(t);
        break
    end
end


%plot(trainx(1,:),net.forward(trainx),'*',trainx(1,:),trainy,'*')
%test
%....
%....
%....
%plot(testx(1,:),net.forward(testx),'*',testx(1,:),testy,'*',trainx(1,:),net.forward(trainx),'.',trainx(1,:),trainy,'.')

%Plot the performace indicator(RMSE)
errtrain(errtrain==0) = [];
perf=1:length(errtrain);
figure(1);
plot(perf(1,:),errtrain(1,:),'o-','linewidth',1.5,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
axis auto
xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);
ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('RMSE record of the network','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
%Plot the performace indicator(RMSE) end

%Plot traning and testing actual vs desired output
figure(2);
%disp(errall);
plot(trainx(1,:),net.forward(trainx),'*b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
hold on
plot(trainx(1,:),trainy,'*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

hold off
axis auto
legend('Training actual','Training desired','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training Actual vs Desired Output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
%Plot actual vs desired output end

%Plot training vs testing accuracy
figure(3);
errtest(errtest==0) = [];
perfte=1:length(errtest);
%disp(errall);
plot(perfte(1,:),errtest(1,:),'+-r','linewidth',1.5,'MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',5);
hold on
plot(perf(1,:),errtrain(1,:),'o-b','linewidth',1.5,'MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',5);
hold off
axis auto
legend('ErrTest','ErrTrain','Location','best') 
xlabel('Steps(10000)','FontName','Times New Roman','FontSize',14);
ylabel('RMSE','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training accuracy','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
%Plot training vs testing accuracy end

%Plot traning and testing actual vs desired output
figure(4);
%disp(errall);
plot(testx(1,:),net.forward(testx),'+r','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',4);
hold on
plot(testx(1,:),testy,'+m','MarkerEdgeColor','m','MarkerFaceColor','m','MarkerSize',4);

plot(trainx(1,:),net.forward(trainx),'*b','MarkerEdgeColor','b','MarkerFaceColor','b','MarkerSize',4);
plot(trainx(1,:),trainy,'*c','MarkerEdgeColor','c','MarkerFaceColor','c','MarkerSize',4);

hold off
axis auto
legend('Test actual','Test desired','Training actual','Training desired','Location','best') 
xlabel('Input','FontName','Times New Roman','FontSize',14);
ylabel('Scaled output','FontName','Times New Roman','FontSize',14,'Rotation',90);
title('Training and Testing Actual vs desired output','FontName','Times New Roman','FontWeight','Bold','FontSize',16);
set(gca,'FontName','Times New Roman','FontSize',14)
%Plot actual vs desired output end

