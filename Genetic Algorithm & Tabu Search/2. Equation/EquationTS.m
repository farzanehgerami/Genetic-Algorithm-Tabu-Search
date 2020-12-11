clc
clear
close all
%% Insert Data
data=InsertData();
nvar=data.nvar;
%% Parameters Setting
NeighborsNum=50;
Maxiter=400;
Limit=ceil(Maxiter*0.025); 
TL=zeros(nvar,nvar);
%% Initialization
emp.pos=[];
emp.fit=inf;
emp.m=[];
Sol=emp;
Sol.pos=randi([-5 5],1,nvar);
Sol.fit=fitness(Sol.pos);
GlobalSol=Sol;
%% Main Loop
tic
Best=zeros(Maxiter,1);
for Iter=1:Maxiter    
   BestForbidden=emp;
   BestFree=emp;
    for i=1:NeighborsNum
        NewSol=CreateNeighbor(Sol);
        if TL(NewSol.m(1))>0 % Forbidden
            if NewSol.fit<BestForbidden.fit % Best Forbiden 
               BestForbidden=NewSol;
            end
        else  % Free
            if NewSol.fit<BestFree.fit % Best Free
                BestFree=NewSol;
            end 
        end
    end   
         if (isempty(BestFree.pos) || BestForbidden.fit<BestFree.fit && BestForbidden.fit<GlobalSol.fit)
            Sol=BestForbidden;          
        else
            Sol=BestFree;           
        end  
    TL=TL-1;
    TL=max(TL,0);
    TL(Sol.m(1))=Limit;
    if Sol.fit<GlobalSol.fit
        GlobalSol=Sol;
    end
    Best(Iter)=GlobalSol.fit; 
    disp([ ' Iter = ' num2str(Iter) ' BEST =' num2str(Best(Iter))])
end
%% results
disp([ ' Best solution = ' num2str(GlobalSol.pos)])
disp([ ' Best fitness = ' num2str(GlobalSol.fit)])
disp([ ' Time = ' num2str(toc)])
figure(2)
plot(Best(1:Iter))
xlabel(' iteration ')
ylabel(' fitness')
title(' TS for Equation')
legend('BEST')