tic
global a;
global liczba_stron;
global liczba_wierszy;
global zbior_uczacy;
global liczba_kopii;
  
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
zbior_uczacy=prepare_training_dataset('in_file.dat', liczba_symboli, liczba_cech, liczba_kopii);

%GENERUJAMY AUTOMAT - w postaci tabeli funkcji przejscia
automat = generate_automat(liczba_symboli,5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = 100;
f_handler = @funkcja_bledu;
liczba_stron = liczba_cech;
liczba_wierszy = liczba_symboli;

matrix_as_vector = permute(reshape(automat,liczba_symboli*liczba_symboli*liczba_cech,1,1),[2 1]);
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
for i=1:size(zbior_uczacy,1)
   % zbior_uczacy(i,:)
   % i
    wynik=automat_simulation( zbior_uczacy(i,:), new_matrix );
    wynik2=find_symbol(i,liczba_symboli,100);
    if(wynik~=wynik2)
        c_blad=c_blad+1;
    end
end

    
disp('Blad calkowity obliczen:');     
blad =  c_blad/size(zbior_uczacy,1)

toc