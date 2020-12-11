function fit=fitness(Pos)
    fit=abs(Pos(1,1)+Pos(1,2)-2)+abs(2*Pos(1,1)+3*Pos(1,2)-5);
end