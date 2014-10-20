%Macierz funkcji jest 3-wymiarowa, wygenerowana wczesniej przez funkcje
%'generate automat' Zbior uczacy wygenerowany wczesniej przez funkcje
%'prepare_training_dataset Liczba symboli i Liczba kopii potrzebna do funkcji find_symbol

function blad = funkcja_bledu(macierz_funkcji, zbior_uczacy, liczba_symboli, liczba_kopii)

blad = 0;
wynik=0;

%iterujemy po wszystkich wektorach ze zbioru uczacego

for i=1:size(zbior_uczacy,2)
    x=find_symbol(i,liczba_symboli,liczba_kopii);
    wynik=automat_simulation( zbior_uczacy(i,:), macierz_funkcji );
    %sprawdzamy czy wynik automatu jest prawidlowy, jesli nie, to zwiekszamy blad 
    if(x~=wynik)
        blad=blad+1;
    end
end


end



