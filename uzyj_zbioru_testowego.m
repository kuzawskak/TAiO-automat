function [blad, wiadomosc] = uzyj_zbioru_testowego(ilosc_elem, macierz_przejsc, wektor_symboli)
%UZYJ_ZBIORU_TESTOWEGO funkcja uzywa zbudowanego automatu do testowania
%symboli ze zbioru testowego(=wylosowanych wartosci ze zbioru uczacego)

global zbior_uczacy
global liczba_kopii
global liczba_wierszy
global liczba_st_odrzucajacych
global czy_odrzucanie

blad = 0;
wiadomosc = cell(ilosc_elem + 4, 1);
tmp_wektor = randperm(size(zbior_uczacy, 1), ilosc_elem);

for i = 1 : ilosc_elem,
    x = znajdz_symbol(tmp_wektor(i), liczba_wierszy-liczba_st_odrzucajacych, liczba_kopii);
    wynik = symulacja_automatu(zbior_uczacy(tmp_wektor(i), :), macierz_przejsc);
    if(x ~= -1)
        fprintf(sprintf('%d Testowano symbol: %c ', i, wektor_symboli(x)));
    else
        fprintf(sprintf('%d Testowano symbol: obcy ', i));
    end
    
    if(x ~= -1 && wynik(x) == 1)
        fprintf(sprintf('Otrzymano symbol: %c ', wektor_symboli(x)));
    elseif (czy_odrzucanie == 0 && znajdz_symbol_obcy(wynik) == 1) 
        fprintf(sprintf('Otrzymano symbol: odrzucony '));
    elseif(x ~= -1 && isempty(find(wynik)) == 1)
        fprintf(sprintf('Otrzymano symbol: nieznany '));
    elseif(x ~= -1 && wynik(x) ~= 1)
        fprintf(sprintf('Otrzymano symbol: %c ', wektor_symboli(find(wynik))));
    elseif(x == -1)
        fprintf(sprintf('Otrzymano symbol: %c ', wektor_symboli(find(wynik))));
    end  
    
    if(x ~= -1 && znajdz_symbol_obcy(wynik) == 1)
        blad = blad + 1;
    elseif(x ~= -1 && isempty(find(wynik)) == 1)
        blad = blad + 1;
    elseif(x ~= -1 && wynik(x) ~= 1)
        blad = blad + 1;
    elseif(x == -1 && znajdz_symbol_obcy(wynik) ~= 1)
        blad = blad + 1;
    end
    
end

%    wiadomosc{i} = [num2str(i) ' Testowano symbol: ' wektor_symboli(x) ...
%        ' Otrzymano symbol: ' wektor_symboli(find(wynik))];        
%         if(znajdz_symbol_obcy(wynik)==1)
%          wiadomosc{i} = [num2str(i) ' Testowano symbol obcy ' ...
%         ' Otrzymano symbol: obcy'];
%         else
%             wiadomosc{i} = [num2str(i) ' Testowano symbol obcy ' ...
%        ' Otrzymano symbol: ' wektor_symboli(find(wynik))];
% 
%         end

end