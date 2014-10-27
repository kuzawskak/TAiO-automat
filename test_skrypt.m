function[] = test_skrypt(varargin)

global a;
global liczba_stron;
global liczba_wierszy;
global zbior_uczacy;
global liczba_kopii;

%Pobranie wartoœci z GUI
handles = guidata(gcf);

%Przypisanie wartoœci
liczba_cech = str2double(get(handles.cechy,'String'));
liczba_symboli = str2double(get(handles.symbole,'String'));
liczba_kopii = str2double(get(handles.kopie,'String'));
max_wartosc = str2double(get(handles.max,'String'));
liczba_iteracji = str2double(get(handles.iteracje,'String'));
liczba_rojow = str2double(get(handles.roje,'String'));

srednia = 0;
wariancja = 3;
liczba_symboli_testowych = 10;

plik_wejsciowy = 'plik_wejsciowy.dat';

%start mierzenia czasu
tic
%generujemy swoj plik csv
generuj_csv(liczba_symboli, liczba_cech, max_wartosc, plik_wejsciowy);

%zmapowane symbole zapisane w jednym wektorze
wszystkie_symbole = mapowanie_symboli(plik_wejsciowy, liczba_symboli);

%przygotowanie gotowego zbior uczacego do uzycia w automacie
zbior_uczacy = stworz_zbior_uczacy(plik_wejsciowy, liczba_symboli, ...
    liczba_cech, liczba_kopii, srednia, wariancja );

%GENERUJAMY AUTOMAT - w postaci tabeli funkcji przejscia
automat = generuj_automat(liczba_symboli, liczba_cech);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = 100;
f_handler = @funkcja_bledu;
liczba_stron = liczba_cech;
liczba_wierszy = liczba_symboli;

%Pobierz opcje PSO
opcje = PSO('options');
opcje.npart = liczba_rojow;
opcje.niter = liczba_iteracji;

[xopt, fopt] = PSO(f_handler, liczba_symboli * liczba_symboli * liczba_cech, opcje);

maxx = 0;
macierz_z_pso = reshape(xopt, liczba_wierszy, liczba_wierszy, liczba_stron);

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
  
c_blad = 0;
for i = 1 : size(zbior_uczacy, 1)
    wynik = symulacja_automatu(zbior_uczacy(i, :), macierz_z_pso);
    wynik2 = znajdz_symbol(i, liczba_symboli, liczba_kopii);
    if(wynik ~= wynik2)
        c_blad = c_blad + 1;
    end
end

blad = c_blad / size(zbior_uczacy, 1);
disp(sprintf('Blad calkowity obliczen dla zbioru uczacego: %f', blad))   

blad2 = uzyj_zbioru_testowego(liczba_symboli_testowych, macierz_z_pso, ...
    wszystkie_symbole) / liczba_symboli_testowych;
disp(sprintf('Blad calkowity obliczen dla zbioru testowego: %f', blad2))  

%koniec mierzenia czasu
toc

msgbox({'Operation' 'Completed'});

end