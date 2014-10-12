% generowanie pliku csv z lsoowymi wartosciami cech
% zakladamy ze mamy litery a, b , c, d ...w zaleznosci od l_sym
% max_value - wartosc maksymalna dla wartosci cechy
% cechy beda losowane z przedzialu od 0 do max_value

function [] = generate_csv(l_sym, l_cech, max_value)
A= rand(l_sym,l_cech+1)*(max_value+1);

A = uint16(A);
%B = char(l_sym,l_cech+1);
for i=1:l_sym
    B(i,1) =num2cell(char(96+i));
end;

for i=1 :l_sym
    for j=2:l_cech+1
          B(i,j) = num2cell(A(i,j));
    end;
end;   
cell2csv('in_file.dat',B,',');
%csvwrite('in_file.dat',B);
end
