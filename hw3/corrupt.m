function out = corrupt(X,scale)
%SHOW Summary of this function goes here
%   Detailed explanation goes here
n=floor(numel(X)*scale);
out=randperm(numel(X));
p=[-1*ones(1,n),ones(1,numel(X)-n)];
p=p(out);
out=X.*reshape(p,size(X));

end

