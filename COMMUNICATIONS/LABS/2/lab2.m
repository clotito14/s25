% ECE478 LAB 2
% ENGINEER: CHASE LOTITO

Fs = 200;               % SAMPLE FREQ.
t = -2:1/Fs:2;          % LINEAR SPACE FOR TIME
T0 = 1;                 % WIDTH OF TRI PULSE
x = tripuls(t, T0);     % GENERATE TRI PULSE

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