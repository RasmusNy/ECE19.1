%Plot fequency waveform
function freq = FrequencyWaveform(startIndex,stopIndex,channel)

y = allData.data(startIndex:1:stopIndex,channel);

% Length of the data
NFFT = length(y);
Y = fft(y,NFFT);

%1.Find all maxima of the fft
magnitudeY = findpeaks(abs(Y(1:NFFT/2)));
%magnitudeY = magnitudeY - mean(magnitudeY);
%2.Discard maxima below a certain level

freq = min(findpeaks(magnitudeY));
t = linspace(startIndex,stopIndex,length(y));

plot(t,magnitudeY)
title('Frequency Waveform')
ylabel('Frequency (Hz)')
xlabel('time (sec)')

grid on;

return
end

% Modulation
function M = Modulation(startIndex,stopIndex,channel)

M = allData.data(startIndex:1:stopIndex,channel);
t = linspace(1,stopIndex,length(M));

plot(t,M)

[up,lo] = envelope(y);
hold on
plot(t,up,t,lo')
hold off

title('Modulation')
ylabel('Amplitude')
xlabel('# of Data Points')
return
end

% Root Mean Square function
function RMS = RootMeanSquare(startIndex,stopIndex,channel)

RMS = rms(startIndex.data(stopIndex),channel);
return
end

% Root Mean Square function
function P2P = Peak2Peak(startIndex,stopIndex,channel)
P2P = peak2peak(startIndex.data(stopIndex),channel);
return
end

% Root Mean Square function
function crestFactor = CF(startIndex,stopIndex,channel)
crestFactor = peak2rms(startIndex.data(stopIndex),channel);
return
end

