function [maxValue, minValue, meanValue] = Max_Min_Mean(DataMatrix) %DataMatrix = allData.data
%DataMatrix = allData.data;      % get data from matrix
VoltageData = DataMatrix(:,2);  % channel 2
a = 5;  %get value at cursor position
b = 10; %get value at cursor position
if a<b 
    maxValue = max(VoltageData(a:b));
    minValue = min(VoltageData(a:b));
    meanValue = mean(VoltageData(a:b));
else
    maxValue = max(VoltageData(b:a));
    minValue = min(VoltageData(b:a));
    meanValue = mean(VoltageData(b:a));
end

    
