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
envelope(Data(a:b),150,'peak')
