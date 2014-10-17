function symbol = automat_simulation( vector, matrix_of_transitions )
%AUTOMAT_SIMULATION symulacja pracy automatu, mnozenie macierzy i
%wypisywanie wynikowego stanu, na koniec znajdowany jest indeks jedynki w
%wektorze, potrzebny do zmapowania symbolu

prev_state=zeros(size(matrix_of_transitions,1),1);
prev_state(1)=1;
next_state=prev_state;
for i=1:length(vector)
%Narazie zwykle mnozenie, bo dla 0 i 1 to bedzie dzialac, potem trzeba dac wzor od Homendy
    next_state=matrix_of_transitions(:,:,vector(i))*prev_state;
    prev_state=next_state;

end

symbol=find(next_state);
end
