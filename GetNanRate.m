function [ B, SW_nan, WD_nan, BD_nan, All_nan ] = GetNanRate( B )

for n = 1:length(B)
    
    % All in vector form
    Resp  = B(n).Resp(:);
    Words = B(n).Words(:);
        
    % Classify words
    WD = Words == 7;
    BD = Words == 8;
    SW = Words <=6;
    
    
    % NaN rates for each condition
    SW_nan(n)    = mean(isnan(Resp(SW)));
    WD_nan(n)    = mean(isnan(Resp(WD)));
    BD_nan(n)    = mean(isnan(Resp(BD)));
    All_nan(n)    = mean(isnan(Resp));
    
end