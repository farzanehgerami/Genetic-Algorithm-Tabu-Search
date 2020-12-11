function [ns , Move]=CreateNeighbor(s,nvar)
r=randi([1 3]);
j1=randi([1 nvar-1]);
j2=randi([j1+1 nvar]);
switch r    
    case 1
nj1=s(j1);
nj2=s(j2);

s(j1)=nj2;
s(j2)=nj1;
    case 2
   s(j1:j2)=s(j2:-1:j1);             
   case 3
 s=[s(j2+1:end)      s(j1:j2)   s(1:j1-1)] ;     
end
ns=s;
Move=[j1 j2];
end