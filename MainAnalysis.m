%% Statistical analysis from the paper entitled:
%  "A general–purpose mechanism of visual feature association at the core of word learning"
%
% Data of each experiment should be saved in a subfolder:
%
%       ...\Data\Exp1
%       ...\Data\Exp2
%       ...\Data\Exp3
%       ...\Data\Exp4

% Created by Yamil Vidal (hvidaldossantos@gmail.com)

clear; clc

Exp        = '1';                              % Experiment number
PathData   = fullfile(pwd,'Data',['Exp',Exp]); % Data path
NoAnsLimit = .2;                               % Max allowed percentage of missing answers for each conditions
LaTeX      = 0;                                % LaTeX formatted output. Boolean

B = LoadData(PathData);

% Reject participants that don't have an answer in more than NoAnsLimit of the trials
[ B ] = RejectSubjects_EachCond( B, NoAnsLimit );
fprintf('\r');

[ B ] = GetPerformance( B );

% Unpack
HPd = [B(:).WD_dPrime];
LPd = [B(:).BD_dPrime];

% d' of each condition
[m, ci] = MeanCI(HPd);
fprintf('High pair-frequency deviant: %.2f [%.2f, %.2f]',[m,ci])
fprintf('\r');

[m, ci] = MeanCI(LPd);
fprintf('Low pair-frequency deviant:  %.2f [%.2f, %.2f]',[m,ci])
fprintf('\r');

% Statistical Testing
Data = LPd' - HPd';

ES = mes(LPd',HPd','hedgesg','isDep',1);
ES.t.p = ES.t.p/2; % p value is one tailed

[m, ci] = MeanCI(LPd-HPd);

s = [m,ci(1),ci(2),...
    ES.t.df,ES.t.tstat,ES.t.p,...
    ES.hedgesg,ES.hedgesgCi(1),ES.hedgesgCi(2)];

fprintf('d'' difference:               %.2f [%.2f, %.2f]',s(1:3))
fprintf('\r\r');

if LaTeX
    % Output is formatted for LaTeX
    fprintf('\\textit{t}\\textsubscript{(%.0f)} = %.2f, \\textit{p} = %.2g, \\textit{g} = %.2f [%.2f, %.2f]',s(4:9));
    fprintf('\r');
else
    fprintf('t(%.0f) = %.2f, p = %.2g, g = %.2f [%.2f, %.2f]',s(4:9));
    fprintf('\r');
end

d   = (LPd - HPd)>0;
hit = sum(d);
tot = length(d);

[r,ci] = binofit(hit,tot);
p      = myBinomTest(hit,tot,.5,'one');

if LaTeX
    % Output is formatted for LaTeX
    fprintf('\r');
    fprintf('%.2f\\%% [%.2f\\%%, %.2f\\%%], or %.0f out of %.0f, one-sided binomial test: \\textit{p} = %.2g',[r*100,ci.*100,hit,tot,p]);
    fprintf('\r');
else
    fprintf('\r');
    fprintf('%.2f%% [%.2f%%, %.2f%%], or %.0f out of %.0f, one-sided binomial test: p = %.2g',[r*100,ci.*100,hit,tot,p]);
    fprintf('\r');
end