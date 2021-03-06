function blad = funkcja_bledu_rozmyty(wektor_z_macierzy3d)
  
% FUNKCJA_BLEDU_ROZMYTY wykorzystywana jest przez PSO w celu obliczenia bledu dla
% kazdej iteracji 
% Macierz funkcji jest 3-wymiarowa, wygenerowana wczesniej przez funkcje
%'generuj automat' Zbior uczacy wygenerowany wczesniej przez funkcje
%'stworz_zbior_uczacy' Liczba symboli i Liczba kopii potrzebna do funkcji 
% znajdz_symbol

global dyskretyzacja;
global liczba_wierszy;
global zbior_uczacy;
global liczba_kopii;
global liczba_st_odrzucajacych;
blad = 0;

liczba_stron=dyskretyzacja;
%zamien wektor na macierz 3-wymiarowa
macierz = reshape(wektor_z_macierzy3d, liczba_wierszy, liczba_wierszy, liczba_stron);  
macierz = generuj_macierz(macierz);

%iterujemy po wszystkich wektorach ze zbioru uczacego
for i = 1 : size(zbior_uczacy, 1)
        
    % x to symbol ktory powinien wyjsc jako wynik
    x = znajdz_symbol(i, liczba_wierszy - liczba_st_odrzucajacych, liczba_kopii) ;   
    wynik = symulacja_automatu_rozmytego(zbior_uczacy(i, :), macierz);
    roznice = zeros(length(wynik));
    %sprawdzamy czy wynik automatu jest prawidlowy, poprzez sprawdzenie czy 
    %na x-tym miejscu w wektorze "wynik" znajduje si� 1 i jesli nie, to zwiekszamy blad 
    if(x~=-1)     
        x_wektor=zeros(length(wynik),1);
        x_wektor(x)=1;        
            %stosuje 2. funkcje bledu z notatek
            roznice=abs(wynik-x_wektor); 
            blad = blad+sum(roznice,1);  
        
    else %%% obcy x==-1
        blad = blad + 1;
    end
      
end

end