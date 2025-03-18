%Defining frequency of message signal
fm = input('Enter frequency of message signal (fm) (e.g. fm = 50) = ');

%Defining frequency of carrier signal
fc = input('Enter carrier frequency (fc) (fc>>fm) (e.g. fc = fm×10) = ');

N = 1024;  %N point FFT N>fc to avoid freq domain aliasing
fs = 4096; % sample frequency
t = (0:N-1)/fs;

%Generating modulating signal (message signal)
Am = 5; % Amplitude of message signal
mt = Am*cos(2*pi*fm*t); % generating the message signal
figure(1)
subplot(4,1,1);
plot(t,mt), grid on; % A plot for the message signal
title('Message Signal');
xlabel('time');
ylabel('Amplitude');

%Generating carrier signal
Ac = 10; % Amplitude of carrier signal
Tc = 1/fc; % Time period of carrier signal
ct = Ac*cos(2*pi*fc*t); % generation of carrier signal
subplot(4,1,2);
plot(t,ct), grid on; % A plot for the carrier signal
title('Carrier Signal');
xlabel('time');
ylabel('Amplitude');

%Generating DSB-SC Modulated signal
st = Ac*Am*cos(2*pi*fm*t).*cos(2*pi*fc*t); % DSB-SC wave
subplot(4,1,3);
plot(t,st); % a plot for the AM signal
title('Amplitude Modulated signal');
xlabel('time');
ylabel('Amplitude');

%Generating spectrum of DSB-SC wave
F = 2/N*abs(fft(st,N));
f = fs * (0:N/2) / N; % fft is symmetric, only the positive half is sufficient
subplot(4,1,4);
plot(f(1:256),F(1:256)); % a plot for the DSB-SC signal
title('Spectrum of DSB-SC signal');
xlabel('frequency');
ylabel('Amplitude Spectrum');

grid on;
