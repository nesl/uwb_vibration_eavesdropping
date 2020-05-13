function y = stationary_clutter_suppression(x)
%     % Pre-emphasis
%     use_pre_emp = 1;
%     if use_pre_emp
%         y = preemphasis(x, 0.9);
%     else
%         y = x;
%     end
    y = x;
    % Low Frequency removing
%     
    for i = 1: size(y,2)
        temp = y(:,i);
        [Hd, b] = hpf_20_70; % high pass FIR, stop at 20 pass at 100
        temp = filtfilt(b,1,temp);
        
        % comb filting solving interference caused by power (60Hz) and its
        % multiples. Please be aware of the unstability at the beginning
        % and the end caused by IIR non-linear phase delays, also the
        % sampling rate is set to be 1200
        
%         temp = resample(temp, 6, 5);
%         [Hd, b, a] =  comb_1200fs_60x_bw8;
%         temp = filtfilt(b,a,temp);
        
        y(:,i) = temp;
    end
end
