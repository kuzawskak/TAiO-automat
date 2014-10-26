function blad = uzyj_zbioru_testowego(ilosc_elem, macierz_przejsc, wektor_symboli)
%UZYJ_ZBIORU_TESTOWEGO funkcja uzywa zbudowanego automatu do testowania
%symboli ze zbioru testowego(=wylosowanych wartosci ze zbioru uczacego)

global zbior_uczacy
global liczba_kopii
global liczba_wierszy

blad=0;
tmp_wektor = randperm(size(zbior_uczacy,1),ilosc_elem);

for i = 1 : ilosc_elem,
    x = znajdz_symbol( tmp_wektor(i),liczba_wierszy,liczba_kopii);
    disp(sprintf('%d Testowano symbol: %c',i, wektor_symboli(x)))
    wynik = symulacja_automatu( zbior_uczacy(tmp_wektor(i),:), macierz_przejsc );
    disp(sprintf('Otrzymano symbol: %c',  wektor_symboli(wynik)))
    if(x ~= wynik)
        blad = blad + 1;
    end
end

end

