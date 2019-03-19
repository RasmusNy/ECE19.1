%Modulation
%Input signal
Data = allData.data(:,2);
t = allData.data(:,1);
a = 1;
b = 5000;

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
plot(upperEnvelope);
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
