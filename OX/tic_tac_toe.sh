#!/bin/bash

# Emulacja tablicy 2D za pomocą tablicy asocjacyjnej
declare -A m

r=3
c=3

function print_m(){
   for ((i=0; i<r; i++ )) do
       echo
       for (( j=0; j<c; j++ )) do
	   if [ "${m[$i,$j]}" = "1" ]; then
		   printf "%5s" "X"
	   elif [ "${m[$i,$j]}" = "0" ]; then
		   printf "%5s" "O"
           else
           	   printf "%5s" "."
           fi
       done
   done
   echo
}

# Sprawdzenie, czy w danym wierszu, kolumnie lub przekątnej są takie same symbole
check_line() {
   local line=("$@")
   if [[ ${line[0]} != "." && ${line[0]} == ${line[1]} && ${line[0]} == ${line[2]} ]]; then
      echo "${line[0]}"  # Zwróć symbol zwycięzcy
   else
      echo ""
   fi
}

# Sprawdzanie, czy gra się zakończyła
check_gameover() {
   # Sprawdzenie wierszy
   for ((i=0; i<r; i++)); do
      winner=$(check_line ${m[$i,0]} ${m[$i,1]} ${m[$i,2]})
      if [[ -n "$winner" ]]; then
         break
      fi
   done

   # Sprawdzenie kolumn
   if [[ -z "$winner" ]]; then
      for ((j=0; j<c; j++)); do
         winner=$(check_line ${m[0,$j]} ${m[1,$j]} ${m[2,$j]})
         if [[ -n "$winner" ]]; then
            break
         fi
      done
   fi

   # Sprawdzenie przekątnych
   if [[ -z "$winner" ]]; then
      winner=$(check_line ${m[0,0]} ${m[1,1]} ${m[2,2]})
   fi
   if [[ -z "$winner" ]]; then
      winner=$(check_line ${m[0,2]} ${m[1,1]} ${m[2,0]})
   fi

   # Jeśli ktoś wygrał
   if [[ -n "$winner" ]]; then
      if [[ "$winner" == "1" ]]; then
         echo "Gracz X wygrywa!"
      else
         echo "Gracz O wygrywa!"
      fi
      exit 0
   fi

   # Sprawdzenie remisu
   draw=true
   for ((i=0; i<r; i++)); do
      for ((j=0; j<c; j++)); do
         if [ "${m[$i,$j]}" == "." ]; then
            draw=false
            break 2  # Jeśli znaleziono wolne pole, przerywamy obie pętle
         fi
      done
   done

   if $draw; then
      echo "Remis!"
      exit 0
   fi
}



# Funkcja do wprowadzania ruchu gracza
make_move() {
    local player=$1
    local symbol=$2
    local x y

    while true; do
        echo -n "Gracz $player, podaj wiersz i kolumnę (np. 1 2): "
        read x y

        # Sprawdzenie, czy pole jest wolne
        if [ "${m[$x,$y]}" == "." ]; then
            m[$x,$y]=$symbol
            break
        else
            echo "⚠ To pole jest już zajęte! Wybierz inne."
        fi
    done
}

# Inicjalizacja pustej planszy
for ((i=0; i<r; i++)); do
    for ((j=0; j<c; j++)); do
        m[$i,$j]="."
    done
done

print_m
echo " "
echo "'.' oznacza, że pole jest wolne."
echo "Gra zaczyna się teraz!"

# Pętla gry
while true; do
    # Ruch Gracza O
    make_move "O" 0
    print_m
    check_gameover

    # Ruch Gracza X
    make_move "X" 1
    print_m
    check_gameover
done

