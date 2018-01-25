function [count_diff] = Diff(arr)
   [n,m]=size(arr);
   count_diff = 0;
   for i=1:n
        for j=1:m
            count_diff = count_diff + arr(i,j);
        end
   end