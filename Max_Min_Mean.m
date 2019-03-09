function [maxValue, minValue, meanValue] = Max_Min_Mean(DataMatrix,cursor1,cursor2) %DataMatrix = allData.data
%DataMatrix = allData.data;      % get data from matrix
Data = DataMatrix(:,2);  % channel 2
%a = 5;  %get value at cursor position
%b = 10; %get value at cursor position
if cursor1 < cursor2 
    maxValue = max(Data(cursor1:cursor2));
    minValue = min(Data(cursor1:cursor2));
    meanValue = mean(Data(cursor1:cursor2));
else
    maxValue = max(Data(cursor2:cursor1));
    minValue = min(Data(cursor2:cursor1));
    meanValue = mean(Data(cursor2:cursor1));
end

    
