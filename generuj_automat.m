function macierz_przejsc = generuj_automat(liczba_symboli, liczba_podzialow)

% GENERUJ_AUTOMAT - losowanie funkcji przejscia automatow determistycznego
% i niedetermistycznego
global rodzaj_automatu;
global ograniczenie_automatu_niedet;

macierz_przejsc = zeros(liczba_symboli, liczba_symboli, liczba_podzialow);

if(rodzaj_automatu == 1) % Deterministyczny
for i = 1 : liczba_podzialow
    for j = 1 : liczba_symboli
        r = randi(liczba_symboli);
        macierz_przejsc(r, j, i) = 1;
    end
end
elseif(rodzaj_automatu == 2) % Niedeterministyczny
  for i = 1 : liczba_podzialow
    for j = 1 : liczba_symboli
        p = randi(ograniczenie_automatu_niedet + 1) - 1;
        prob = [0.2, 0.4, 0.2, 0.2];
        x = sum(p >= cumsum([0, prob]));
        r = randperm(liczba_symboli, x);
        for k = 1 : x
            macierz_przejsc(r(k), j, i) = 1;
        end
    end
  end  
elseif(rodzaj_automatu == 3) % Rozmyty
    macierz_przejsc = rand(liczba_symboli, liczba_symboli, liczba_podzialow);
end

end






