net=hw3net(0.1);
% generate test and train set
t=rand([1,200])*0.9+0.1;
trainy=2*((1./(t)-1)./9)-1;
trainx=[t
    ones(size(t))];
t=rand([1,100])*0.9+0.1;
testy=2*((1./(t)-1)./9)-1;
testx=[t
    ones(size(t))];
% train
for i =1:5000
    net.train(trainx,trainy,0.01)
end
plot(trainx(1,:),net.forward(trainx),'*',trainx(1,:),trainy,'*')