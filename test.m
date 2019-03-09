w=pi;
f=w/(2*pi);
fs = 1000 ;
t=0:0.001:2;


v=1*cos(w*t);%voltage

x=.8*cos(w*t) + 0.25*cos(2*w*t + 15*pi/180) + 0.5*cos(3*w*t + 19*pi/180) + .125*cos(6*w*t+35*pi/180);%current
y = fft(x);
n = length(x);          % number of samples
f = (0:n-1)*(fs/n);     % frequency range
power = abs(y).^2/n;    % power of the DFT

plot(f,power)
xlabel('Frequency')
ylabel('Power')


