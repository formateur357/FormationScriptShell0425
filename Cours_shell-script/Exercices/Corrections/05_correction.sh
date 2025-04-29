#!/bin/bash

# Initialisation d'un tableau vide pour stocker les notes
notes=()

# Personnalisation du prompt affiché par la commande select
PS3="Que souhaitez-vous faire ? "

# Boucle principale qui affiche un menu et attend un choix utilisateur
select choix in "Ajouter des notes" "Afficher les notes" "Afficher la moyenne" "Quitter"
do
    # Utilisation d'un case pour exécuter l'action correspondant au choix de l'utilisateur
    case $choix in
        "Ajouter des notes")
            # Demander combien de notes l'utilisateur souhaite ajouter
            read -p "Combien de notes voulez-vous ajouter ? " n
            
            # Boucle while pour vérifier que l'entrée est bien un entier positif (>0)
            while ! [[ "$n" =~ ^[0-9]+$ ]] || [ "$n" -le 0 ]; do
                echo "Erreur : veuillez entrer un nombre entier positif."
                read -p "Combien de notes voulez-vous ajouter ? " n
            done

            # Boucle for pour demander et valider chaque note individuellement
            for (( i=1; i<=n; i++ )); do
                read -p "Entrez la note #$i (valeur entre 0 et 20) : " note

                # Boucle while pour vérifier que la note est un nombre valide entre 0 et 20
                while ! [[ "$note" =~ ^[0-9]+([.][0-9]+)?$ ]] || (( $(echo "$note < 0" | bc -l) )) || (( $(echo "$note > 20" | bc -l) )); do
                    echo "Note invalide. Saisissez un nombre compris entre 0 et 20."
                    read -p "Entrez la note #$i (0 à 20) : " note
                done

                # Ajouter la note validée au tableau
                notes+=("$note")
            done
            ;;

        "Afficher les notes")
            # Vérification : si aucune note n'est enregistrée
            if [ ${#notes[@]} -eq 0 ]; then
                echo "Aucune note enregistrée."
            else
                # Boucle for pour parcourir toutes les notes et les afficher
                echo "Voici les notes enregistrées :"
                for n in "${notes[@]}"; do
                    echo "$n"
                done
            fi
            ;;

        "Afficher la moyenne")
            # Vérification : s'assurer qu'il y a des notes avant de calculer la moyenne
            if [ ${#notes[@]} -eq 0 ]; then
                echo "Pas de notes disponibles pour le calcul de la moyenne."
            else
                total=0

                # Boucle for pour additionner toutes les notes
                for n in "${notes[@]}"; do
                    total=$(echo "$total + $n" | bc -l)
                done

                # Calcul de la moyenne avec 2 décimales de précision
                moyenne=$(echo "scale=2; $total / ${#notes[@]}" | bc -l)
                
                echo "Moyenne de l'ensemble : $moyenne / 20"
            fi
            ;;

        "Quitter")
            # Sortie propre de l'application
            echo "Merci d'avoir utilisé le gestionnaire de notes. À bientôt !"
            break
            ;;

        *)
            # Gérer les choix invalides
            echo "Option invalide. Veuillez choisir un numéro entre 1 et 4."
            ;;
    esac
done