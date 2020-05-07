function [data_array] = self_centralize(input_array, zero_mean)
    data_array = (input_array - min(input_array)) / (max(input_array) - min(input_array));
    if zero_mean==1
        data_array = (data_array - 0.5).*2;
    end
end

