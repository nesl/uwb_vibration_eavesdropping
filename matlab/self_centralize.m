function [data_array] = self_centralize(input_array, zero_mean)
    if zero_mean==0
        data_array = (input_array - min(input_array)) / (max(input_array) - min(input_array));
    else
        data_array = input_array - mean(input_array);
        data_sort = sort(abs(data_array));
%         thd = data_sort(round(length( data_sort)*0.999));
        thd = data_sort(end-5);
%         thd = max(abs(data_array));
        data_array(data_array>thd) = thd;
        data_array(-data_array>thd) = -thd;
        data_array = data_array ./ thd;
    end
end

