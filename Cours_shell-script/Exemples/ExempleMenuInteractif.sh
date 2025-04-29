#!/bin/bash
PS3="Veuillez choisir une option : "
options=("Option 1" "Option 2" "Quitter")
echo($PS3)
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "Vous avez choisi l'Option 1."
            ;;
        "Option 2")
            echo "Vous avez choisi l'Option 2."
            ;;
        "Quitter")
            echo "Au revoir !"
            break
            ;;
        *)
            echo "Option invalide."
            ;;
    esac
done