function [symbole] = mapowanie_symboli(csvfile, liczba_symboli)
%MAPOWANIE_SYMBOLI 
% mapowanie symboli to wektor gdzie indeksom od 0 do liczba_symboli
% odpowiadaja char-y z tablicy wejsciowej - wykorzystamy na koniec
% dzialania programu - gdy bedziemy odczytywac wynik dla elemntu testowego

symbole = char(1, liczba_symboli);
fid = fopen(csvfile);

%Preallocate a cell array (ideally slightly larger than is needed)
lineArray = cell(100, 1);
%Index of cell to place the next line in
lineIndex = 1;               
%Read the first line from the file
nextLine = fgetl(fid);   
%Loop while not at the end of the file
while ~isequal(nextLine, -1) 
    %Add the line to the cell array
    lineArray{lineIndex} = nextLine;
    lineIndex = lineIndex + 1;
    %Read the next line from the file
    nextLine = fgetl(fid);
end
fclose(fid);
%Remove empty cells, if needed
lineArray = lineArray(1 : lineIndex - 1);
  
%Loop over lines

for iLine = 1 : lineIndex - 1           
    lineData = textscan(lineArray{iLine}, '%s');
    %Remove cell encapsulation
    lineData = lineData{1};            
    symbole(iLine) = lineData{1}(1);
    %Overwrite line data
    lineArray(iLine, 1 : numel(lineData)) = lineData;
end  

end

