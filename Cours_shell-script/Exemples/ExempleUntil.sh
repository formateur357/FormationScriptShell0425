#!/bin/bash
count=1
until [ $count -gt 10 ]
do
    echo "Compteur à $count"
    ((count++))
done