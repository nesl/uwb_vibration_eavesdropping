% Expects to get a matrix of slow time X fast time, with a distance bin for
% breathing
function plot_values_over_time(data, bin)  
    
    % Get size of data - dim1 is slow time, dim2 is fast time
    [dim1, dim2] = size(data);
    
    % Step size - this is how quickly we step through the signal
    step = 20;
    window_size = 250; % We show the amplitudes of a 250ms time window
    

    current_values = data(1:end,bin); % Get the amplitudes for this bin
%     current_window = current_values(1:window_size); % Get current window
%     current_window = current_values(1:step);
%     Hd = hpf_breath;
%     current_values = Hd(current_values);
%     Hd = bpf_breath;
%     current_values = Hd(current_values);
%     Hd = lpf_breath;
%     current_values = Hd(current_values);
%     [h, f] = freqz(Hd, 32768, 1000);
%     plot(f(1:100),abs(h(1:100)))


%     % Just for demo
%     current_values = current_values(1:10000);
%     dim1 = 10000;

    current_values = smooth(current_values, 64);
%     i = 0;
%     while((i+1)*2000<length(current_values))
%         if ((i+2000)<length(current_values))
%             temp = current_values(i*2000+1:(i+1)*2000+1);
%             current_values(i*2000+1:(i+1)*2000+1) = temp-mean(temp);
%         else
%             temp = current_values(i*2000+1:end);
%             current_values(i*2000+1:end) = temp-mean(temp);
%         end
%         i = i+1;
%     end

    current_values = (current_values - min(current_values))/(max(current_values) - min(current_values));
    figure()
    plot(abs(current_values))
    
    
    fig = figure("Position",[10 10 1200 600]);
    ax1 = subplot(1,3,[1 2]);
%     h = animatedline('MaximumNumPoints', 10000); % animate the line
    h = animatedline();
    ylim([0 1]);
    xlim([1 dim1]);
    
    % Load reading video
    ax2 = subplot(1,3,3);
    video = VideoReader("IMG_5004.MOV");
    
    % Load writing video
    video_write = VideoWriter('breathing_2_ziqi_out.avi');
    video_write.FrameRate = (1000/step); % Set to whatever fps we animate at
    open( video_write );
    
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
        vframe = imrotate(vframe, 270);
        image(vframe, 'Parent', ax2);
        
        pause(step/1000); % Pause the animation of our line graph every step milliseconds
        
        % Add video frame to video
        write_frame = getframe(fig);
        writeVideo(video_write, write_frame);
        
    end
    
    % Close writing
    close(video_write);

end