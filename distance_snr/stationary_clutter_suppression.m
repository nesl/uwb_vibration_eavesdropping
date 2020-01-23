function y = stationary_clutter_suppression(x, clutter_coef)
    % This one is designed for sound to remove DC components
    y = loop_filter(x, clutter_coef);
    % Low Frequency removing
    for i = 1: size(y,2)
        temp = y(:,i);
        Hd = notch_60_bw_4;
        temp = Hd(temp);
        Hd = hpf_20;
        temp = Hd(temp);
        y(:,i) = temp;
    end
end