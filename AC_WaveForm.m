%   Program process user file and stores data in appropriate matrix
%   ECE19.1

% Ask User For Data Typ AC/DC/Transient
dataParameter = questdlg('What Data Parameter?', ...
                'Data Format', ...
                'AC', 'DC', 'Transient', 'Transient');

% Handle Response
switch dataParameter
    case 'AC'
        signalType = 0; % AC
    case 'DC'
        signalType = 1; % DC
     case 'Transient'
         signalType = 2; % Transient
end

% Select the file
[fileName, pathName] = uigetfile('*.*','Pick Data File');
dataFile = [pathName, fileName];

%import data
allData = importdata(dataFile);


Fs = 100*10^3;
startData = 1;
stopData = 1000;
numHarmonics = 5;
beginningtime = 1;
y = allData.data(startData:1:stopData,2);





%userSpcified = startData:1:stopData;
%RootMeanSquare(allData,userSpcified)
%Peak2Peak(allData,userSpcified)
%CF(allData,userSpcified)



%Plot fequency waveform


%y = allData.data(startIndex:1:stopIndex,channel);

% Length of the data
NFFT = length(y);
Y = fft(y,NFFT);

%1.Find all maxima of the fft
magnitudeY = findpeaks(abs(Y(1:NFFT/2)));
%magnitudeY = magnitudeY - mean(magnitudeY);
%2.Discard maxima below a certain level

freq = min(findpeaks(magnitudeY));
t = linspace(startData,stopData,length(magnitudeY));
t = t.';


plot(t,magnitudeY)
title('Frequency Waveform')
ylabel('Frequency (Hz)')
xlabel('time (sec)')

grid on;

% % Modulation
% function M = Modulation(startIndex,stopIndex,channel)
% 
% M = allData.data(startIndex:1:stopIndex,channel);
% t = linspace(1,stopIndex,length(M));
% 
% plot(t,M)
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
% 
% % Root Mean Square function
% function RMS = RootMeanSquare(startIndex,stopIndex,channel)
% 
% RMS = rms(startIndex.data(stopIndex),channel);
% return
% end
% 
% % Root Mean Square function
% function P2P = Peak2Peak(startIndex,stopIndex,channel)
% P2P = peak2peak(startIndex.data(stopIndex),channel);
% return
% end
% 
% % Root Mean Square function
% function crestFactor = CF(startIndex,stopIndex,channel)
% crestFactor = peak2rms(startIndex.data(stopIndex),channel);
% return
% end
% 
% 
%  









