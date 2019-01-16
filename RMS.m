function [rmsValue] = RMS(DataMatrix)
VoltageData = DataMatrix(:,2);  % channel 2, 
a = 5;  %get value at cursor position
b = 10; %get value at cursor position
if a<b 
    rmsValue = rms(VoltageData(a:b));
else
    rmsValue = rms(VoltageData(b:a));
end