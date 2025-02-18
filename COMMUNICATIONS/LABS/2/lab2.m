% ECE478 LAB 2
% ENGINEER: CHASE LOTITO

Fs = 200;               % SAMPLE FREQ.
t = -2:1/Fs:2;          % LINEAR SPACE FOR TIME
T0 = 1;                 % WIDTH OF TRI PULSE
x = tripuls(t, T0);     % GENERATE TRI PULSE
xprime = tripuls(t/2, T0);

% PLOT THE TRIANGULAR PULSE
figure(1);
plot(t, x);
title('Triangular Pulse \Delta(t)');
xlabel('Time (sec)');
ylabel('Amplitude');

nfft = 1024;            % FFT LENGTH
X = fft(x, nfft);       % PERFORM FFT on x(t)
X = X(1:nfft/2);        % TAKE POSITIVE SPECTRUM`
mx = abs(X/nfft);       % AMPLITUDE SPECTRUM
f = (0:nfft/2-1)*Fs/nfft; % FREQ. VECTOR

% PLOT AMPLITUDE SPECTRUM
figure(2);
plot(f, mx);
title('Amplitude Spectrum of \Delta(t)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% MODULATE VIA FREQ TRANSLATION
fc = 50;
y = x .* cos(2 * pi * fc * t);
yprime = xprime .* cos(2 * pi * fc * t);

% PLOT MODULATED TIME DOMAIN SIGNAL
figure(3);
plot(t,y);
title('\Delta(t)cos(2\pif_ct)');
xlabel('Time (sec)');
ylabel('Amplitude');

nfft = 1024;            % FFT LENGTH
Y = fft(y, nfft);       % PERFORM FFT on x(t)
Y = Y(1:nfft/2);        % TAKE POSITIVE SPECTRUM`
my = abs(Y/nfft);       % AMPLITUDE SPECTRUM
f = (0:nfft/2-1)*Fs/nfft; % FREQ. VECTOR

% PLOT MODULATED AMPLITUDE SPECTRUM
figure(4);
plot(f, my);
title('Amplitude Spectrum of \Delta(t)cos(2\pif_ct)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');


% FOR THE /\(T/2) SIGNAL 

% PLOT MODULATED TIME DOMAIN SIGNAL
figure(5);
plot(t,yprime);
title('\Delta(t/2)cos(2\pif_ct)');
xlabel('Time (sec)');
ylabel('Amplitude');

nfft = 1024;            % FFT LENGTH
Yprime = fft(yprime, nfft);       % PERFORM FFT on x(t)
Yprime = Yprime(1:nfft/2);        % TAKE POSITIVE SPECTRUM`
myprime = abs(Yprime/nfft);       % AMPLITUDE SPECTRUM
f = (0:nfft/2-1)*Fs/nfft; % FREQ. VECTOR

% PLOT MODULATED AMPLITUDE SPECTRUM
figure(6);
plot(f, myprime);
title('Amplitude Spectrum of \Delta(t/2)cos(2\pif_ct)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');