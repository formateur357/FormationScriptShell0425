#!/bin/bash

# calcul() {
#     local n="$1"
#     if [ "$n" -le 0 ]; then
#         echo "Termine"
#     else
#         calcul $((n - 1))
#     fi
# }

# calcul 10000 &

# pid=$!

# echo "Calcul lance avec PID $pid"

# wait $pid

# echo "Calcul termine !"

#############################

sleep 3 &
sleep 5 &
sleep 7 &

echo "Tache lancees, en attente..."

for job in $(jobs -p); do
    wait "$job"
done

echo "Toutes les taches sont terminees."