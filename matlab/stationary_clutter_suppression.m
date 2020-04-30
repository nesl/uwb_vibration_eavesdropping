function y = stationary_clutter_suppression(x)
    % Pre-emphasis
%     y = preemphasis(x, 0.98);
    % Low Frequency removing
    y = x;
    for i = 1: size(y,2)
        temp = y(:,i);
        Hd = notch_60_bw_4;
        temp = Hd(temp);
        Hd = hpf_20_100;
        temp = Hd(temp);
        y(:,i) = temp;
    end
end
