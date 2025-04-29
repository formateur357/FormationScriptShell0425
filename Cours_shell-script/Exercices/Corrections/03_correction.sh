#!/bin/bash
# analyse_fichiers.sh
# Script de synthèse - Analyse complète d'un dossier avec tests sur fichiers et comparaisons avancées

# === 1. Demander le chemin du dossier à l'utilisateur ===
read -p "Entrez un dossier à analyser : " dossier

# --- Vérification de la saisie ---
# Test si la variable est vide
if [[ -z "$dossier" ]]; then
    echo "Erreur : aucun dossier spécifié."
    exit 1  # On quitte le script avec un code d'erreur
fi

# Test si le chemin existe
if [ ! -e "$dossier" ]; then
    echo "Erreur : le chemin '$dossier' n'existe pas."
    exit 1
fi

# Test si c'est bien un dossier
if [ ! -d "$dossier" ]; then
    echo "Erreur : '$dossier' n'est pas un dossier."
    exit 1
fi

# Si tout est OK, on peut continuer
echo "Analyse du dossier : $dossier"
echo

# === 2. Initialisation des compteurs pour les statistiques ===
nb_total=0         # Nombre total de fichiers traités
nb_scripts_exec=0  # Nombre de scripts .sh exécutables
nb_non_lisibles=0  # Nombre de fichiers non lisibles

# === 3. Parcourir tous les éléments du dossier ===
for fichier in "$dossier"/*; do

    # Tester si c'est un fichier (et pas un dossier)
    if [ -f "$fichier" ]; then
        nom_fichier=$(basename "$fichier")  # Récupère seulement le nom du fichier (sans chemin)
        echo "Fichier analysé : $nom_fichier"

        # --- Test de lisibilité ---
        if [ ! -r "$fichier" ]; then
            echo "-> ATTENTION : fichier non lisible."
            ((nb_non_lisibles++))  # Incrémenter le compteur de fichiers non lisibles
        fi

        # --- Tests sur le nom de fichier avec [[ ]] et motifs ---
        if [[ "$nom_fichier" == *.sh ]]; then
            echo "-> Script Shell détecté : $nom_fichier"

            # Vérification de l'exécutabilité
            if [ -x "$fichier" ]; then
                echo "-> Script prêt à être exécuté."
                ((nb_scripts_exec++))  # Incrémenter le compteur de scripts exécutables
            else
                echo "-> Script non exécutable. Pour le rendre exécutable : chmod +x \"$fichier\""
            fi

        elif [[ "$nom_fichier" == *.txt ]]; then
            echo "-> Fichier texte détecté : $nom_fichier"

        elif [[ "$nom_fichier" == *.log ]]; then
            echo "-> Fichier log détecté : $nom_fichier"

        else
            echo "-> Autre type de fichier : $nom_fichier"
        fi

        echo  # Saut de ligne pour aérer la sortie
        ((nb_total++))  # Incrémenter le nombre total de fichiers analysés
    fi

done

# === 4. Résumé final de l'analyse ===
echo "=== Résumé de l'analyse ==="
echo "Nombre total de fichiers analysés : $nb_total"
echo "Nombre de scripts .sh exécutables : $nb_scripts_exec"
echo "Nombre de fichiers non lisibles : $nb_non_lisibles"
