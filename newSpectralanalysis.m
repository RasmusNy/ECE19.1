load('allData.mat');  % DC DATA
%load('allDataAC.mat'); % AC DATA

signal = allData.data(1:1:10000,2); %start index =1; stop index=10000
time = allData.data(1:1:10000,1);   %start index =1; stop index=10000
% signal = 30 + 0.5*sin(2*pi*5000*time) + sin(2*pi*10000*time);%for testing
signal = signal - mean(signal);     %remove DC offset to see the frequency component
Ts = mean(diff(time));  % calculate period
Fs=1/Ts;                % calculate sampling frequency
L = length(signal);     % Window Length of FFT    
NFFT = 2^nextpow2(L);   % Transform length
signal_HannWnd = signal.*hanning(L);            % apply hanning window          
signaldft_HannWnd = fft(signal_HannWnd,NFFT)/L; % calculate FFT
result = abs(signaldft_HannWnd);                % get rid of complex value
result = result (1:NFFT/2+1);                   % single-side band spectrum
f = Fs/2*linspace(0,1,NFFT/2+1);                % create frequency axis
%------------LINEAR SCALE----------------
figure(1) 
plot(f,4*result);                               % plot result in linear scale
% axis([0,Fs/2,0,0.2]);   % Zoom in 
% set(gca, 'XScale', 'log');
%--------------LOG SCALE-----------------
figure(2)
semilogx(f,4*result)                            % plot result in log scale
% axis([0,Fs/2,0,0.2]);   % Zoom in 
title('Amplitude Spectrum of the Signal');grid;
xlabel('Frequency (Hertz)')
ylabel('Magnitude')
