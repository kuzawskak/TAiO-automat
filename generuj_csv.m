function [] = generuj_csv(l_symboli, l_cech, max_wartosc, plik_wejsciowy)

% GENERUJ_CSV - generowanie pliku csv z lsoowymi wartosciami cech
% zakladamy ze mamy litery a, b , c, d ... w zaleznosci od l_sym
% max_wartosc - wartosc maksymalna dla wartosci cechy
% cechy beda losowane z przedzialu od 0 do max_wartosc

A = rand(l_symboli, l_cech + 1) * (max_wartosc + 1);
A = uint16(A);

for i = 1 : l_symboli
    B(i, 1) =num2cell(char(96 + i));
end;

for i = 1 : l_symboli
    for j = 2 : l_cech+1
          B(i, j) = num2cell(A(i, j));
    end;
end;   

cell2csv(plik_wejsciowy, B, ',');

end
