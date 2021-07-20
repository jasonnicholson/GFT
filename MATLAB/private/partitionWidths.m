function widths = partitionWidths(partitions)
    widths = circshift(partitions,-1) - partitions;
    widths(length(partitions)) = widths(length(partitions)) + max(partitions);
end