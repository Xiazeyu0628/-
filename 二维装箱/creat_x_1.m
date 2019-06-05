function x=creat_x_1(option,data)
    x=ceil(rand(1,option.max_num)*data.num_type);
    %X = rand(sz1,...,szN) 返回由随机数组成的 sz1×...×szN 数组，其中 sz1,...,szN 指示每个维度的大小。例如：rand(3,4) 返回一个 3×4 的矩阵。
    %rand(1,option.max_num)=[ ]1行37列
    %1     1     4     1     4     3     4     1     2     1     4     1     4     4     4     1     2     2     4     2     4     1     2     1     1     4     3     3     1     4     3     2     3     2     1
end