function spectrogram = interpolateGFT(SIG,partitions,tAxis,fAxis,method)
    % Interpolate a 1D GFT onto a grid. If axes is specified it should be a
    % list or tuple consisting of two arrays, the sampling points on the time and frequency
    % axes, respectively. Alternatively, M can be specified, which gives the number
    % of points along each axis.
    
    % introduced in R2019 is the arguments block
    % https://www.mathworks.com/help/matlab/ref/arguments.html
%     arguments
%         SIG;
%         partitions;
%         tAxis;
%         fAxis;
%         method (1,:) char = 'linear';
%     end
    
    
     % if you don't have have the arguments block, then you can still do input defaults like this:
    if nargin<5
        method = 'linear';
    end
        
    N = length(SIG);
    widths = partitionWidths(partitions);
    spectrogram = complex(length(partitions),zeros(length(tAxis)));
    % interpolate each frequency band in time
    for p = 1:length(partitions)
        % indices of sample points, plus 3 extra on each side in case of cubic interpolation
        indices = (-3:widths(p)+2);
        % time coordinates of samples
        t = indices .* (N/widths(p));
        % values at sample points
        if (p < length(partitions))
            temp = SIG(partitions(p):partitions(p+1)-1);
            f = temp(mod(indices,widths(p))+1);
        else
            temp = SIG(partitions(p):N);
            f = temp(mod(indices,widths(p))+1);
        end
        if (length(f) > 1)
            spectrogram(p,:) = interp1(t,f,tAxis,method);
        else
            spectrogram(p,:) = f;
        end
    end
    
    % Interpolate in frequency
    indices = mod(-3:length(partitions)+2,length(partitions));
    f = partitions(indices+1) + widths(indices+1)/2;
    f(1:3) = f(1:3) - N;
    f(length(f)-2:length(f)) = f(length(f)-2:length(f)) + N;
    t = spectrogram(indices+1,:);
    spectrogram = interp1(f,t,fAxis,method);
end