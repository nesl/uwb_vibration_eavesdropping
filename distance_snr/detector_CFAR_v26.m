function [out] = detector_CFAR_v26(in, param )

guard_cells = param.guard_cells;
training_cells = param.training_cells;

if length(guard_cells) == 1
    Ngc = guard_cells;
    Ngr = 0;
    Ntc = training_cells;
    Ntr = 0;
else
    Ngc = guard_cells(2);
    Ngr = guard_cells(1);
    Ntc = training_cells(2);
    Ntr = training_cells(1);    
end

[in_row_max, in_col_max] = size(in);

colstart = Ntc + Ngc + 1;
colend = in_col_max - ( Ntc + Ngc);
rowstart = Ntr + Ngr + 1;
rowend = in_row_max - ( Ntr + Ngr);

conv_filter = ones( 2*(Ntr + Ngr) + 1, 2*(Ntc + Ngc) + 1 );
conv_filter( Ntr + 1 : Ntr + Ngr * 2, Ntc + 1 : Ntc + Ngc * 2  ) = 0;


filter_out = zeros(in_row_max, in_col_max);
out = filter_out;
if param.alg == 'CA-CFAR'
    for m = 1 : rowend
        for n = 1:colend
           thresh = 1.8;
           beginrow =  - Ntr - Ngr + m;
           begincol =  -Ntc -Ngc + n;
           endrow = Ntr + Ngr  + m;
           endcol = Ntc + Ngc + n;
           if beginrow<1
               thresh = 1.5;
               beginrow = 1;
           end
           if begincol<1
               thresh = 1.5;
               begincol = 1;
           end
           %thresh = thresh*((endrow-beginrow+1)*(endcol-begincol+1))/((Ntr*2+Ngr*2+1)*(Ntc*2+Ngc*2+1));
           filter_out(  m,  n ) = ...
               mean(mean((in( beginrow : endrow,  begincol : endcol ) .* conv_filter(end-endrow+beginrow:end,end-endcol+begincol:end) )));
           if in(  m,  n ) > thresh*filter_out(  m,  n )
               out(m,n) = in(  m,  n );
           end
        end
    end
end

if param.alg == 'OS-CFAR'
    for m = rowstart : rowend
        for n = colstart:colend
            tmp =  in( - Ntr - Ngr + m : Ntr + Ngr  + m,  -Ntc -Ngc + n : Ntc + Ngc + n ).* conv_filter;
            tmp = sort(tmp(:), 'descend');
            k = floor((length(tmp)*3)/4);
            filter_out(  m,  n ) = 1.0*tmp(k);               
            if in(  m,  n ) > filter_out(  m,  n )
                out(m,n) = in(  m,  n );
            end
        end
    end
    
    
    
end


% out = filter_out;


end

