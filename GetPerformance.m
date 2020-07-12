function [ B ] = GetPerformance( B )

for n = 1:length(B)
    
    % All in vector form
    Resp  = B(n).Resp(:);
    Words = B(n).Words(:);
    RT    = B(n).RT(:);
    
    % Classify words
    WD = Words == 7; % Word Deviant
    BD = Words == 8; % Bigram Deviant
    SW = Words <=6;
    
    % Reject trials with no response
    rej = isnan(Resp);
    
    Resp(rej) = [];
    WD(rej)   = [];
    BD(rej)   = [];
    SW(rej)   = [];
    RT(rej)   = [];
        
    % Hits and False alarms
    B(n).WD_Hits    = mean(Resp(WD));
    B(n).BD_Hits    = mean(Resp(BD));
    B(n).FalseAlarm = mean(Resp(SW));
    
    % As HitRates and FalseAlarms of 1 or 0 produce dPrimes of Inf and -Inf
    % respectively, cap performance to (n-1)/n
    
    if B(n).WD_Hits == 1; B(n).WD_Hits = 59/60; end
    if B(n).WD_Hits == 0; B(n).WD_Hits =  1/60; end
    
    if B(n).BD_Hits == 1; B(n).BD_Hits = 59/60; end
    if B(n).BD_Hits == 0; B(n).BD_Hits =  1/60; end
    
    if B(n).FalseAlarm == 1; B(n).FalseAlarm = 1079/1080; end
    if B(n).FalseAlarm == 0; B(n).FalseAlarm =    1/1080; end

    % dPrime
    B(n).WD_dPrime    = norminv(B(n).WD_Hits) - norminv(B(n).FalseAlarm);
    B(n).BD_dPrime    = norminv(B(n).BD_Hits) - norminv(B(n).FalseAlarm);
    
    % Reaction times
    B(n).RT_WD = median(RT(WD));
    B(n).RT_BD = median(RT(BD));
    B(n).RT_SW = median(RT(SW));
end