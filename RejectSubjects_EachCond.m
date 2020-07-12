function [ B ] = RejectSubjects_EachCond( B, thre )

[ B, SW_nan, WD_nan, BD_nan ] = GetNanRate( B );

rej = (SW_nan > thre) | (WD_nan > thre) | (BD_nan > thre);

B(rej) = [];

display(['Subjects rejected (sub num): ', num2str(find(rej))])

end

