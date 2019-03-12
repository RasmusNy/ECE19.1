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

% Parse Parameter names
%Time	C1 TRU OUTPUT V	C1 TRU OUTPUT I Pos	R TRU OUTPUT V	R TRU OUTPUT I
%Pos%

%Maps matrix dimensions to m & n
%[m,n] = size(allData.data);

%Plot allData
%plot(allData.data(1:1:5000,1),allData.data(1:1:5000,2))

%Time to index
data = allData.data;

%test1
cursor1 = 2.0000e-05;
cursor2 = 1.0000e-04;

%test2
% cursor1 = -100;
% cursor2 = 100;

%test3
% cursor1 = 2.0000e-05;
% cursor2 = 100;

%test4
% cursor1 = -100;
% cursor2 = 1.0123e-04;

%calculate the distance between the time value from cursor and the time value from input data
distance1 = abs(data(:,1) - cursor1);
distance2 = abs(data(:,1) - cursor2);

outOfBounds = 1;
%if one cursor exceed the lower bound, get the index of minimum time value of input data
if cursor1 < min(data(:,1)) && cursor2 <= max(data(:,1))
    cursorIndex1 = find(data(:,1)== min(data(:,1))); 
    cursorIndex2 = find(distance2 == min(distance2));
    
%if one cursor exceed the upper bound, get the index of maximum time value of input data
elseif cursor2 > max(data(:,1)) && cursor1 >= min(data(:,1))
    cursorIndex1 = find(distance1 == min(distance1));
    cursorIndex2 = find(data(:,1)== max(data(:,1)));
    
%if both cursor exceed the input data range, get the index of minimum and maximum time value 
elseif cursor1 < min(data(:,1)) && cursor2 > max(data(:,1))
    cursorIndex1 = find(data(:,1)== min(data(:,1))); 
    cursorIndex2 = find(data(:,1)== max(data(:,1)));
    
%if both cursor are in the input data range, get the index of the time values that are closest to the cursor position
elseif cursor1 >= min(data(:,1)) && cursor2 <= max(data(:,1))
    cursorIndex1 = find(distance1 == min(distance1));
    cursorIndex2 = find(distance2 == min(distance2));
    
%if both cursor exceed the upper bound 
elseif cursor1 > max(data(:,1)) && cursor2 > max(data(:,1))
  outOfBounds = 0;
  
%if both cursor exceed the lower bound
elseif cursor1 < min(data(:,1)) && cursor2 < min(data(:,1))
  outOfBounds = 0;


% AC File Processing

% DC File Processing

% Transient File Processing


