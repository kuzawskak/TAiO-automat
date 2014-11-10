function macierz_przejsc = generuj_automat(liczba_symboli, liczba_podzialow)

% GENERUJ_AUTOMAT - losowanie funkcji przejscia automatow determistycznego
% i niedetermistycznego
global czy_niedet;
global ograniczenie_automatu_niedet;

macierz_przejsc = zeros(liczba_symboli, liczba_symboli, liczba_podzialow);

if(czy_niedet == -1)
for i = 1 : liczba_podzialow
    for j = 1 : liczba_symboli
        r = randi(liczba_symboli);
        macierz_przejsc(r,j,i)=1;
    end
end
else
  for i = 1 : liczba_podzialow
    for j = 1 : liczba_symboli
        p = randi(ograniczenie_automatu_niedet + 1) - 1;
        r = randperm(liczba_symboli, p);
        for k = 1 : p
            macierz_przejsc(r(k), j, i) = 1;
        end
    end
  end  
end

end






