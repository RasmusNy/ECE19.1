%Modulation
%Modulation
%Input signal
load('allDataAC.mat');
Data = allData.data(:,2);
t = allData.data(:,1);
a = 1;
b = 100000;
x = Data(a:b);

%A zero-crossing is a point where the sign of a mathematical function changes (e.g. from positive to negative) 
% upward zero-crossings 
upZeroCrossing = find(x(1:end-1) <= 0 & x(2:end) > 0);
PeakDistance = upZeroCrossing(2)-upZeroCrossing(1); % distance between 2 peaks equals to distance between 2 zero-crossing points
minPeakDistance = PeakDistance - 1; % -1 data point so it won't ignore the next peak

if a < b
    [upperEnvelope,lowerEnvelope] = envelope(Data(a:b),minPeakDistance,'peak');
    maxValue = max(upperEnvelope);
    minValue = min(upperEnvelope);
    modulationAmplidute = maxValue - minValue;
    
elseif a > b
    [upperEnvelope,lowerEnvelope] = envelope(Data(b:a),minPeakDistance,'peak');
    maxValue = max(upperEnvelope);
    minValue = min(upperEnvelope);
    modulationAmplidute = maxValue - minValue;
end
% [up,lo] = envelope(Data(a:b),150,'peak');
% plot(t(a:b),up,'linewidth',2);
% hold on;
% plot(t(a:b),lo,'linewidth',2);
% hold on;
% plot(t(a:b),Data(a:b),'linewidth',2);
% hold off

envelope(Data(a:b),minPeakDistance,'peak')
% findpeaks(Data(a:b),'MinPeakDistance',minPeakDistance);
