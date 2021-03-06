function [zbior_uczacy, liczba_kopii, wszystkie_symbole] =  czytaj_plik_excel(sciezka_plik)
%CZYTAJ_PLIK_EXCEL Funkcja parsuje plik excela, wydobywa informacje o
%liczbie kopii i tworzy wektor wszystkich symboli potrzenych do testowania
%automatu

[zbior_uczacy,str]=xlsread(sciezka_plik{1});

%pierwsza kolumna
str=char(str);

%obliczanie liczby kopii
liczba_kopii = 0;
while(str(liczba_kopii+1) == str(1))
    liczba_kopii = liczba_kopii + 1;
end
[y,i] = unique(str);
wszystkie_symbole = str(sort(i));
end
