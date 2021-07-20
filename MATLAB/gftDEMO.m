clc; clear; close all;

% Create a fake signal
N = 256;
x = linspace(0,1,N);
sig = zeros(1,length(x));

% signal example 1 (a single delta)
sig(N/2) = 1.0;

% signal example 2 (a mixture of sinusoids and a delta)
% sig(1:N/2) += (sin((N/16)*2*pi*x)*1.0)(1:N/2);
% sig(N/2+1:N) += (cos((N/8)*2*pi*x)*1.0)(N/2+1:N);
% sig(2*N/16+1:3*N/16) += (sin((N/4)*2*pi*x)*1.0)(2*N/16+1:3*N/16);
% sig(N/2+N/4+1) = 2.0;

% Do the transform
partitions = octavePartitions(N);
windows = boxcarWindows(partitions);
SIG = GFT(sig,partitions,windows);

% Interpolate to get a spectrogram
% The third and fourth parameters set the time and frequency axes respectively,
% and can be changed to raise or lower the resolution, or zoom in on
% a feature of interest
spectrogram = interpolateGFT(SIG,partitions,1:N,1:N);

% Display
figure();
subplot(3,1,1);
plot(x,sig,'DisplayName','signal');
legend('Location','northeast')
ax = subplot(3,1,2);
hold on;
for p = partitions
    line([x(p),x(p)],[0,max(abs(SIG))],'Color',[1 0 0],'linestyle','--');
end
p = plot(x,abs(SIG),'DisplayName','SIGNAL');
legend(p,'Location','northeast');
subplot(3,1,3);
imagesc(abs(spectrogram));
