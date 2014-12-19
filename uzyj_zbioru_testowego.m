function [blad, wektor_wynikowy] = uzyj_zbioru_testowego(ilosc_elem, macierz_przejsc, wektor_symboli)
%UZYJ_ZBIORU_TESTOWEGO uzywa zbudowanego automatu do testowania
%symboli ze zbioru testowego(=wylosowanych wartosci ze zbioru uczacego)
%Dla ka¿dego wektora ze zbioru odbywa siê symaluacja automatu i odpowiednio
%zwiêksza siê b³¹d.
%Funkcja zwraca ca³kowity b³¹d bêd¹cy stosunkiem b³ednie rozpoznanych
%symboli do wszystkich symboli, a tak¿e wektor wynikowy zawieraj¹cy
%rozpoznane symbole - u¿ywamy go do zapisania wyników w pliku Excela.

global zbior_uczacy
global liczba_kopii
global liczba_wierszy
global liczba_st_odrzucajacych
global czy_odrzucanie
global rodzaj_automatu;
global sciezka_zbior_testujacy;
global sciezka_obce_zbior_testujacy;

wektor_wynikowy=char(ilosc_elem,1);
blad = 0;
if(sciezka_zbior_testujacy{1}~='_')
    [zbior_testujacy, a, b] =czytaj_plik_excel(sciezka_zbior_testujacy,1);
    
    if(sciezka_obce_zbior_testujacy~='_')
        [zbior_obcych,str]=xlsread(sciezka_obce_zbior_testujacy{1});
        zbior_testujacy=vertcat(zbior_uczacy,zbior_obcych);
    end
    
    for i=1:size(zbior_testujacy,1)
        x = znajdz_symbol(i, length(wektor_symboli), a);
        if(rodzaj_automatu==3)
            wynik = symulacja_automatu_rozmytego(zbior_testujacy(i,:), macierz_przejsc);
        else
            wynik=symulacja_automatu(zbior_testujacy(i,:), macierz_przejsc);
        end
        
        if(x ~= -1 && wynik(x) == 1)
            wektor_wynikowy(i)=wektor_symboli(x);
        elseif(x ~= -1 && isempty(find(wynik)) == 1)
            wektor_wynikowy(i)= '-';
        elseif(x ~= -1 && wynik(x) ~= 1)
            f=find(wynik);
            r=randi(length(f));
            wektor_wynikowy(i)=wektor_symboli(f(r));
        elseif (czy_odrzucanie == 0 && znajdz_symbol_obcy(wynik) == 1)
            wektor_wynikowy(i)= '-';
        elseif(x == -1)
            f=find(wynik);
            r=randi(length(f));
            wektor_wynikowy(i)=wektor_symboli(f(r));
        end
        
        if(x ~= -1 && wynik(x) == 1)
            continue;
        elseif(x ~= -1 && znajdz_symbol_obcy(wynik) == 1)
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
        else
            wynik=symulacja_automatu(zbior_uczacy(tmp_wektor(i), :), macierz_przejsc);
        end
        
        if(x ~= -1 && wynik(x) == 1)
            wektor_wynikowy(i)=wektor_symboli(x);
        elseif(x ~= -1 && isempty(find(wynik)) == 1)
            wektor_wynikowy(i)= '-';
        elseif(x ~= -1 && wynik(x) ~= 1)
            f=find(wynik);
            r=randi(length(f));
            wektor_wynikowy(i)=wektor_symboli(f(r));
        elseif (czy_odrzucanie == 0 && znajdz_symbol_obcy(wynik) == 1)
            wektor_wynikowy(i)= '-';
        elseif(x == -1)
            f=find(wynik);
            r=randi(length(f));
            wektor_wynikowy(i)=wektor_symboli(f(r));
        end
        
        if(x ~= -1 && wynik(x) == 1)
            continue;
        elseif(x ~= -1 && znajdz_symbol_obcy(wynik) == 1)
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