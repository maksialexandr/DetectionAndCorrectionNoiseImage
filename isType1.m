function [flag] = isType1(array_distribution)
    array_find = find(array_distribution > 0);
    [find_n, find_m] = size(array_find);
    array_interval = zeros(find_n, find_m);
    for i=1:find_m-1
        array_interval(i) = array_find(i+1) - array_find(i);
    end
    array_interval;
    [array_interval_max, array_interval_max_index] = max(array_interval);
    count_left =  0;
    for i=1:array_interval_max_index-1
        count_left = count_left + array_interval(i);
    end
    %count_left
    count_right =  0;
    for i=array_interval_max_index+1:find_m
        count_right = count_right + array_interval(i);
    end
    %count_right
    if (count_left==0 || count_right==0) && (array_interval_max > 150)
        flag = 1;
    else
        flag = 0;
    end
    
end