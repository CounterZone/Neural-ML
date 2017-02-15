p3=network('p3.config');

% generate test and train set
trainx=rand([1,200])*0.9+0.1;
trainy=2*((1./(trainx)-1)./9)-1;


testx=rand([1,100])*0.9+0.1;
testy=2*((1./(testx)-1)./9)-1;

er=p3.train(trainx,trainy,0.8,0.002,1000);
plot(er)
plot(trainx,trainy,trainx,p3.forward(trainx),'*');