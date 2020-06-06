function [shiftedOut,shiftedF]  = analyzeFFT(input, dt)

L = length(input); % ����� �������� �������� �������
out = fft(input, 5000); % if fd is 500kHz or 250 kHz, then DFT bins will be 100Hz or 50Hz

shiftedOut = out(1:length(out)/2+1);
shiftedOut = shiftedOut / L;
shiftedOut(2:end-1) = 2*shiftedOut(2:end-1);

Fs = 1/dt;
shiftedF = 0:Fs/length(out):Fs/2;
end