function [ envelope ] = waveformEnvelope( DataMatrix )%DataMatrix = allData.data
x1 = 0;  %get value at cursor position
x2 = 2000; %get value at cursor position
plot(DataMatrix(1:300:end,1),DataMatrix(1:300:end,2))
if x1<x2 
    [up,lo] = envelope(DataMatrix(x1:x2,2));
    hold on
    plot(DataMatrix(1:300:end,1),up,DataMatrix(1:300:end,1),lo,'linewidth',1.5)
    legend('voltage','up','lo')
    hold off


end

