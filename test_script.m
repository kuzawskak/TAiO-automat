%%%%%%%%%!!TZREBA ZADEKLAROWAC ZMIENNA GLOBALNA tutaj i w pliku funkcji
%%%%%%%%%bledu
global a;
 global liczba_stron;
  global liczba_wierszy;
  global liczba_kolumn;
  global zbior_uczacy;
%skrypt testowy z podanymi z góry wartosciami 
liczba_cech = 5;
liczba_symboli = 10;
liczba_kopii=100;
max_value = 20;

   


%generujemy swoj plik csv
generate_csv(liczba_symboli,liczba_cech,max_value);

%zmapowane symbole zapisane w jednym wektorze
wszystkie_symbole=mapowanie_symboli( 'in_file.dat', liczba_symboli );

%przygotowanie gotowego zbior uczacego do uzycia w automacie
zbior_uczacy=prepare_training_dataset('in_file.dat', liczba_symboli, liczba_cech, 5,liczba_kopii);

%GENERUJAMY  AUTOMAT - w postaci tabeli funkcji przejscia
automat = generate_automat(liczba_symboli,5);

%wykonujemy symulacje pracy automatu dla pierwszego wektora ze zbioru
%uczacego
x=find_symbol(151,liczba_symboli,liczba_kopii);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  a = 100;
  f_handler = @func_bledu;
liczba_stron = liczba_cech;
liczba_wierszy = liczba_symboli;

liczba_kolumn = liczba_symboli;
matrix_as_vector = permute(reshape(automat,liczba_symboli*liczba_symboli*liczba_cech,1,1),[2 1]);
  [xopt, fopt] = pso(f_handler,500);%%liczba_symboli*liczba_symboli*liczba_cech );
%  l = func_bledu(5);
 xopt
 %normalizacja
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
disp('testowany symbol:');
wszystkie_symbole(x)

wynik=automat_simulation( zbior_uczacy(151,:), automat );

%symbol jak otrzymalismy po zakonczeniu pracy automatu
symbol=wszystkie_symbole(wynik)

% NA TEJ ZASADZIE BEDZIE TRZEBA W FUNKCJI BLEDU DAWAC '0' LUB '1'
if(x==wynik)
    disp('ZGADZA SIE');
else
    disp('NIE ZGADZA SIE');
end





