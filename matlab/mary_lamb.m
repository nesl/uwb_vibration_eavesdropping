% filepath = "/home/ziqi/Desktop/collected_data_20191124/mary_1.txt";
% % filepath = "/home/ziqi/Desktop/collected_data_20191122/220_00_0.txt";
% % filepath = "/home/ziqi/Desktop/collected_data_20191109/261_63_1.txt";

% bb_frames = read_file_into_matrix(filepath);
load("/home/ziqi/Desktop/cached_data_20191124/mary_0.mat");
bb_frames = phase_noise_correction(bb_frames, 1);
bb_frames = stationary_clutter_suppression(bb_frames, 0.97);


Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(bb_frames, 1); % Length of signal
t = (0:L-1)*T;        % Time vector
f = Fs*(0:(L/2))/L;

Y = fft(bb_frames(:,3));
% P2 = abs(Y/L);
P2 = abs(Y);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

plot(f(1000:end),P1(1000:end)) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

%This is for "marry has a little lamb" recovery
figure()
stft(bb_frames(:,3),Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);
[S, F, T] = stft(bb_frames(:,3),Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);
% [S, F, T] = stft(bb_frames(:,3),Fs,'Window',hamming(192),'OverlapLength',160,'FFTLength',192);
S(95:97,:) = zeros(3, length(T));
% S = abs(S(96:end,:));
S = abs(S);
[recoverd_sound, recovered_time] = istft(S, Fs,'Window',hamming(256, "periodic"),'OverlapLength',192,'FFTLength',256);
recoverd_sound = abs(recoverd_sound(200: end-200));
recoverd_sound = ((recoverd_sound - min(recoverd_sound)) / (max(recoverd_sound)-min(recoverd_sound)) - 0.5) *2;
soundsc(recoverd_sound, Fs)
% audiowrite("recovered_mary.wav",recoverd_sound,Fs)


% % Discarded: calculate amplitude
% for i = 1:size(bb_frames, 1)
%     for j = 1:size(bb_frames, 2)
%         bb_frames(i, j) = abs(bb_frames(i, j)^2);
%     end
% end

% % Reserved: pcolor usage
% s = pcolor(abs(bb_frames));
% set(s, 'EdgeColor', 'none');
% s.FaceColor = 'interp';

% plot(abs(bb_frames(2000,:)))
% plot(angle(bb_frames(1:2000,4)))

