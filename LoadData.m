function [ B ] = LoadData( PathData )

ff = dir(fullfile(PathData,'*.mat'));

for s = 1:length(ff)
    load(fullfile(PathData,ff(s).name));
    
    B(s).Resp  = E.Resp;
    B(s).RT    = E.RespTime;
    B(s).Words = E.Stim.WordLists;
    B(s).Age   = E.sbj.age;
    B(s).Gen   = E.sbj.gender;
end
end

