clear;
clc;

w=pi;
t=[0:0.001:2];
v=3*cos(w*t) + 6*cos(10*w*t);%voltage 
% for k = 1:length(v);
%     if 1000 <= k && k <= 1500 || 50 <= k && k <= 200
%          v(k) = 0;
%     end
% end
i=.8*cos(w*t + 10*pi/180) + 0.25*cos(2*w*t + 15*pi/180) + 0.5*cos(3*w*t + 19*pi/180) + .125*cos(6*w*t+35*pi/180);%current

fs = 1/0.001;
% avgP = 0;
% for k = 1:length(t)
%     avgP = avgP + mean(i(k)*v(k));
% end



% hold on
% figure(1)
% for k = 1:length(t)
%    if powerInt(k) == 1
%        plot(t,v(k),'*','r');
%    else
%        plot(t,v(k));
%    end
%       
% end
% hold off


% FFT of voltage and current shifted
% so there is both positive and negative components.
% Shifted for graphing
f = w/(2*pi);
fs = 1/0.001;

vfft = fftshift(fft(v));
ifft = fftshift(fft(i));
n = length(i);
vabs = abs(vfft);
iabs = abs(ifft);

% Divide by number of data points over 2 for proper magnitude scaling
vabs = vabs/(n/2);
iabs = iabs/(n/2);

% Creating a new vector only containing the first half of
% the original 'abs' vector (to remove the negative half)
iabs_modified = iabs(1:n/2);
vabs_modified = vabs(1:n/2);

% Transposed for find calculation
iabs_modified = iabs_modified';
vabs_modified = vabs_modified';

magnitude_threshold = 0.02;

pkv = [];
locv = [];
phv = [];
vrms = 0;

% Finding all values with magnitudes at or greater than the magnitude
% threshold. It stores their index locations in a vector locv.
[~, val] = find(vabs_modified >= magnitude_threshold);
locv = [locv ; val];

% Vector of phase angles for voltage
phv = [phv ; angle(vfft(locv))];

% Vector of magnitude values for voltage
pkv = [pkv ; vabs_modified(locv)];


pki = [];
loci = [];
phi = [];
irms = 0;

% Finding all values with magnitudes at or greater than the magnitude
% threshold. It stores their index locations in a vector loci.
[~, val] = find(iabs_modified >= magnitude_threshold);
loci = [loci ; val];

% Vector of phase angles for current
phi = [phi ; angle(ifft(loci))];

% Vector of magnitude values for current
pki = [pki ; iabs_modified(loci)];

Pavg = 0;
avgP = [];
Preact = 0;
PF = 0;
RMSv = zeros(1,length(locv));
RMSi = zeros(1,length(loci));

% Voltage rms fourier series calculation
for k = 1:length(locv)
    vrms = vrms + (pkv(k)^2)/2;
    RMSv(k) = (pkv(k)^2)/2;
end
vrms = sqrt(vrms);
RMSv = sqrt(RMSv);

% Current rms fourier series calculation
for k = 1:length(loci)
    irms = irms + (pki(k)^2)/2;
    RMSi(k) = (pki(k)^2)/2;
end
irms = sqrt(irms);
RMSi = sqrt(RMSi);

% Real Power 'Pavg' and reactive power 'Preact'
counter = 1;
if(length(locv) >= length(loci))
    while counter ~= length(locv)+1
        for k = 1:length(loci)
            if locv(counter) == loci(k)
                Pavg = Pavg + RMSv(counter)*RMSi(k)*(cos(phv(counter)-phi(k)));
                avgP = [avgP ; RMSv(counter)*RMSi(k)*(cos(phv(counter)-phi(k)))];
                Preact = Preact + RMSv(counter)*RMSi(k)*(sin(phv(counter)-phi(k)));
            end
        end
        counter = counter + 1;
    end
elseif(length(locv) < length(loci))
    while counter ~= length(loci)+1
        for k = 1:length(locv)
            if loci(counter) == locv(k)
               Pavg = Pavg + RMSv(k)*RMSi(counter)*(cos(phv(k)-phi(counter)));
               avgP = [avgP ; RMSv(k)*RMSi(counter)*(cos(phv(k)-phi(counter)))];
               Preact = Preact + RMSv(k)*RMSi(counter)*(sin(phv(k)-phi(counter)));
            end
        end
        counter = counter + 1;
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Data = allData.data(:,2);
%a = 1;
%b = n;
x = v(1:n);

upZeroCrossing = find(x(1:end-1) <= 0 & x(2:end) > 0);
PeakDistance = upZeroCrossing(2)-upZeroCrossing(1);

powerInt = zeros(1,length(t));
avgRealPower = mean(Pavg);

for k = 1:length(avgP)
   if (avgP(k) <= (avgRealPower * 0.25))
       powerInt(k) = 1;
   end
end

int_duration = 0;
int_start = [];
int_end = [];

for k = 1:length(t)-1
    if powerInt(k) == 1 && powerInt(k+1) == 1
        int_duration = int_duration + 1;    
    end
    if (powerInt(k) == 0 && powerInt(k+1) == 1) || (powerInt(k) == 1 && k == 1)
        int_start = [int_start ; (k/fs)];
    end
    if (powerInt(k) == 1 && powerInt(k+1) == 0) || (powerInt(k+1) == 1 && k == n)
        int_end = [int_end ; (k+1/fs)];
    end
end
int_duration = int_duration / fs;
plot(t,v)
isPowerInt = [];
for k = 1:length(int_start)
    if (int_end(k) - int_start(k)) >= PeakDistance
        isPowerInt = [isPowerInt ; int_start];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Power Factor
if(length(locv) >= length(loci))
    for k = 1:length(loci)
       PF = (Pavg/(vrms*irms));
    end
elseif(length(locv) < length(loci))
    for k = 1:length(locv)
       PF = (Pavg/(vrms*irms));
    end
end