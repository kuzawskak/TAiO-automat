function[] = test_skrypt(varargin)

global a;
global liczba_stron;
global liczba_wierszy;
global zbior_uczacy;
global liczba_kopii;
global czy_niedet;
global ograniczenie_automatu_niedet;
global liczba_st_odrzucajacych;
global czy_odrzucanie;

%Pobranie wartoœci z GUI
handles = guidata(gcf);

%Przypisanie wartoœci

%to trzeba zczytaæ z gui
czy_niedet = 0;

%to trzeba tez zczytaæ z gui
czy_odrzucanie = 0;

if(czy_odrzucanie == 0)
    liczba_st_odrzucajacych = str2double(get(handles.odrzucajace, 'String'));
else
    liczba_st_odrzucajacych = 0;
end
ograniczenie_automatu_niedet = str2double(get(handles.ograniczenie, 'String'));
max_wartosc = str2double(get(handles.max, 'String'));
srednia = str2double(get(handles.srednia, 'String'));
wariancja = str2double(get(handles.wariancja, 'String'));
liczba_kopii = str2double(get(handles.kopie, 'String'));
liczba_cech = str2double(get(handles.cechy, 'String'));
liczba_symboli = str2double(get(handles.symbole, 'String'));
liczba_iteracji = str2double(get(handles.iteracje, 'String'));
liczba_rojow = str2double(get(handles.roje, 'String'));
liczba_symboli_testowych = str2double(get(handles.symbole_testowe, 'String'));

plik_wejsciowy = 'plik_wejsciowy.dat';

if(ograniczenie_automatu_niedet > liczba_symboli+liczba_st_odrzucajacych)
   msgbox('Ograniczenie dla automatu niedeterministycznego nie mo¿e byæ wiêksze ni¿ liczba klas symboli.');
   return;
end

%start mierzenia czasu
tic
disp('Rozpoczynam prace, prosze czekac...');
%generujemy swoj plik csv
generuj_csv(liczba_symboli, liczba_cech, max_wartosc, plik_wejsciowy);

%zmapowane symbole zapisane w jednym wektorze
wszystkie_symbole = mapowanie_symboli(plik_wejsciowy, liczba_symboli);

%przygotowanie gotowego zbior uczacego do uzycia w automacie
zbior_uczacy = stworz_zbior_uczacy(plik_wejsciowy, liczba_symboli, ...
    liczba_cech, liczba_kopii, srednia, wariancja );

%GENERUJAMY AUTOMAT - w postaci tabeli funkcji przejscia

automat = generuj_automat(liczba_symboli+liczba_st_odrzucajacych, liczba_cech);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = 100;
%mac_przejsc = permute(reshape(automat, liczba_symboli * liczba_symboli * liczba_cech, 1, 1), [2 1])
f_handler = @funkcja_bledu;
liczba_stron = liczba_cech;
liczba_wierszy = liczba_symboli+liczba_st_odrzucajacych;

%Pobierz opcje PSO
opcje = PSO('options');
opcje.npart = liczba_rojow;
opcje.niter = liczba_iteracji;

[xopt, fopt] = PSO(f_handler, liczba_wierszy * liczba_wierszy * liczba_cech, opcje);

macierz_z_pso = reshape(xopt, liczba_wierszy, liczba_wierszy, liczba_stron);

if(czy_niedet == -1)
  for i = 1 : liczba_stron
      for j = 1 : liczba_wierszy
          maxx = max(macierz_z_pso(:, j, i));
          for k = 1 : liczba_wierszy
              if(macierz_z_pso(k, j, i) == maxx)
                  macierz_z_pso(k, j, i) = 1;
              else
                  macierz_z_pso(k, j, i) = 0;
              end
          end
      end
  end
  else
  for i = 1 : liczba_stron
      for j = 1 : liczba_wierszy
          p = randi(ograniczenie_automatu_niedet + 1) - 1;
          [sortedX, sortingIndices] = sort(macierz_z_pso(:, j, i), 'descend');
          sortingIndices = sortingIndices(1 : p);
          for k = 1 : liczba_wierszy
              if(any(sortingIndices == k) == 1)
                  macierz_z_pso(k, j, i) = 1;
              else
                  macierz_z_pso(k, j, i) = 0;
              end
          end
      end
  end   
end
 
c_blad = 0;
for i = 1 : size(zbior_uczacy, 1)
    wynik = symulacja_automatu(zbior_uczacy(i, :), macierz_z_pso);
    wynik2 = znajdz_symbol(i, liczba_wierszy-liczba_st_odrzucajacych, liczba_kopii);
    
    %sprawdzamy czy wynik automatu jest prawidlowy, poprzez sprawdzenie czy 
    %na x-tym miejscu w wektorze "wynik" znajduje siê 1 i jesli nie, to zwiekszamy blad 
    if (wynik2~=-1 && znajdz_symbol_obcy(wynik)==1)
        c_blad=c_blad + 1;
    elseif(wynik2~=-1 && wynik(wynik2) ~= 1)
        c_blad = c_blad + 1;
    elseif (wynik2==-1 && znajdz_symbol_obcy( wynik ) ~= 1)
        c_blad = c_blad + 1;  
    end
end


blad = c_blad / size(zbior_uczacy, 1);
disp(sprintf('Blad calkowity obliczen dla zbioru uczacego: %f', blad))   

[blad2, wiadomosc] = uzyj_zbioru_testowego(liczba_symboli_testowych, macierz_z_pso, ...
    wszystkie_symbole);
blad2 = blad2 / liczba_symboli_testowych;
disp(sprintf('Blad calkowity obliczen dla zbioru testowego: %f', blad2))  

%koniec mierzenia czasu
disp('Ca³kowity czas obliczeñ:');
czas = toc
wiadomosc{liczba_symboli_testowych + 2} = ['B³¹d ca³kowity: ', num2str(blad)];
wiadomosc{liczba_symboli_testowych + 3} = ['Blad calkowity obliczen dla zbioru testowego: ', num2str(blad2)];
wiadomosc{liczba_symboli_testowych + 4} = ['Ca³kowity czas obliczeñ: ', num2str(czas)];

%msgbox(wiadomosc);

end