#!/bin/bash
# analyse_textes.sh
# Script complet d'analyse de chaînes, emails, fichiers et texte

# -----------------------------
# 1. Analyse d'une chaîne utilisateur
# -----------------------------

# Demande de saisie d'une chaîne
read -p "Entrez une chaîne : " chaine

# Vérification que la chaîne n'est pas vide
if [ -z "$chaine" ]; then
    echo "Erreur : chaîne vide. Fin du script."
    exit 1
fi

# Calcul de la longueur
longueur=$(expr length "$chaine")
echo "- Longueur : $longueur"

# Recherche de la position de @ et -
pos_arobase=$(expr index "$chaine" "@")
pos_tiret=$(expr index "$chaine" "-")

# Affiche la position du premier des deux trouvés (non nul et minimum)
if [ "$pos_arobase" -ne 0 ] && ([ "$pos_tiret" -eq 0 ] || [ "$pos_arobase" -lt "$pos_tiret" ]); then
    echo "- Premier symbole '@' à la position $pos_arobase"
elif [ "$pos_tiret" -ne 0 ]; then
    echo "- Premier symbole '-' à la position $pos_tiret"
else
    echo "- Aucun '@' ni '-' trouvé."
fi

# Extraction des 5 premiers caractères
premiers=$(expr substr "$chaine" 1 5)
echo "- Premiers caractères : $premiers"

# Affichage des 20 premiers caractères si nécessaire
if [ "$longueur" -gt 20 ]; then
    premiers20=$(echo "$chaine" | awk '{print substr($0,1,20)}')
    echo "- Première partie (20 caractères) : $premiers20"
fi

echo
# -----------------------------
# 2. Extraction et traitement d'emails
# -----------------------------

# Demande de saisie d'une phrase
read -p "Entrez une phrase contenant un ou plusieurs emails : " phrase

# Extraction des emails
emails=$(echo "$phrase" | grep -oE '[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}')

if [ -z "$emails" ]; then
    echo "Aucun email trouvé."
else
    echo "- Emails trouvés :"
    echo "$emails" | while read -r email; do
        domaine=$(echo "$email" | awk -F'@' '{print $2}' | sed -E 's/^[^.]*\.//')
        echo "    - $email ➔ Domaine principal : $domaine"
    done
fi

echo
# -----------------------------
# 3. Analyse d'un chemin de fichier
# -----------------------------

# Demande d'un chemin complet de fichier
read -p "Entrez un chemin de fichier : " path

# Vérification que le chemin n'est pas vide
if [ -z "$path" ]; then
    echo "Erreur : chemin vide."
    exit 1
fi

# Nom du fichier avec basename
fichier_basename=$(basename "$path")
echo "- Nom de fichier (basename) : $fichier_basename"

# Extraction avec substitution ${}
fichier_nom=${path##*/}
dossier_parent=${path%/*}

echo "- Fichier sans chemin : $fichier_nom"
echo "- Dossier parent : $dossier_parent"

# Gestion du changement d'extension
if [[ "$fichier_nom" == *.log || "$fichier_nom" == *.txt || "$fichier_nom" == *.csv ]]; then
    nouveau_nom="${fichier_nom%.*}.bak"
    echo "- Nouveau nom : $nouveau_nom"
else
    echo "- Pas d'extension reconnue à changer."
fi

echo
# -----------------------------
# 4. Extraction depuis un fichier texte
# -----------------------------

# Demande d'un fichier texte existant
read -p "Entrez un fichier texte existant : " fichier

# Vérification de l'existence du fichier
if [ ! -f "$fichier" ]; then
    echo "Erreur : fichier inexistant."
    exit 1
fi

# Demande d'un mot-clé à chercher
read -p "Entrez un mot-clé à rechercher dans le fichier : " motcle

# Vérification que le mot-clé n'est pas vide
if [ -z "$motcle" ]; then
    echo "Erreur : mot-clé vide."
    exit 1
fi

# Extraction : grep + awk + sed
resultats=$(grep "$motcle" "$fichier" | awk '{print $2}' | sed 's/[.,]//g')

if [ -z "$resultats" ]; then
    echo "Aucun résultat trouvé pour le mot-clé '$motcle'."
else
    echo "- Résultats extraits et nettoyés :"
    echo "$resultats"
fi
