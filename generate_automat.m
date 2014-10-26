function matrix_of_transitions= generate_automat(liczba_symboli,liczba_podzialow)

% losowanie funkcji przejscia
matrix_of_transitions=zeros(liczba_symboli,liczba_symboli,liczba_podzialow);

for i=1:liczba_podzialow
    for j=1:liczba_symboli
        r=randi(liczba_symboli);
        for k=1:liczba_symboli;
            if(k==r)
                matrix_of_transitions(k,j,i)=1;
            else
                matrix_of_transitions(k,j,i)=0;
            end
        end
    end
end

end






