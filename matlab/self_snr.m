function [SNR_calc] = self_snr(data, Fs, f_target, bw_target)
%     Fs: sampling rate
%     f_target: signal frequency
%     data: input sound
%     bw_bandwith: allowed frequency scatter
%     SNR_calc: estimated snr
               
    data =  data.*hamming(length(data));
    T = 1/Fs;             % Sampling period       
    L = size(data, 1); % Length of signal
    t = (0:L-1)*T;        % Time vector
    f = Fs*(0:(round(L/2)))/L;
    
    SNR_calc = -realmax;
    Y = fft(data);
    P2 = abs(Y);
    P1 = P2(1:round(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    
    [~, max_inx] = max(P1);
    if abs(f(max_inx)-f_target) <= 5 
       f_target =  f(max_inx); % Main frequency has shifted a little bit
    end

    f_index = find(abs(f - f_target)< bw_target);
    
    signal_power = sum(abs(P1(f_index)).^2);
    noise_power = sum(abs(P1).^2) - signal_power;
    SNR_calc = 10*log10(signal_power/noise_power);

end

