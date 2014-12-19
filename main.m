function[] = main()

global sciezka_plik_wynikowy;
global sciezka_zbior_uczacy;
global sciezka_plik_dodatkowy;
global rozmiar_zb_testowy;
global dyskretyzacja;
global liczba_rojow;
global liczba_iteracji;
global max_wartosc;
global min_wartosc;
global liczba_symboli;
global wariancja;
global zbior_uczacy;
global liczba_kopii;
global rodzaj_automatu;
global liczba_st_odrzucajacych;
global liczba_cech;
global typ_wejscia;
global a;
global liczba_wierszy;
%Przypisanie wartoœci
plik_wejsciowy = 'plik_wejsciowy.dat';
liczba_symboli_testowych=(rozmiar_zb_testowy*size(zbior_uczacy, 1))/100
srednia=0;

%start mierzenia czasu
tic
disp('Rozpoczynam prace, prosze czekac...');

if(typ_wejscia == -1)
    generuj_csv(liczba_symboli, liczba_cech,min_wartosc, max_wartosc, plik_wejsciowy);
    %zmapowane symbole zapisane w jednym wektorze
    wszystkie_symbole = mapowanie_symboli(plik_wejsciowy, liczba_symboli);
else
    [plik_wejsciowy, liczba_kopii, wszystkie_symbole]=czytaj_plik_excel(sciezka_zbior_uczacy);
    liczba_symboli=length(wszystkie_symbole);
    liczba_cech=size(plik_wejsciowy,2);
end


%przygotowanie gotowego zbior uczacego do uzycia w automacie
if(rodzaj_automatu==3)%rozmyty
    zbior_uczacy = stworz_rozmyty_zbior_uczacy(plik_wejsciowy, liczba_symboli, ...
        liczba_cech, liczba_kopii, dyskretyzacja, srednia, wariancja, typ_wejscia );
else
    zbior_uczacy = stworz_zbior_uczacy(plik_wejsciowy, liczba_symboli, ...
        liczba_cech, liczba_kopii, dyskretyzacja, srednia, wariancja, typ_wejscia );
end

%GENERUJAMY AUTOMAT - w postaci tabeli funkcji przejscia
generuj_automat(liczba_symboli + liczba_st_odrzucajacych, dyskretyzacja);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = 100;
%mac_przejsc = permute(reshape(automat, liczba_symboli * liczba_symboli * liczba_cech, 1, 1), [2 1])
if(rodzaj_automatu==3)%rozmyty
    f_handler = @funkcja_bledu_rozmyty;
    f_sym_automat = @symulacja_automatu_rozmytego;
else
    f_handler = @funkcja_bledu;
    f_sym_automat = @symulacja_automatu;
end

liczba_wierszy = liczba_symboli + liczba_st_odrzucajacych;

%Pobierz opcje PSO
opcje = PSO('options');
opcje.npart = liczba_rojow;
opcje.niter = liczba_iteracji;

[xopt, ~] = PSO(f_handler, liczba_wierszy * liczba_wierszy * dyskretyzacja, opcje);

macierz_z_pso = reshape(xopt, liczba_wierszy, liczba_wierszy, dyskretyzacja);
macierz_z_pso = generuj_macierz(macierz_z_pso);

c_blad = 0;
for i = 1 : size(zbior_uczacy, 1)
    wynik = f_sym_automat(zbior_uczacy(i, :), macierz_z_pso);
    wynik2 = znajdz_symbol(i, liczba_wierszy - liczba_st_odrzucajacych, liczba_kopii);
    
    %sprawdzamy czy wynik automatu jest prawidlowy, poprzez sprawdzenie czy
    %na x-tym miejscu w wektorze "wynik" znajduje siê 1 i jesli nie, to zwiekszamy blad
    if (wynik2 ~= -1 && znajdz_symbol_obcy(wynik) == 1)
        c_blad = c_blad + 1;
    elseif(wynik2 ~= -1 && wynik(wynik2) ~= max(wynik))  % TUTAJ stosuje juz ³atwiejsza funkcje bledu
        c_blad = c_blad + 1;
    elseif (wynik2 == -1 && znajdz_symbol_obcy(wynik) ~= 1)
        c_blad = c_blad + 1;
    end
end


blad = c_blad / size(zbior_uczacy, 1);
disp(sprintf('Blad calkowity obliczen dla zbioru uczacego: %f', blad));
[blad2,wektor_wynikowy]=uzyj_zbioru_testowego(liczba_symboli_testowych, macierz_z_pso, wszystkie_symbole);

if(sciezka_plik_wynikowy ~= '_')
    xlswrite(sciezka_plik_wynikowy,wektor_wynikowy);
end
blad2 = blad2 / liczba_symboli_testowych;
disp(sprintf('Blad calkowity obliczen dla zbioru testowego: %f', blad2));


%koniec mierzenia czasu
czas = toc
if(sciezka_plik_dodatkowy ~= '_')
    bledy = {blad, 'Blad na zb.train'; blad2, 'Blad na zb.test' ;czas, 'Calkowity czas'};
    xlswrite(sciezka_plik_dodatkowy,bledy);
end
end