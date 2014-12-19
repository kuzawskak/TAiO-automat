function blad = funkcja_bledu(wektor_z_macierzy3d)

% Macierz funkcji jest 3-wymiarowa, wygenerowana wczesniej przez funkcje
%'generuj automat' Zbior uczacy wygenerowany wczesniej przez funkcje
%'stworz_zbior_uczacy' Liczba symboli(=liczba wierszy) i Liczba kopii
%potrzebna do funkcji znajdz_symbol
global dyskretyzacja;
global liczba_wierszy;
global zbior_uczacy;
global liczba_kopii;
global liczba_st_odrzucajacych;
blad = 0;
%zamien wektor na macierz 3-wymiarowa
macierz = reshape(wektor_z_macierzy3d, liczba_wierszy, liczba_wierszy, dyskretyzacja);
macierz = generuj_macierz(macierz);

%iterujemy po wszystkich wektorach ze zbioru uczacego
for i = 1 : size(zbior_uczacy, 1)
    x = znajdz_symbol(i, liczba_wierszy - liczba_st_odrzucajacych, liczba_kopii);
    wynik = symulacja_automatu(zbior_uczacy(i, :), macierz);
    %sprawdzamy czy wynik automatu jest prawidlowy, poprzez sprawdzenie czy
    %na x-tym miejscu w wektorze "wynik" znajduje siê 1 i jesli nie, to zwiekszamy blad
    if(x ~= -1 && wynik(x) == 1)
        continue;
    elseif(x ~= -1 && isempty(find(wynik)) == 1)
        blad = blad + 1;
    elseif (x ~= -1 && znajdz_symbol_obcy(wynik) == 1)
        blad = blad + 2;
    elseif(x ~= -1 && wynik(x) ~= 1)
        blad = blad + 1;
    elseif (x == -1 && znajdz_symbol_obcy(wynik) ~= 1)
        blad = blad + 1;
    end
end

end