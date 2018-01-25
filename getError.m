function [ er1,er2 ] = getError(I,Im)
er1=0;
er2=0;
[n,m]=size(I);
for i=1:n
    for j=1:m
        if Im(i,j)==1
            if I(i,j)==0
                er2=er2+1;
            end
        else
            if I(i,j)==1
                er1=er1+1;
            end
        end
    end
end
end

