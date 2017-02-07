function [M,p]=corrmm(X,Y,mu,n,tol)
	[nx,mx]=size(X);
	[ny,my]=size(Y);
    p=[];
%initialize the memory matrix
	M=zeros(ny,nx);
	for k=1:n %n is the maximum number of outer loop iterations
% randomize the ordering of the vector in both X & Y
		RN=randperm(mx);
		X=X(:,[RN]);
		Y=Y(:,[RN]);
		for i=1:mx
			M=M+mu*(Y(:,i)-M*X(:,i))*X(:,i)';
        end

        p(k)=norm(Y-M*X);
		if norm(Y-M*X)<=tol
			disp('Gradient Search Terminated ===>>> ||Y-M*X||<=tol'),disp(norm(Y-M*X))
			disp('Number of Iterations = '), disp(k*i)
			break
		end
	end

