
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


fs = 100*10^3;
%t = 0:1/Fs:2-1/Fs;
startData = 10;
stopData = 100;
numHarmonics = 5;

y = allData.data(startData:1:stopData,2); 


%signal duration
dur = length(allData.data(startData:1:stopData,1));


t = startData:1/fs:stopData;

[sp,fp,tp] = pspectrum(y,fs,'spectrogram');

mesh(tp,fp,sp)
view(-15,60)
xlabel('Time (s)')
ylabel('Frequency (Hz)')