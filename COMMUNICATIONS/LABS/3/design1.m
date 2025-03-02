% ECE478 - MATLAB Lab 3
% Amplitude Modulation of Multi-Tone
% Chase Lotito

% Defining AM modulation Index
mu1 = 0.5;
mu2 = 1;
mu3 = 1.25;

% Defining frequencies of message signal
f1 = 50;
f2 = 75;
f3 = 100;

% Defining frequency of carrier signal
fc = input('Enter carrier frequency (fc) (fc>>fm) (e.g. fc = fm*10) = ');

N = 2048;    % N point FFT N>fc to avoid freq domain aliasing
fs = 8192;    % sample frequency
t = (0:N-1)/fs;

% Generating modulating signal (message signal)
A1 = 1;
A2 = 1;
A3 = 1;
mt = A1 * cos(2 * pi * f1 * t) + A2 * cos(2 * pi * f2 * t) + A3 * cos(2 * pi * f3 * t);    % generating the message signal
figure(1)
subplot(8,1,1);
plot(t, mt), grid on;    % A plot for the message signal
title('Message Signal');
xlabel('time');
ylabel('Amplitude');

% Generating carrier signal
Ac = 5;    % Amplitude of carrier signal
ct = Ac * cos(2 * pi * fc * t);    % generation of carrier signal
subplot(8,1,2);
plot(t, ct), grid on;    % A plot for the carrier signal
title('Carrier Signal');
xlabel('time');
ylabel('Amplitude');

% Generating 50% AM Modulated signal
st1 = Ac * (1 + mu1 * mt) .* cos(2 * pi * fc * t);    % AM wave
subplot(8,1,3);
plot(t, st1);    % a plot for the AM signal
title('50% Amplitude Modulated signal');
xlabel('time');
ylabel('Amplitude');

% Generating spectrum of 50% AM wave
Sf = 2 / N * abs(fft(st1, N));
f = fs * (0 : N/2) / N;    % fft is symmetric, only the positive half is sufficient
subplot(8,1,4);
plot(f(1:256), Sf(1:256));    % a plot for the AM signal
title('Spectrum of 50% AM signal');
xlabel('Frequency');
ylabel('Amplitude Spectrum');


% Generating 100% AM Modulated signal
st2 = Ac * (1 + mu2 * mt) .* cos(2 * pi * fc * t);    % AM wave
subplot(8,1,5);
plot(t, st2);    % a plot for the AM signal
title('100% Amplitude Modulated Signal');
xlabel('time');
ylabel('Amplitude');

% Generating spectrum of 100% AM wave
Sf = 2 / N * abs(fft(st2, N));
f = fs * (0 : N/2) / N;    % fft is symmetric, only the positive half is sufficient
subplot(8,1,6);
plot(f(1:256), Sf(1:256));    % a plot for the AM signal
title('Spectrum of 100% AM signal');
xlabel('Frequency');
ylabel('Amplitude Spectrum');



% Generating 125% AM Modulated signal
st3 = Ac * (1 + mu3 * mt) .* cos(2 * pi * fc * t);    % AM wave
subplot(8,1,7);
plot(t, st3);    % a plot for the AM signal
title('125% Amplitude Modulated signal');
xlabel('time');
ylabel('Amplitude');

% Generating spectrum of 125% AM wave
Sf = 2 / N * abs(fft(st3, N));
f = fs * (0 : N/2) / N;    % fft is symmetric, only the positive half is sufficient
subplot(8,1,8);
plot(f(1:256), Sf(1:256));    % a plot for the AM signal
title('Spectrum of 125% AM signal');
xlabel('Frequency');
ylabel('Amplitude Spectrum');