%Modulation
%Input signal
input = allData.data(1:1:1000,2);
t = allData.data(1:1:1000,1);
Am = max(input); %peak of the input signal
fs = 100000;
ts = 1/fs;
figure(1)
subplot(3,1,1);
plot(t,input);
title('Input Signal');
grid on;

%Carrier signal
Ac = Am/1;
fc = 10000;
tc = 1/fc;
yc = Ac*sin(2*pi*fc*t);
subplot(3,1,2);
plot(t,yc)
grid on;
title('Carrier Signal');

%Modulation signal
y = ammod(input,10000,100000);
subplot(3,1,3);
plot(t,y)
title('Amplitude Modulated Signal');
grid on;