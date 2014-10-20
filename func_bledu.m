%%%%%%funkcja od bledu od czapy - pokazuje tylko jak poslugiwac sie zmienna
%%%%%%globalna zeby dziala
  function blad = func_bledu(matrix_as_vector)
  global liczba_stron;
  global liczba_wierszy;
  global liczba_kolumn;
  global zbior_uczacy;
  
  blad = 0;
  
  %zamien wektor na macierz 3-wymiarowa
  matrix = reshape(matrix_as_vector,10,10,5);%%liczba_wierszy,liczba_kolumn,liczba_stron);
  
  blad = funkcja_bledu(matrix, zbior_uczacy,liczba_wierszy,100);
  
  
  end



  
  

