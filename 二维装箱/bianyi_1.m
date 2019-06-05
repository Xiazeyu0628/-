function x=bianyi_1(x,option,data)
    temp=randi(option.max_num);
     x(temp)=ceil(rand*data.num_type);%随机0-1之间的数，这里x应该是个矩阵
end