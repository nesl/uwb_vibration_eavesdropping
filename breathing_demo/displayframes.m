function frame = displayframes(timestamp, video)
    
    v = video;
    v.CurrentTime = timestamp;
    if hasFrame(v)
        frame = readFrame(v);
    end
end