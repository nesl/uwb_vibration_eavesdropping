[data, fs] = audioread('~/Desktop/uwb_audiofiles/human-reading-numbers.mp3');
figure()
stft(data, fs);
Fs = 1500;
data = resample(data, 15, 441); % Should find a way to allow aliasing here
figure()
stft(data, Fs)
[Hd, b] = hpf_20_70; % high pass FIR, stop at 20 pass at 100
data = filtfilt(b,1,data);
a = [0.123150733969459,0.377012113445062,0.377012113445062,0.123150733969459];
data = filtfilt(a, 1, data);
figure()
stft(data, Fs)
data = awgn(data, 15, "measured");
figure()
stft(data, Fs)
