function [crestfactorValue] = crestFactor(DataMatrix)
VoltageData = DataMatrix(:,2);  % channel 2, 
a = 5;  %get value at cursor position
b = 10; %get value at cursor position
if a<b 
    crestfactorValue = peak2rms(VoltageData(a:b)); 
else
    crestfactorValue = peak2rms(VoltageData(b:a));
end
