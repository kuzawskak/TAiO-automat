  function blad = funkcja_bledu(matrix_as_vector)
  
% Macierz funkcji jest 3-wymiarowa, wygenerowana wczesniej przez funkcje
%'generate automat' Zbior uczacy wygenerowany wczesniej przez funkcje
%'prepare_training_dataset Liczba symboli(=liczba wierszy) i Liczba kopii potrzebna do funkcji find_symbol
  global liczba_stron;
  global liczba_wierszy;
  global zbior_uczacy;
  global liczba_kopii;
  
  blad = 0;
  maxx=0;
  wynik=0;
  
  %zamien wektor na macierz 3-wymiarowa
  matrix = reshape(matrix_as_vector,liczba_wierszy,liczba_wierszy,liczba_stron);
  
  for i=1:liczba_stron
      for j=1:liczba_wierszy
          maxx=max(matrix(:,j,i));
          for k=1:liczba_wierszy
              if(matrix(k,j,i)==maxx)
                  matrix(k,j,i)=1;
              else
                  matrix(k,j,i)=0;
              end
          end
      end
  end

%iterujemy po wszystkich wektorach ze zbioru uczacego
for i=1:size(zbior_uczacy,1)
    x=find_symbol(i,liczba_wierszy,liczba_kopii);
    wynik=automat_simulation( zbior_uczacy(i,:), matrix );
    %sprawdzamy czy wynik automatu jest prawidlowy, jesli nie, to zwiekszamy blad 
    if(x~=wynik)
        blad=blad+1;
    end
end

end