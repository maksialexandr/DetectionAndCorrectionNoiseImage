function [flag] = isType2(array_distribution)
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
    [find_n_left, find_m_left] = size(find(array_find < 50));
    [find_n_right, find_m_right] = size(find(array_find > 200));
    if array_interval_max < 100 || (find_m - (find_m_left + find_m_right)) > 1
        flag = 1;
    else
        flag = 0;
    end
    
end