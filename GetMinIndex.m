function [i,j] = GetMinIndex(matrix)
    [n,m] = size(matrix);
    min_value = 1000;
    for i=1:n
        for j=1:m
            if matrix(i,j) < min_value && matrix(i,j) > 0
                min_value = matrix(i,j);
            end
        end
    end
    [i,j] = find(matrix == min_value);
    i = i(1);
    j = j(1);