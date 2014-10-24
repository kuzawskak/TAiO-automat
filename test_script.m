global a;
global liczba_stron;
global liczba_wierszy;
global zbior_uczacy;
global liczba_kopii;
  
%skrypt testowy z podanymi z góry wartosciami 
liczba_symboli = 10;
liczba_cech = 5;
liczba_kopii=100;
max_wartosc = 20;
liczba_symboli_do_testu=10;
srednia=0;
wariancja=3;

%start mierzenia czasu
tic
%generujemy swoj plik csv
generuj_csv(liczba_symboli,liczba_cech,max_wartosc);

%zmapowane symbole zapisane w jednym wektorze
wszystkie_symbole=mapowanie_symboli( 'in_file.dat', liczba_symboli );

%przygotowanie gotowego zbior uczacego do uzycia w automacie
zbior_uczacy=stworz_zbior_uczacy('in_file.dat', liczba_symboli, liczba_cech, liczba_kopii,srednia, wariancja );

%GENERUJAMY AUTOMAT - w postaci tabeli funkcji przejscia
automat = generuj_automat(liczba_symboli,liczba_cech);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = 100;
f_handler = @funkcja_bledu;
liczba_stron = liczba_cech;
liczba_wierszy = liczba_symboli;

[xopt, fopt] = PSO(f_handler,liczba_symboli*liczba_symboli*liczba_cech );

maxx=0;
new_matrix=reshape(xopt, liczba_wierszy, liczba_wierszy, liczba_stron);

for i=1:liczba_stron
    for j=1:liczba_wierszy
    maxx=max(new_matrix(:,j,i));
        for k=1:liczba_wierszy
            if(new_matrix(k,j,i)==maxx)
                new_matrix(k,j,i)=1;
            else
                new_matrix(k,j,i)=0;
            end
        end
    end
end
  
c_blad = 0;
for i=1:size(zbior_uczacy,1),
    wynik=symulacja_automatu( zbior_uczacy(i,:), new_matrix );
    wynik2=znajdz_symbol(i,liczba_symboli,liczba_kopii);
    if(wynik~=wynik2)
        c_blad=c_blad+1;
    end
end

blad =c_blad/size(zbior_uczacy,1);
disp(sprintf('Blad calkowity obliczen dla zbioru uczacego: %f', blad))   

blad2=uzyj_zbioru_testowego(liczba_symboli_do_testu,new_matrix, wszystkie_symbole)/liczba_symboli_do_testu;
disp(sprintf('Blad calkowity obliczen dla zbioru testowego: %f', blad2))  

%koniec mierzenia czasu
toc