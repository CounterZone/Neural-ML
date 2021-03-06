classdef network<handle
    %NETWORK
    
    properties
        layer
        nlayer %number of layers
    end
    
    methods
        function nw=network(config)

            nw.layer={};
        c=fopen(config); 
        i=0;
        while(1)
           l=fgetl(c);
           if l==-1
               break
           end
                      i=i+1;

           l=regexp(l,',','split');
           if strcmp(l{1},'FClayer')
               l=regexp(l{2},'x','split');
               
               nw.layer{i}=FClayer(str2num(l{1}),str2num(l{2}));  %#ok<ST2NM>
               nw.layer{i}.initiate(1/sqrt(str2num(l{1})));
           end
           if strcmp(l{1},'Tanhlayer')
               nw.layer{i}=Tanhlayer();
           end
           if strcmp(l{1},'Biaslayer')
               nw.layer{i}=Biaslayer();
           end    
           
        end
        nw.nlayer=i;
        fclose(c);
        end

        function [err,dw]=S_train(nw,X,Y,momentum,lastdw,lr)
            % one-step BP training. 
            % TODO:other training  methods?
            yy=cell(1,nw.nlayer+1);
            yy{1}=X;
            for i=1:nw.nlayer
                
                yy{i+1}=nw.layer{i}.forward(yy{i});
            end 
            err=sqrt(mean(sum((Y-yy{nw.nlayer+1}).^2)));

            delta=cell(1,nw.nlayer+1);
            delta{1}=Y-yy{nw.nlayer+1};
            dw=cell(1,nw.nlayer);
             for i=1:nw.nlayer
                 if nw.layer{nw.nlayer-i+1}.updating
                    [delta{i+1},dw{nw.nlayer-i+1}]=nw.layer{nw.nlayer-i+1}.BP(delta{i},yy{nw.nlayer-i+2},yy{nw.nlayer-i+1});
                 else
                    delta{i+1}=nw.layer{nw.nlayer-i+1}.BP(delta{i},yy{nw.nlayer-i+2},yy{nw.nlayer-i+1});
                 end
             end
             for i=1:nw.nlayer
                  if nw.layer{i}.updating
                      dw{i}=dw{i}+momentum.*lastdw{i};
                  nw.layer{i}.update(dw{i},lr);
                  end
             end 
        end
        function err_his=train(nw,X,Y,momentum,lr,max_epoch,epoch_size)
            % Train the network. 
            % TODO batch construct;epoch size;Training config????
            lastdw=cell(1,nw.nlayer);
            for i=1:nw.nlayer               
                lastdw{i}=0;
            end 
           err_his=ones(1,max_epoch);
            for i=1:max_epoch
            [err_his(i),dw]=nw.S_train(X,Y,momentum,lastdw,lr);
            lastdw=dw;
           end
        end
        
        function Y=recall(nw,X)
            % nothing special
            Y=cell(1,nw.nlayer+1);
            Y{1}=X;
            for i=1:nw.nlayer
                Y{i+1}=nw.layer{i}.forward(Y{i});
            end
            Y=Y{nw.nlayer+1};
        end
        
        function err=test(nw,X,Y)
            % TODO  maybe more kinds of errors?
          err=sqrt(mean(sum((Y-nw.recall(X)).^2,1)));


        end
    end
    
end

