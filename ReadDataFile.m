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

%Maps matrix dimensions to m & n
[m,n] = size(allData.data);

%Plot allData
plot(allData.data(1:300:end,1),allData.data(1:300:end,2))

%Calculate channel 1 RMS
rootMeanSquare = rms(allData.data(:,2))

%Calculate channel 1 peak to peak
p2p = peak2peak(allData.data(:,2))

%Calculate Max, Min, Mean
maximum = max(allData.data(:,2))

minimum = min(allData.data(:,2))

average = mean(allData.data(:,2))

% Parse Parameter names
%Time	C1 TRU OUTPUT V	C1 TRU OUTPUT I Pos	R TRU OUTPUT V	R TRU OUTPUT I
%Pos%




% AC File Processing

% DC File Processing

% Transient File Processing


