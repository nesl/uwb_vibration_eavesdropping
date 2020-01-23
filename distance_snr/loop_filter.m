function y = loop_filter(x, clutter_coef)

bg_x = zeros(size(x));

for i = 1 : size(x, 2)
    for j = 1 : size(x, 1)
        if j == 1
            bg_x(j,i) = x(j, i);  
            continue;
        end
        bg_x(j,i) = x( j - 1 ,i) * (1 - clutter_coef) + x(j, i);
        
    end
end

y = x - bg_x;



end