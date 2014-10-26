function macierz_przejsc= generuj_automat(liczba_symboli,liczba_podzialow)

% GENERUJ_AUTOMAT - losowanie funkcji przejscia automatu
macierz_przejsc = zeros(liczba_symboli,liczba_symboli,liczba_podzialow);

for i = 1 : liczba_podzialow
    for j = 1 : liczba_symboli
        r = randi(liczba_symboli);
        for k = 1 : liczba_symboli;
            if(k == r)
                macierz_przejsc(k,j,i) = 1;
            else
                macierz_przejsc(k,j,i) = 0;
            end
        end
    end
end

end






