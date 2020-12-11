clc
clear
close all
%% parameters setting
nvar=8;
NeighborsNum=20;% Number of Neighbors
limit=50;
maxiter=500;
TL=zeros(nvar,nvar);
%% inialization
empty.pos=[];
empty.cost=inf;
Sol.pos=randperm(nvar);
Sol.cost=fitness(Sol.pos,nvar);
GlobalSol=Sol;
%% main loop
tic
Iter=0;
best=zeros(maxiter,1);
while GlobalSol.cost>0
Iter=Iter+1;    
   BestForbidden=empty;
   BestFree=empty;
    for i=1:NeighborsNum
        [NeighborSol.pos , Move]=CreateNeighbor(Sol.pos,nvar);
        NeighborSol.cost=fitness(NeighborSol.pos,nvar);
        if TL(Move(1),Move(2))>0 % forbiden
            if NeighborSol.cost<BestForbidden.cost % best forbiden 
               BestForbidden=NeighborSol;
               BestForbidden.m=Move;
            end
        else% free
            if NeighborSol.cost<BestFree.cost
                BestFree=NeighborSol;
                BestFree.m=Move;
            end 
        end
    end   
         if BestForbidden.cost<BestFree.cost && BestForbidden.cost<GlobalSol.cost
            Sol=BestForbidden;
            Move=BestForbidden.m;
            TL(Move(1),Move(2))=limit+1;
            TL(Move(2),Move(1))=limit+1;           
        else
            Sol=BestFree;
            Move=BestFree.m;
            TL(Move(1),Move(2))=limit+1;
            TL(Move(2),Move(1))=limit+1;            
        end  
    TL=TL-1;
    TL=max(TL,0);
    if Sol.cost<GlobalSol.cost
        GlobalSol=Sol;
    end
    best(Iter)=GlobalSol.cost; 
    disp([ ' Iter = ' num2str(Iter) ' BEST =' num2str(best(Iter))])
end
%% results
disp([ ' Best solution = ' num2str(GlobalSol.pos)])
disp([ ' Time = ' num2str(toc)])
figure(2)
plot(best(1:Iter))
xlabel(' iteration ')
ylabel(' fitness')
title(' 8 Queen TS')
legend('BEST')