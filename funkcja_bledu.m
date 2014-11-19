  function blad = funkcja_bledu(wektor_z_macierzy3d)
  
% Macierz funkcji jest 3-wymiarowa, wygenerowana wczesniej przez funkcje
%'generuj automat' Zbior uczacy wygenerowany wczesniej przez funkcje
%'stworz_zbior_uczacy' Liczba symboli(=liczba wierszy) i Liczba kopii 
%potrzebna do funkcji znajdz_symbol
  global liczba_stron;
  global liczba_wierszy;
  global zbior_uczacy;
  global liczba_kopii;
  global czy_niedet;
  global ograniczenie_automatu_niedet;
  global liczba_st_odrzucajacych;
  blad = 0;
  
  %zamien wektor na macierz 3-wymiarowa
  macierz = reshape(wektor_z_macierzy3d, liczba_wierszy, liczba_wierszy, liczba_stron);
  
  if(czy_niedet == -1)
  for i = 1 : liczba_stron
      for j = 1 : liczba_wierszy 
          maxx = max(macierz(:, j, i));
          for k = 1 : liczba_wierszy 
              if(macierz(k, j, i) == maxx)
                  macierz(k, j, i) = 1;
              else
                  macierz(k, j, i) = 0;
              end
          end
      end
  end
  else
  for i = 1 : liczba_stron
      for j = 1 : liczba_wierszy 
          p = randi(ograniczenie_automatu_niedet + 1) - 1;
          [sortedX, sortingIndices] = sort(macierz(:, j, i), 'descend');
          sortingIndices = sortingIndices(1 : p);
          for k = 1 : liczba_wierszy 
              if(any(sortingIndices == k) == 1)
                  macierz(k, j, i) = 1;
              else
                  macierz(k, j, i) = 0;
              end
          end
      end
  end   
  end
  
%iterujemy po wszystkich wektorach ze zbioru uczacego
for i = 1 : size(zbior_uczacy, 1)
    x = znajdz_symbol(i, liczba_wierszy-liczba_st_odrzucajacych, liczba_kopii);
    wynik = symulacja_automatu(zbior_uczacy(i, :), macierz);
    %sprawdzamy czy wynik automatu jest prawidlowy, poprzez sprawdzenie czy 
    %na x-tym miejscu w wektorze "wynik" znajduje siê 1 i jesli nie, to zwiekszamy blad 
    if (x~=-1 && znajdz_symbol_obcy(wynik)==1)
        blad=blad+2;
    elseif(x~=-1 && wynik(x) ~= 1)
        blad = blad + 1;
    elseif (x==-1 && znajdz_symbol_obcy( wynik ) ~= 1)
        blad = blad + 1;    
    end
    
end

end