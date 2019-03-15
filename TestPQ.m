% Test for Power Functions
clear;
clc;
w=pi;
t=[0:.001:2];

v=1*cos(w*t);%voltage
i=.8*cos(w*t) + 0.25*cos(2*w*t + 15*pi/180) + 0.5*cos(3*w*t + 19*pi/180) + .125*cos(6*w*t+35*pi/180);%current
f = w/(2*pi);
fs = 1/0.001;

vfft = fft(v);
ifft = fft(i);
n = length(i);

vabs = abs(vfft);
iabs = abs(ifft);

vabs_modified = vabs/1000;
iabs_modified = iabs/1000;

fvector=[0:0.5:fs/2];

phv = unwrap(angle(vfft));
phi = unwrap(angle(ifft));

iabs_modified(fs+2:end) = [];
vabs_modified(fs+2:end) = [];

%Graphing the fft of current and voltage
figure(1)
stem(fvector,iabs_modified);
xlabel('f(Hz)'); ylabel('|I|'); title('|FFT| of i'); grid;
figure(2)
stem(fvector,vabs_modified);
xlabel('f(Hz)'); ylabel('|V|'); title('|FFT| of v'); grid;


pkv = [];
locv = [];
phv = [];
vt = 0;
vrms = [];
[temp, val] = find(vabs_modified >= 0.1);
locv = [locv ; val];
phv = [phv ; angle(vfft(locv))];
pkv = [pkv ; vabs_modified(locv)];
locv = (locv - 1) ./ 2;

pki = [];
loci = [];
phi = [];
it = 0;
irms = [];
[temp, val] = find(iabs_modified >= 0.1);
loci = [loci ; val];
phi = [phi ; angle(ifft(loci))];
pki = [pki ; iabs_modified(loci)];
loci = (loci - 1) ./ 2;

Pavg = 0;
THDv = 0;
THDi = 0;
PF = 0;

% Voltage as a function of time
for k = 1:length(phv)
    temp = pkv(k)*sin(k*w*t+phv(k));
    vt = (vt + temp);
end

% Current as a function of time
for k = 1:length(phi)
    temp = pki(k)*sin(k*w*t+phi(k));
    it = (it + temp);
end

%Voltage rms
for k = 1:length(phv)
    temp = sqrt((pkv(k)^2)/2);
    vrms = [vrms ; temp];
end

% Current rms
for k = 1:length(phi)
    temp = sqrt((pki(k)^2)/2);
    irms = [irms ; temp];
end

% Real Power
if(length(phv) >= length(phi))
    for k = 1:length(phi)
       temp = vrms(k)*irms(k)*(cos(phv(k)-phi(k)));
       Pavg = Pavg + temp;
    end
elseif(length(phv) < length(phi))
    for k = 1:length(phv)
       temp = vrms(k)*irms(k)*(cos(phv(k)-phi(k)));
       Pavg = Pavg + temp;
    end
end

% THD for Voltage
for k = 2:length(phv)
   temp = (sqrt(vrms(k)^2)/vrms(1));
   THDv = THDv + temp;
end
THDv = THDv * 100;

% THD for Currrent
for k = 2:length(phi)
   temp = (sqrt(irms(k)^2)/irms(1));
   THDi = THDi + temp;
end
THDi = THDi * 100;

%Power Factor
if(length(phv) >= length(phi))
    for k = 1:length(phi)
       temp = Pavg/(vrms(k)*irms(k));
       PF = PF + temp;
    end
elseif(length(phv) < length(phi))
    for k = 1:length(phv)
       temp = Pavg/(vrms(k)*irms(k));
       PF = PF + temp;
    end
end
