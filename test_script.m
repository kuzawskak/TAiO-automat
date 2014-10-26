function[] = test_script(varargin)

tic
global a;
global liczba_stron;
global liczba_wierszy;
global zbior_uczacy;
global liczba_kopii;

in_file = 'in_file.dat';
  
%skrypt testowy z podanymi z góry wartosciami 
liczba_podzialow = 5;
liczba_cech = varargin{3};
liczba_symboli = varargin{4};
liczba_kopii = varargin{5};
max_value = varargin{6};
liczba_iteracji = varargin{7};
liczba_rojow = varargin{8};

if(liczba_podzialow == 0 || liczba_cech == 0 || liczba_symboli == 0 ...
        || liczba_kopii == 0 || max_value == 0 || liczba_iteracji == 0 ...
        || liczba_rojow == 0)
    warndlg('Ustaw poprawne wartoœci parametrów');
    return;
end;

%generujemy swoj plik csv
generate_csv(liczba_symboli, liczba_cech, max_value, in_file);

%zmapowane symbole zapisane w jednym wektorze
wszystkie_symbole = mapowanie_symboli(in_file, liczba_symboli);

%przygotowanie gotowego zbior uczacego do uzycia w automacie
zbior_uczacy = prepare_training_dataset(in_file, liczba_symboli, liczba_cech, liczba_kopii);

%GENERUJAMY AUTOMAT - w postaci tabeli funkcji przejscia
automat = generate_automat(liczba_symboli, liczba_podzialow);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = 100;
f_handler = @funkcja_bledu;
liczba_stron = liczba_cech;
liczba_wierszy = liczba_symboli;

matrix_as_vector = permute(reshape(...
    automat, liczba_symboli * liczba_symboli * liczba_cech, 1, 1), [2 1]);

%Ustawiamy opcje PSO: liczbe rojów i maksymaln¹ liczbê iteracji
options = PSO('options');
options.npart = liczba_rojow;
options.niter = liczba_iteracji;

[xopt, fopt] = PSO(f_handler, liczba_symboli * liczba_symboli * liczba_cech, options);
  
maxx = 0;
new_matrix = reshape(xopt, liczba_wierszy, liczba_wierszy, liczba_stron);

for i = 1 : liczba_stron
    for j = 1 : liczba_wierszy
    maxx = max(new_matrix(:, j, i));
        for k = 1 : liczba_wierszy
            if(new_matrix(k, j, i) == maxx)
                new_matrix(k, j, i) = 1;
            else
                new_matrix(k, j, i) = 0;
            end
        end
    end
end
  
c_blad = 0;
for i = 1 : size(zbior_uczacy, 1)
   % zbior_uczacy(i,:)
   % i
    wynik = automat_simulation(zbior_uczacy(i, :), new_matrix);
    wynik2 = find_symbol(i, liczba_symboli, 100);
    if(wynik ~= wynik2)
        c_blad = c_blad + 1;
    end
end

    
disp('Blad calkowity obliczen:');     
blad =  c_blad / size(zbior_uczacy, 1)

toc
end