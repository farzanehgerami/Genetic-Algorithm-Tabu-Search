function fit=fitness(x,nvar)
fit=0;
for i=1:nvar-1
    for j=i+1:nvar
        if abs(x(i)-x(j))==abs(i-j)
            fit=fit+1;
        end 
    end 
end