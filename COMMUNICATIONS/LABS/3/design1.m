% ECE478 - MATLAB Lab 3
% Amplitude Modulation of Multi-Tone
% Chase Lotito

% Defining AM modulation Index
mu = input('Enter the value of modulation index (mu) = ');

% Defining frequencies of message signal
f1 = 25;
f2 = 50;
f3 = 100;

% Defining frequency of carrier signal
fc = input('Enter carrier frequency (fc) (fc>>fm) (e.g. fc = fm*10) = ');

N = 1024;    % N point FFT N>fc to avoid freq domain aliasing
fs = 4096;    % sample frequency
t = (0:N-1)/fs;

% Generating modulating signal (message signal)
A1 = 5;
A2 = 5;
A3 = 5;
mt = A1 * cos(2 * pi * f1 * t) + A2 * cos(2 * pi * f2 * t) + A3 * cos(2 * pi * f3 * t);    % generating the message signal
figure(1)
subplot(4,1,1);
plot(t, mt), grid on;    % A plot for the message signal
title('Message Signal');
xlabel('time');
ylabel('Amplitude');

% Generating carrier signal
Ac = 10;    % Amplitude of carrier signal
ct = Ac * cos(2 * pi * fc * t);    % generation of carrier signal
subplot(4,1,2);
plot(t, ct), grid on;    % A plot for the carrier signal
title('Carrier Signal');
xlabel('time');
ylabel('Amplitude');

% Generating AM Modulated signal
st = Ac * (1 + mu * mt) .* cos(2 * pi * fc * t);    % AM wave
subplot(4,1,3);
plot(t, st);    % a plot for the AM signal
title('Amplitude Modulated signal');
xlabel('time');
ylabel('Amplitude');

% Generating spectrum of AM wave
Sf = 2 / N * abs(fft(st, N));
f = fs * (0 : N/2) / N;    % fft is symmetric, only the positive half is sufficient
subplot(4,1,4);
plot(f(1:256), Sf(1:256));    % a plot for the AM signal
title('Spectrum of AM signal');
xlabel('Frequency');
ylabel('Amplitude Spectrum');