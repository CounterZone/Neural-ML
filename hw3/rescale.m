function out = rescale(X)
%RESCALE to[0,1]
out=(X-ones(size(X))*min(reshape(X,numel(X),1)))./(ones(size(X))*(max(reshape(X,numel(X),1))-min(reshape(X,numel(X),1))));
end

