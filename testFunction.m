[maxValue, minValue, meanValue] = Max_Min_Mean(allData.data);
[rmsValue] = RMS(allData.data);
[crestfactorValue] = crestFactor(allData.data);
%[upperEnvelope,lowerEnvelope] =envelope(allData.data(1:1:3000,2),15,'peak');
%[pks,locs] = findpeaks(upperEnvelope);
%period = mean(diff(locs));
