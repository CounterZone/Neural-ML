p2=network('p2.config');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           data generation

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
p=-10:10;
trainyy=2*sin(0.1*pi*p);
trainxx=trainyy+0.2*trainyy.^2;
trainy=utils.rescale(min(trainyy),max(trainyy),trainyy);
trainx=utils.rescale(min(trainxx),max(trainxx),trainxx);


xx=normrnd(0,1,[1,21]);
yy=xx+0.2*xx.^2;
yy=utils.rescale(min(yy),max(yy),yy);
xx=utils.rescale(min(xx),max(xx),xx);







s1=-25:25;
testy1=0.8*sin(s1*0.2*pi)+0.25*cos(2/25*pi*s1);
testx1=testy1+0.2*testy1.^2;
testx2=normrnd(0,1,[1,51]);
testy2=testx2+0.2*testx2.^2;
testx1=utils.rescale(min(trainxx),max(trainxx),testx1);
testx2=utils.rescale(min(trainxx),max(trainxx),testx2);
testy1=utils.rescale(min(trainyy),max(trainyy),testy1);
testy2=utils.rescale(min(trainyy),max(trainyy),testy2);



testx1=utils.rescale(min(xx),max(xx),testx1);
testx2=utils.rescale(min(xx),max(xx),testx2);
testy1=utils.rescale(min(yy),max(yy),testy1);
testy2=utils.rescale(min(yy),max(yy),testy2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Training, record the history

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trainer=[];
tester=[];
rmse=[];

testrmse=[];
for i=1:600
    p2.train(xx,yy,0.7,0.02,5,21);
   

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Plot the training history

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%           Analyse the final output of the Test set

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y1=p2.recall(testx1);
y2=p2.recall(testx2);

p2.test(testx1,testy1)
p2.test(testx2,testy2)

plot(s1,testy1,'*');
hold on;
plot(s1,y1,'*');

