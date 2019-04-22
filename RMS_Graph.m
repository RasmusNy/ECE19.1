clear;
clc;

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

% Select the file
     case 'Transient'
         signalType = 2; % Transient
end
[fileName, pathName] = uigetfile('*.*','Pick Data File');
dataFile = [pathName, fileName];

% Hard code sample frequency
fs = 100000;

Ts = 1/fs;

% Import data
allData = importdata(dataFile);

n = length(allData.data(:,1));

% rms_vector = [];
rms_vector = zeros(1,n-500);
for i = 1:(n-500)
    rms_vector(i) = rms(allData.data(((0+i):(499+i)),2));
end
figure(1);
plot(rms_vector);
xlabel('Time(s)'); ylabel('RMS'); title('Moving RMS'); grid;
