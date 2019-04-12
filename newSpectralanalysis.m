load('allData.mat');
% time = allData.data(1:1:10000,1);
% signal = allData.data(1:1:10000,2);
% L=length(signal);       % Length of signal 
% Ts = mean(diff(time));
% Fs=1/Ts;              % sampling frequency 
% NFFT = 2^nextpow2(L);   % Next power of 2 from length of y
% Y = fft(signal,NFFT)/L;
% % freq = Fs*(0:(NFFT/2))/NFFT;
% % Y = Y(1:NFFT/2+1);
% % plot(freq,abs(Y))
% 
% freq = -Fs/2+Fs/NFFT:Fs/NFFT:Fs/2;
% Ycent = fftshift(Y);
% plot(freq,abs(Ycent));
% % plot(freq,abs(Y));
% % semilogx(freq,abs(Ycent))
% title('Single-Sided Amplitude Spectrum of y(t)'); grid;
% xlabel('Frequency (Hz)');
% ylabel('|Y(f)|');

% x = allData.data(1:1:10000,2);
% time = allData.data(1:1:10000,1);
% ts = mean(diff(time));
% fs=1/ts;
% N = length(x);
% n = 2^nextpow2(N);
% x = x-mean(x);
% % spectral analysis
% win = hanning(N);       
% X = fft((x.*win),n); 
% X = abs(X/n);
% f = fs*(0:(n/2))/n;
% X = X(1:n/2+1);
% % plotting of the spectrum
% plot(f, X) 
% title('Amplitude Spectrum of the Signal');grid;
% xlabel('Frequency (Hertz)')
% ylabel('Magnitude')


signal = allData.data(1:1:10000,2); %start index =1; stop index=10000
time = allData.data(1:1:10000,1);   %start index =1; stop index=10000
Ts = mean(diff(time));
Fs=1/Ts;      
L = length(signal); % Window Length of FFT    
NFFT = 2^nextpow2(L); % Transform length
signal_HannWnd = signal.*hanning(L);            
signaldft_HannWnd = fft(signal_HannWnd,NFFT)/L;
result = abs(signaldft_HannWnd);
result = result (1:NFFT/2+1);
f = Fs/2*linspace(0,1,NFFT/2+1); 
figure(1)
%plot(f,2*result); %Hanning window Amplitude Correction Factor = 2
% set(gca, 'XScale', 'log');
semilogx(f,2*result)
figure(2)
%plot(f,2*result);
axis([0,Fs/2,0,0.2]);   % Zoom in 

title('Amplitude Spectrum of the Signal');grid;
xlabel('Frequency (Hertz)')
ylabel('Magnitude')
