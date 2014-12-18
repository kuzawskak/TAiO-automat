function [blad, wektor_wynikowy] = uzyj_zbioru_testowego(ilosc_elem, macierz_przejsc, wektor_symboli)
%UZYJ_ZBIORU_TESTOWEGO funkcja uzywa zbudowanego automatu do testowania
%symboli ze zbioru testowego(=wylosowanych wartosci ze zbioru uczacego)

global zbior_uczacy
global liczba_kopii
global liczba_wierszy
global liczba_st_odrzucajacych
global czy_odrzucanie
global rodzaj_automatu;
global sciezka_zbior_testujacy;
global sciezka_obce_zbior_testujacy;

wektor_wynikowy=zeros(ilosc_elem,1);
blad = 0;
if(sciezka_zbior_testujacy~='_')
    [zbior_testujacy, a, wektor_symboli] =czytaj_plik_excel(sciezka_zbior_testujacy);
    
    if(sciezka_obce_zbior_testujacy~='_')
        [zbior_obcych,str]=xlsread(sciezka_obce_zbior_testujacy);
        zbior_testujacy=vertcat(zbior_uczacy,zbior_obcych);
    end
    
    for i=1:size(zbior_testujacy,1)
        x = znajdz_symbol(i, length(wektor_symboli), a);
        if(rodzaj_automatu==3)
            wynik = symulacja_automatu_rozmytego(zbior_testujacy(i,:), macierz_przejsc);
        else
            wynik=symulacja_automatu(zbior_testujacy(i,:), macierz_przejsc);
        end
        
        if(x ~= -1)
            fprintf(sprintf('%d Testowano symbol: %c ', i, wektor_symboli(x)));
        else
            fprintf(sprintf('%d Testowano symbol: obcy ', i));
        end
        
        if(x ~= -1 && wynik(x) == 1)
            fprintf(sprintf('Otrzymano symbol: %c ', wektor_symboli(x)));
            wektor_wynikowy(i)=wektor_symboli(x)
        elseif (czy_odrzucanie == 0 && znajdz_symbol_obcy(wynik) == 1)
            fprintf(sprintf('Otrzymano symbol: odrzucony '));
            wektor_wynikowy(i)= -1;
        elseif(x ~= -1 && isempty(find(wynik, 1)) == 1)
            fprintf(sprintf('Otrzymano symbol: nieznany '));
            wektor_wynikowy(i)= -1;
        elseif(x ~= -1 && wynik(x) ~= 1)
            otrzymane_symbole = find(wynik, length(wektor_symboli));
            fprintf('Otrzymano symbol: ');
            for j = 1 : length(otrzymane_symbole)
                fprintf(sprintf('%c ', wektor_symboli(j)));
            end
            wektor_wynikowy(i)=pojedyncza_wartosc(otrzymane_symbole);
        elseif(x == -1)
            otrzymane_symbole = find(wynik, length(wektor_symboli));
            fprintf('Otrzymano symbol: ');
            for j = 1 : length(otrzymane_symbole)
                fprintf(sprintf('%c ', wektor_symboli(j)));
            end
            wektor_wynikowy(i)=pojedyncza_wartosc(otrzymane_symbole);
        end
        
        if(x ~= -1 && znajdz_symbol_obcy(wynik) == 1)
            blad = blad + 1;
        elseif(x ~= -1 && isempty(find(wynik, 1)) == 1)
            blad = blad + 1;
        elseif(x ~= -1 && wynik(x) ~= 1)
            blad = blad + 1;
        elseif(x == -1 && znajdz_symbol_obcy(wynik) ~= 1)
            blad = blad + 1;
        end
    end
else
    tmp_wektor = randperm(size(zbior_uczacy, 1), ilosc_elem);
    
    for i = 1 : ilosc_elem,
        x = znajdz_symbol(tmp_wektor(i), liczba_wierszy-liczba_st_odrzucajacych, liczba_kopii);
        if(rodzaj_automatu==3)
            wynik = symulacja_automatu_rozmytego(zbior_uczacy(tmp_wektor(i), :), macierz_przejsc);
        else wynik=symulacja_automatu(zbior_uczacy(tmp_wektor(i), :), macierz_przejsc);
        end
        if(x ~= -1)
            fprintf(sprintf('%d Testowano symbol: %c ', i, wektor_symboli(x)));
        else
            fprintf(sprintf('%d Testowano symbol: obcy ', i));
        end
        
        if(x ~= -1 && wynik(x) == 1)
            fprintf(sprintf('Otrzymano symbol: %c ', wektor_symboli(x)));
            wektor_wynikowy(i)=wektor_symboli(x)
        elseif (czy_odrzucanie == 0 && znajdz_symbol_obcy(wynik) == 1)
            fprintf(sprintf('Otrzymano symbol: odrzucony '));
            wektor_wynikowy(i)= -1;
        elseif(x ~= -1 && isempty(find(wynik, 1)) == 1)
            fprintf(sprintf('Otrzymano symbol: nieznany '));
            wektor_wynikowy(i)= -1;
        elseif(x ~= -1 && wynik(x) ~= 1)
            otrzymane_symbole = find(wynik, length(wektor_symboli));
            fprintf('Otrzymano symbol: ');
            for j = 1 : length(otrzymane_symbole)
                fprintf(sprintf('%c ', wektor_symboli(j)));
            end
            wektor_wynikowy(i)=pojedyncza_wartosc(otrzymane_symbole);
        elseif(x == -1)
            otrzymane_symbole = find(wynik, length(wektor_symboli));
            fprintf('Otrzymano symbol: ');
            for j = 1 : length(otrzymane_symbole)
                fprintf(sprintf('%c ', wektor_symboli(j)));
            end
            wektor_wynikowy(i)=pojedyncza_wartosc(otrzymane_symbole);
        end
        
        if(x ~= -1 && znajdz_symbol_obcy(wynik) == 1)
            blad = blad + 1;
        elseif(x ~= -1 && isempty(find(wynik, 1)) == 1)
            blad = blad + 1;
        elseif(x ~= -1 && wynik(x) ~= 1)
            blad = blad + 1;
        elseif(x == -1 && znajdz_symbol_obcy(wynik) ~= 1)
            blad = blad + 1;
        end
        
    end
    
end

end

function wartosc = pojedyncza_wartosc(wektor_wartosci)

indeksy=find(wektor_wartosci);
r=randi(length(indeksy) + 1) - 1;
wartosc=wektor_wartosci(indeksy(r));

end