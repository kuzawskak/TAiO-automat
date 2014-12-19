function macierz_przejsc = generuj_automat(liczba_symboli, dyskretyzacja)
% GENERUJ_AUTOMAT losuje 3-wymiarow¹ macierz funkcji przejscia dla
% automatow determistycznego i niedetermistycznego

global rodzaj_automatu;
global ograniczenie_automatu_niedet;

liczba_podzialow = dyskretyzacja;
macierz_przejsc = zeros(liczba_symboli, liczba_symboli, liczba_podzialow);
ograniczenie=ceil((ograniczenie_automatu_niedet*liczba_symboli)/100);
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
        p = randi(ograniczenie + 1);
        r = randperm(liczba_symboli, p);
        for k = 1 : p
            macierz_przejsc(r(k), j, i) = 1;
        end
    end
  end  
elseif(rodzaj_automatu == 3) % Rozmyty
    macierz_przejsc = rand(liczba_symboli, liczba_symboli, liczba_podzialow);
end

end






