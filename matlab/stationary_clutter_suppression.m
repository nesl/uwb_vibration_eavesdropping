function y = stationary_clutter_suppression(x)
    % This one is designed for removing DC components only
    % y = loop_filter(x, clutter_coef);
    % Low Frequency removing
    y = x;
    for i = 1: size(y,2)
        temp = y(:,i);
        Hd = notch_60_bw_4;
        temp = Hd(temp);
        Hd = hpf_20;
        temp = Hd(temp);
        y(:,i) = temp;
    end
end
