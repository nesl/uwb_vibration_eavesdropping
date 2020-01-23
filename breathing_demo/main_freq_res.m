close all; clear all; clc
cache_dir = "/home/ziqi/Desktop/temp_cache_f/";
filelist = dir(cache_dir);
list_length = length(filelist);
SNR_array_foil = [];
freq_array_foil = [];

for range = 3:list_length
    filelist = dir(cache_dir);
    filename = filelist(range).name;
    name_info = split(filename, "_");
    freq = str2double(cell2mat((name_info(1)))) + ...
           0.01 * str2double(cell2mat((name_info(2))));
    filename = cache_dir + filename;
    load(filename);
    [vib_bin, bb_frames] = findvibrationbin(bb_frames);
    Fs = 1000;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = size(bb_frames, 1); % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:(round(L/2)))/L;
    
    SNR_temp = [];

    for j = 1:size(bb_frames, 2)
%         data = bb_frames(:,vib_bin(1));
        data = bb_frames(:,j);
        Y = fft(data);
        P2 = abs(Y);
        P1 = P2(1:round(L/2)+1);
        P1(2:end-1) = 2*P1(2:end-1);

        f_target = freq;
        bw_target = 2;
        f_index = find(abs(f - f_target)< bw_target);

        signal_power = sum(abs(P1(f_index)).^2);
        noise_power = sum(abs(P1).^2) - signal_power;
        SNR = 10*log10(signal_power/noise_power);
        SNR_temp = [SNR_temp SNR];
    end

    max_SNR = max(SNR_temp);
    max_bin = find(SNR_temp == max(SNR));
    SNR_array_foil = [SNR_array_foil max_SNR];
    freq_array_foil = [freq_array_foil freq];
    fprintf("%d", vib_bin(1));
end

cache_dir = "/home/ziqi/Desktop/temp_cache_p/";
filelist = dir(cache_dir);
list_length = length(filelist);
SNR_array_paper = [];
freq_array_paper = [];

for range = 3:list_length
    filelist = dir(cache_dir);
    filename = filelist(range).name;
    name_info = split(filename, "_");
    freq = str2double(cell2mat((name_info(1)))) + ...
           0.01 * str2double(cell2mat((name_info(2))));
    filename = cache_dir + filename;
    load(filename);
    [vib_bin, bb_frames] = findvibrationbin(bb_frames);
    Fs = 1000;            % Sampling frequency                    
    T = 1/Fs;             % Sampling period       
    L = size(bb_frames, 1); % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:(round(L/2)))/L;
    
    SNR_temp = [];

    for j = 1:size(bb_frames, 2)
%         data = bb_frames(:,vib_bin(1));
        data = bb_frames(:,j);
        Y = fft(data);
        P2 = abs(Y);
        P1 = P2(1:round(L/2)+1);
        P1(2:end-1) = 2*P1(2:end-1);

        f_target = freq;
        bw_target = 2;
        f_index = find(abs(f - f_target)< bw_target);

        signal_power = sum(abs(P1(f_index)).^2);
        noise_power = sum(abs(P1).^2) - signal_power;
        SNR = 10*log10(signal_power/noise_power);
        SNR_temp = [SNR_temp SNR];
    end

    max_SNR = max(SNR_temp);
    max_bin = find(SNR_temp == max(SNR));
    SNR_array_paper = [SNR_array_paper max_SNR];
    freq_array_paper = [freq_array_paper freq];
    fprintf("%d", vib_bin(1));
end

% distance_range = 30:10:140;
% diaphragm_type = "f";
% SNR_array_foil = [];
% bin_array_foil = [];
% for range = 1:length(distance_range)
%     dist = distance_range(range);
%     filename = "/home/ziqi/Desktop/cached_data_20191124/dist_220_00_"...
%                + int2str(dist) + "_" + diaphragm_type + ".mat";
%     load(filename);
%     bb_frames = phase_noise_correction(bb_frames, 1);
%     bb_frames = stationary_clutter_suppression(bb_frames, 0.97);
%     Fs = 1000;            % Sampling frequency                    
%     T = 1/Fs;             % Sampling period       
%     L = size(bb_frames, 1); % Length of signal
%     t = (0:L-1)*T;        % Time vector
%     f = Fs*(0:(round(L/2)))/L;
%     
%     SNR_temp = [];
%     for j = 1:size(bb_frames, 2)
%         data = bb_frames(:,j);
%         Y = fft(data);
%         P2 = abs(Y);
%         P1 = P2(1:round(L/2)+1);
%         P1(2:end-1) = 2*P1(2:end-1);
% 
%         f_target = 220.6;
%         bw_target = 2;
%         f_index = find(abs(f - f_target)< bw_target);
% 
%         signal_power = sum(abs(P1(f_index)).^2);
%         noise_power = sum(abs(P1).^2) - signal_power;
%         SNR = 10*log10(signal_power/noise_power);
%         SNR_temp = [SNR_temp SNR];
%     end
%     max_SNR = max(SNR_temp);
%     max_bin = find(SNR_temp == max(SNR));
%     SNR_array_foil = [SNR_array_foil max_SNR];
%     bin_array_foil = [bin_array_foil max_bin];
%     fprintf("%d", range);
% end
% figure()
% hold on
% plot(30:10:100, SNR_array_paper, "-.*", "linewidth", 2, "markersize", 5)
% plot(30:10:140, SNR_array_foil, "--o", "linewidth", 2, "markersize", 5)
% ylabel("SNR/dB")
% xlabel("Speaker Distance/cm")
% legend("Speaker w/o tin foil", "Speaker w/ tin foil")



% filepath = "/home/ziqi/Desktop/collected_data_20191124/dist_220_00_70_p.txt";
% bb_frames = read_file_into_matrix(filepath);

% load("/home/ziqi/Desktop/cached_data_20191124/dist_220_00_40_p.mat")

% target_bins = findsoundbin(bb_frames); 

%         [value_max,id_max]=max(P1);

% figure()
% plot(f,P1) 


% signal_template = sin(2*pi*f_target*t);

% SNR_phase = snr(phase(data));
% SNR_amp = snr(abs(data));
% soundsc(abs(data),Fs)

% [sound_wave, sound_Fs] = audioread("mary_has_a_little_lamb.wav");

% figure()
% plot(f(1000:end),P1(1000:end)) 
% title('Single-Sided Amplitude Spectrum of X(t)')
% xlabel('f (Hz)')
% ylabel('|P1(f)|')

% figure()
% stft(bb_frames(:,14),Fs,'Window',hamming(256),'OverlapLength',192,'FFTLength',256);

% This is for "marry has a little lamb" recovery
% % [S, F, T] = stft(bb_frames(:,4),Fs,'Window',hamming(192),'OverlapLength',160,'FFTLength',192);
% [S, F, T] = stft(bb_frames(:,4),Fs,'Window',hamming(256),'OverlapLength',192,'FFTLength',256);

% % Reserved: pcolor usage
% s = pcolor(abs(bb_frames));
% set(s, 'EdgeColor', 'none');
% s.FaceColor = 'interp';

% plot(abs(bb_frames(2000,:)))
% plot(angle(bb_frames(1:2000,4)))

