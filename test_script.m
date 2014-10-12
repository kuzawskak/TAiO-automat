%skrypt testowy z podanymi z góry wartosciami 

liczba_cech = 5;
liczba_symboli = 10;
max_value = 20;

generate_csv(liczba_symboli,liczba_cech,max_value);
% macierz danych wejsciowych
dane_wejsciowe = csvread('in_file.dat',0,1)

% mapowanie symboli to wektor gdzie indeksom od 0 do liczba_symboli
% odpowiadaja char-y z tablicy wejsciowej - wykorzystamy na koniec
% dzialania programu - gdy bedziemy odczytywac wynik dla elemntu testowego
mapowanie_symboli = char(1,liczba_symboli);
fid = fopen('in_file.dat');

lineArray = cell(100,1);     %# Preallocate a cell array (ideally slightly
                               %#   larger than is needed)
  lineIndex = 1;               %# Index of cell to place the next line in
  nextLine = fgetl(fid);       %# Read the first line from the file
  while ~isequal(nextLine,-1)         %# Loop while not at the end of the file
    lineArray{lineIndex} = nextLine;  %# Add the line to the cell array
    lineIndex = lineIndex+1;          %# Increment the line index
    nextLine = fgetl(fid);            %# Read the next line from the file
  end
  fclose(fid);   
  lineArray = lineArray(1:lineIndex-1);  %# Remove empty cells, if needed
  
  
  for iLine = 1:lineIndex-1              %# Loop over lines
    lineData = textscan(lineArray{iLine},'%s');
    lineData = lineData{1};              %# Remove cell encapsulation
    mapowanie_symboli(iLine) = lineData{1}(1);
    lineArray(iLine,1:numel(lineData)) = lineData;  %# Overwrite line data   
  end  
mapowanie_symboli
%rozszerzamy macierz do zbioru uczacego - bedzie 100 razy wieksza
%zbior_uczacy = int(100*liczba_symboli,liczba_cech);
zbior_uczacy = zeros(100*liczba_symboli,liczba_cech);

for i = 0:liczba_symboli 
zbior_uczacy(i*100+1) = dane_wejsciowe(i+1);
end
% generowanie szumu rozkladem normalnym

for i = 0:liczba_symboli-1 
 for powt = 2:100    
        for cecha = 1:liczba_cech
            
            %ale na razie nie wiem jak wygenerowac rozklad z paraemtrami
            %innymi niz 0 i 1
        zbior_uczacy(i*100+powt,cecha) = dane_wejsciowe(i+1,cecha)+ abs(rozklad_normalny(0,3));
    end
end
end


%GENERUJAMY  AUTOMAT - w postaci tabeli funkcji przejscia
automat = generate_automat(zbior_uczacy,liczba_symboli,5);

%wrzucamy symbol w postaci wektora do automatu - zrowci indeks w tablicy
%mapowania
index = oblicz(automat,sym);
symbol = mapowanie_symboli(index)



