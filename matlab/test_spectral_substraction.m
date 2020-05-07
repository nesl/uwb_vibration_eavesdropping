% filepath = "/home/ziqi/Desktop/noise.txt";
% bb_frames_noise = read_file_into_matrix(filepath);
% filepath = "/home/ziqi/Desktop/sound.txt";
% bb_frames_sound = read_file_into_matrix(filepath);
% bb_frames = [bb_frames_noise(end-1*1000:end,:); bb_frames_sound];

bb_frames = phase_noise_correction(bb_frames, 1);

bb_frames = stationary_clutter_suppression(bb_frames);

bb_frames = [real(bb_frames), imag(bb_frames)];
[object_inx, target_bin] = vibrating_target_localization(bb_frames);

candidate_data = bb_frames(:,target_bin);

output_sound = candidate_data;

% fft analysis
Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(output_sound, 1); % Length of signal
t = (0:L-1).*T;        % Time vector
f = Fs*(0:(round(L/2)))/L;

Y = fft(output_sound);
P2 = abs(Y);  % P2 = abs(Y/L);
P1 = P2(1:round(L/2)+1);
P1(2:end-1) = 2*P1(2:end-1);
figure()
plot(f(1000:end),P1(1000:end)) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% stft analysis

figure()
stft(output_sound,Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);

denoised_output = SSBoll79(output_sound,Fs,1);
figure()
stft(denoised_output,Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);

denoised_output = SSBerouti79(output_sound,Fs,1);
figure()
stft(denoised_output,Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);