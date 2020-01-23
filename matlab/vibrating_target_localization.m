function y = vibrating_target_localization(iqmat)
    % iqmat - UWB data matrix
    
    Fs = 1000; % Sampling frequency              
    T = 1/Fs;             % Sampling period       
    L = size(iqmat, 1); % Length of signal
    t = (0:L-1).*T;        % Time vector
    f = Fs*(0:(round(L/2)))/L;
    
    index_20 = 0;
    for i = 1: length(f)
        if f(i)<=20
            index_20 = i;
        end
    end
    
    fft_mat = zeros(size(iqmat));
    for i = 1:1:size(iqmat, 2)
        fft_mat(:,i) = fft(iqmat(:,i));
    end
    
    fft_mat = fft_mat(index_20:end-index_20, :);
    concentration_out = zeros(size(iqmat, 2), 1);
    
    for i = 1:1:size(iqmat, 2)
        ci = concentrationIndices(abs(fft_mat(:,i)));
        concentration_out(i) = ci.HH;
    end
    
    [~,object_inx] = findpeaks(concentration_out,'SortStr','descend');
    object_inx(object_inx==26 | object_inx==1)=[];
    if length(object_inx) < 1
        fprintf('[no object]');
        return;
    end
    y = object_inx(1);

end