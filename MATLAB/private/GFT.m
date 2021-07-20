function SIG = GFT(sig,partitions,windows)
    SIG = fft(complex(sig));
    SIG = SIG.*windows;
    for p = 1:(length(partitions)-1)
        SIG(partitions(p):partitions(p+1)-1) = ifft(SIG(partitions(p):partitions(p+1)-1));
    end
end