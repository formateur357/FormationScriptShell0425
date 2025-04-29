#!/bin/bash
# variables_expansions.sh
# Script de synthèse : variables et expansions diverses

# --- 1. Création de variables ---
prenom="Alice"    # Remplacer par votre prénom
declare -i age=24 # Remplacer par votre âge (déclaration entière)
ville=""          # Variable vide
# Variable langue non définie volontairement

# --- 2. Demande interactive ---

# Demander la ville de naissance si ville est vide
read -p "Entrez votre ville de naissance [Défaut: Inconnue] : " ville_input
ville="${ville_input:-Inconnue}"

# Demander la langue maternelle uniquement si non définie
if [ -z "${langue+x}" ]; then
    read -p "Entrez votre langue maternelle : " langue
    langue="${langue:=Français}" # Valeur par défaut si vide
fi

# --- 3. Expansions diverses ---

# Vérifier que prénom est bien défini
: "${prenom:?Erreur : la variable 'prenom' doit être définie}"

# Affichage personnalisé
echo
echo "Bienvenue ${prenom} !"

# Message alternatif si la langue est définie
echo "Votre langue maternelle est ${langue:+${langue}}."

# Affichage avec valeur par défaut si ville est vide
echo "Votre ville de naissance est : ${ville:-Inconnue}"

# --- 4. Manipulations de chaînes ---

# Longueur du prénom
echo "Votre prénom contient ${#prenom} lettres."

# Extraire les trois premières lettres du prénom
echo "Premières lettres de votre prénom : ${prenom:0:3}"

# Suppression de suffixe (/France) si présent dans ville
ville_modifiee="${ville%/France}"

# Remplacer les espaces par des underscores
ville_modifiee="${ville_modifiee// /_}"

echo "Ville formatée : $ville_modifiee"

# --- 5. Opérations sur les entiers ---

# Calcul de l'année de naissance
annee_actuelle=2025
declare -i annee_naissance=$((annee_actuelle - age))

echo "Votre année de naissance estimée est : $annee_naissance"

# --- 6. Tableaux ---

# Déclaration du tableau
declare -a langages=("bash" "python" "javascript")

# Parcours et affichage du tableau
echo "Langages préférés :"
for langage in "${langages[@]}"; do
    echo "- $langage"
done

# --- 7. Export de variables ---

export prenom

# --- 8. Destruction optionnelle ---

if [ "$1" == "--reset" ]; then
    unset prenom age ville ville_input ville_modifiee langue annee_naissance langages
    echo "Toutes les variables ont été supprimées."
fi
