% function [Power,Freq] = spectralAnalysis(DataMatrix,cursor1,cursor2)
% 
% signal = DataMatrix(cursor1:1:cursor2,2);   %input signal
% Fs = 100000;                                %sampling frequency
% sigLength = length(signal);                 %length of input signal
% [Power,Freq] = periodogram(signal,hamming(sigLength),sigLength,Fs);
% plot(Freq,10*log10(Power)) %express power in W
% xlabel('Hz')
% ylabel('dBW')
% title('Periodogram Power Spectral Density Estimate')
%------------------------------------------------------

signal = allData.data(500:1:1000,2);   %input signal
Fs = 100000;                                %sampling frequency
sigLength = length(signal);                 %length of input signal
[Power,Freq] = periodogram(signal,hamming(sigLength),sigLength,Fs);
plot(Freq,10*log10(Power)) %express power in W
xlabel('Hz')
ylabel('dBW')
title('Periodogram Power Spectral Density Estimate')
PdBW = 10*log10(Power);
% [peakPowers_dBW, peakFreqIdx] = findpeaks(PdBW,'minpeakheight',-11);
% peakFreqs_Hz = F(peakFreqIdx)
% peakPowers_dBW;
%findpeaks(PdBW,'MinPeakHeight',-53)

