function partitions = octavePartitions(N)
    widths = 2.^(0:round(log(N)/log(2)-2));
    widths = [1,widths,flip(widths)];
    partitions = [0,cumsum(widths)]+1;
end