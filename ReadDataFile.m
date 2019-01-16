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

%Plot allData
[m,n] = size(allData.data);

plot(allData.data(1:300:end,1),allData.data(1:300:end,2))

% Parse Parameter names
%Time	C1 TRU OUTPUT V	C1 TRU OUTPUT I Pos	R TRU OUTPUT V	R TRU OUTPUT I
%Pos%


RootMeanSquare(allData)
Peak2Peak(allData)

% Root Mean Square function
function RMS = RootMeanSquare(x)
userSpcified = 1:1:12;
RMS = rms(x.data(userSpcified),2);
return
end

% Root Mean Square function
function P2P = Peak2Peak(x)
userSpcified = 1:1:12;
P2P = rms(x.data(userSpcified),2);
return
end


% AC File Processing,

% DC File Processing

% Transient File Processing
