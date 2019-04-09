%Modulation
%Input signal
load('allData.mat')
Data = allData.data(:,2);
t = allData.data(:,1);
a = 1;
b = 10000;

if a < b
    [upperEnvelope,lowerEnvelope] = envelope(Data(a:b),150,'peak');
    maxValue = max(upperEnvelope);
    minValue = min(upperEnvelope);
    modulationAmplidute = maxValue - minValue;
    
elseif a > b
    [upperEnvelope,lowerEnvelope] = envelope(Data(b:a),150,'peak');
    maxValue = max(upperEnvelope);
    minValue = min(upperEnvelope);
    modulationAmplidute = maxValue - minValue;
end
envelope(Data(a:b),150,'peak')
% dt = t(2)-t(1);
% findpeaks(Data(a:b),'MinPeakHeight',31.2300,'MinPeakDistance',round(0.5/100000))
% findpeaks(Data(a:b),'MinPeakHeight',31.2300)
% envelope(Data(a:b),round(0.5/100000),'peak')

% signal = allData.data(1:1:1000,2);
% t = linspace(1,stopIndex,length(M));
% 
% peaks = findpeak(signal);
% maxPeak = max(peaks);
% minPeak = min(peaks);
% 
% %Return difference between maximum peak and minimum peak
% M = maxPeak - minPeak 
% 
% 
% plot(t,signal)
% 
% [up,lo] = envelope(y);
% hold on
% plot(t,up,t,lo')
% hold off
% 
% title('Modulation')
% ylabel('Amplitude')
% xlabel('# of Data Points')
% return
% end
