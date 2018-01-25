function [matrix] = GetMatrix(array, size_block)
    [n,m] = size(array);
    matrix = zeros(m/size_block, m/size_block);
  
    for i=1:m/size_block
        for j=1:m/size_block
            matrix(i,j) = array((i-1)*size_block+j);
        end
    end
    