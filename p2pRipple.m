function [p2pRippleValue] = p2pRipple(DataMatrix,cursor1,cursor2)
Data = DataMatrix(:,2);  % channel 2
Time = DataMatrix(:,1);
%a = 500;  %get value at cursor position
%b = 1000; %get value at cursor position

%----------------1st Solution-----------------
%[upperEnvelope,lowerEnvelope] =envelope(Data(a:b),15,'peak');    %get upper and lower evelope of the specified window (spline interpolation over local max)
%averageMax = mean(upperEnvelope);           %Calculate average of local maximum
%averageMin = mean(lowerEnvelope);           %Calculate average of local minimum
%p2pRippleValue = averageMax - averageMin;   %Calculate peak-to-peak ripple

%----------------2nd Solution-----------------
%localMaxs = findpeaks(Data(500:1000),Time(500:1000),'MinPeakDistance',15.e-05);    
%localMins = -findpeaks(-Data(500:1000),Time(500:1000),'MinPeakDistance',15.e-05);
%averageMax = mean(localMaxs);           %Calculate average of local maximum
%averageMin = mean(localMins);           %Calculate average of local minimum
%p2pRippleValue = averageMax - averageMin;   %Calculate peak-to-peak ripple
%---------------------------------------------

if cursor1 < cursor2 
    maxValue = max(Data(cursor1:cursor2));
    minValue = min(Data(cursor1:cursor2));
    p2pRippleValue = maxValue - minValue;
else
    maxValue = max(VoltageData(cursor2:cursor1));
    minValue = min(VoltageData(cursor2:cursor1));
    p2pRippleValue = maxValue - minValue;
end