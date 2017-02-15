
p3=network('p3.config');

% generate test and train set
trainx=rand([1,200])*0.9+0.1;
trainy=2*((1./(trainx)-1)./9)-1;


testx=rand([1,100])*0.9+0.1;
testy=2*((1./(testx)-1)./9)-1;

er=p3.train(trainx,trainy,0.5,0.005,1);
%plot(er);
%plot(trainx,trainy,'*');
%hold on;
%plot(trainx,p3.recall(trainx),'*')




p4=network('p4.config');
file=fopen('iris-train.txt');
d=fscanf(file,'%f %f %f %f & %f %f %f',[7,Inf]);
trainx=d(1:4,:);
trainy=d(5:7,:);
file=fopen('iris-test.txt');
d=fscanf(file,'%f %f %f %f & %f %f %f',[7,Inf]);
testx=d(1:4,:);
testy=d(5:7,:);
er=p4.train(trainx,trainy,0.7,0.001,3000);

yy=p4.recall(testx);
utils.Acc(yy,testy)


