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
        macierz_przejsc(r, j, i) = 1;
    end
end
else
  for i = 1 : liczba_podzialow
    for j = 1 : liczba_symboli
        p = randi(ograniczenie_automatu_niedet + 1) - 1;
        prob = [0.3, 0.3, 0.2, 0.2];
        x = sum(p >= cumsum([0, prob]));
        r = randperm(liczba_symboli, x);
        for k = 1 : x
            macierz_przejsc(r(k), j, i) = 1;
        end
    end
  end  
end

end






