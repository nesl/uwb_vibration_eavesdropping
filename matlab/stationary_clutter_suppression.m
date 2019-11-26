function y = stationary_clutter_suppression(x, clutter_coef)
    % DC removing
    x_dc = mean(mean(x));
    x_dc_remove = x - x_dc;
    
    y = loop_filter(x_dc_remove, clutter_coef);
end