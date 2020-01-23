function [object_inx, sig_dc_remove] = findvibrationbin(iqmat)

%iqmat: (fs*30, bincnt)
sig_baseband_dec = phase_noise_correction(iqmat, 1);

% 30 seconds dec bg
% breath_win = 30;
%breath_win_samples = breath_win * fps;
%sig_baseband_dec_bg = sig_baseband_dec - mean(sig_baseband_dec);

% cfar_param.guard_cells = [1 1];
% cfar_param.training_cells = [2 2];
% cfar_param.alg = 'OS-CFAR';
% cfar_out = detector_CFAR(sig_baseband_dec_bg, cfar_param);

%smooth
% smooth_win = 16;
% for i = 1 : size(sig_baseband_dec,2)
%     sig_smooth(:,i) = smooth(sig_baseband_dec(: ,i), smooth_win);
% end


% clutters suppression, exponential average 
clutter_coef = 0.9;

% initial sig_bg
% sig_bg = sig_baseband_dec;
% for i = 1 : size(sig_baseband_dec, 2)
%     for j = 2 : size(sig_baseband_dec, 1)
%         sig_bg( j,i) = sig_baseband_dec( j - 1 ,i) * (1 - clutter_coef) + sig_baseband_dec(j, i)*clutter_coef;
%     end
% end
% 
% sig_bg_remove = sig_baseband_dec -  sig_bg;
% sig_bg_remove = sig_bg_remove(2:end,:);
sig_bg_remove = sig_baseband_dec;




% DC remove
sig_dc_remove = zeros(size(sig_bg_remove) - [250 0]);%detrend(sig_smooth);
Hd = hpf_5_20;
for i = 1 : size(sig_bg_remove, 2)
    temp = Hd(sig_bg_remove(:,i));
    sig_dc_remove(:,i) = temp(251:end);
end

% automatic scale 

scale_max = 100;

% standard deviation  detection
sig_sd =  std(sig_bg_remove);

if 0
% width of person is less 50cm
cfar_param.guard_cells = [0 3];
cfar_param.training_cells = [0 4];
cfar_param.alg = 'CA-CFAR';

% subplot(211);
% plot(sig_sd);
cfar_out = detector_CFAR(sig_sd, cfar_param);
end


Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = size(sig_dc_remove, 1); % Length of signal
t = (0:L-1).*T;        % Time vector
f = Fs*(0:(round(L/2)))/L;

sig_fft = zeros(length(f), size(sig_dc_remove, 2));
for i = 1 : size(sig_dc_remove, 2)
    Y = fft(sig_dc_remove(:,i));
    P2 = abs(Y);
    P1 = P2(1:round(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    sig_fft(:,i) = P1;
end

% h = pcolor((sig_fft)); set(h,"EdgeColor","None")

param.guard_cells = [30 1];
param.training_cells = [100 2];
param.threshold = 1;
param.alg = 'CA-CFAR';
% param.alg = 'OS-CFAR';

% cfar_out = sum(detector_CFAR_v26(sig_fft, param));
cfar_out = zeros(1, size(sig_fft, 2));
for i = 1 : size(sig_fft, 2)
    temp = concentrationIndices(sig_fft(:,i));
    cfar_out(i) = temp.HH;
end
% subplot(212);
% plot(cfar_out);
[~,object_inx] = findpeaks(cfar_out,'SortStr','descend');
if length(object_inx) < 1
    fprintf('[no object]');
    return;
end

end
