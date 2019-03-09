% function [Power,Freq] = spectralAnalysis(DataMatrix,cursor1,cursor2)
load('allData.mat');
x = allData.data(1:1:1000,2);   %1000 points ~ 10ms
fs = 100000;    
ts = 1/fs;              %fs is the sampling frequency
f_nyquist = fs/2;       % we will plot from 0Hz up to f_nyquist
samples = length(x);    % number of samples
No = 2^17;              % number of points for FFT computation
if samples > No
    fw = x(1:No).*hanning(No);
else
    fw = x.*hanning(length(x));
end
ffw = fft(fw,No);       %compute the DFT

subplot(3,1,1)
time = 0:ts:ts*(length(fw)-1);
plot(time,fw);          %plot the windowed input signal
xlabel('t(seconds)'); ylabel('x with hanning window'); title('x*hanning window');

subplot(3,1,2)
faxis = linspace(0,f_nyquist-fs/No,No/2);   %creating the frequency axis

%linear scale
semilogy(faxis,abs(ffw(1:length(faxis)))); 
axis([0,fs/2,1e-4,500]);   
xlabel('f(Hz)'); ylabel('|Xr|'); title('|DFT| of x with Hanning window'); grid;

%log scale
subplot(3,1,3)
semilogx(faxis,abs(ffw(1:length(faxis))));
axis([0,fs/2,1e-4,500]);  
xlabel('f(Hz)'); ylabel('|Xr|'); title('|DFT| of x with Hanning window'); grid;