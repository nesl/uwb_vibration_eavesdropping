% Expects to get a matrix of slow time X fast time, with a distance bin for
% breathing
function plot_values_over_time(data, bin)  
    
    % Get size of data - dim1 is slow time, dim2 is fast time
    [dim1, dim2] = size(data)
    
    % Step size - this is how quickly we step through the signal
    step = 20;
    window_size = 250; % We show the amplitudes of a 250ms time window
    
    current_values = data(1:end,bin); % Get the amplitudes for this bin
%     current_window = current_values(1:window_size); % Get current window
%     current_window = current_values(1:step);

    fig = figure;
    ax1 = subplot(1,2,1);
    h = animatedline('MaximumNumPoints', 2000); % animate the line
    ylim([0.0, 0.04]);
    
    % Load reading video
    ax2 = subplot(1,2,2);
    video = VideoReader("videos\breathing_1_c.mp4");
    
    % Load writing video
    video_write = VideoWriter("C:\Users\Brian\Documents\UCLA\Classes\CS 219\uwb_vibration_eavesdropping\breathing\videos\breathing_1_c_out.avi");
    video_write.FrameRate = (1000/step); % Set to whatever fps we animate at
    open(video_write);
    
    % Iterate through each time step
    % At every time step, we append a number of datapoints to the animated line (same as step size)
    %  We display the updated animated line, as well as the corresponding
    %  video frame.
    for time = 1:step:(dim1-step)
        
        % Get the current window to add to the animated line
        current_window = current_values(time:(time+step));
        
        % Get time stamps and values, and then draw
        t = time:1:(time+step);
        addpoints(h, t, abs(current_window));
        drawnow
        
        %Display video frame
        vframe = displayframes(time/1000, video);
        image(vframe, 'Parent', ax2);
        
        pause(step/1000); % Pause the animation of our line graph every step milliseconds
        
        % Add video frame to video
        write_frame = getframe(fig);
        writeVideo(video_write, write_frame);
        
    end
    
    % Close writing
    close(video_write);

end