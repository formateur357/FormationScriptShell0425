#!/bin/bash

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Fonctions
afficher_menu() {
    printf "${YELLOW}========= MENU PRINCIPAL =========${NC}\n"
    echo "1) Démarrer le service"
    echo "2) Arrêter le service"
    echo "3) Redémarrer le service"
    echo "4) Quitter"
    echo "==================================="
}

traiter_choix() {
    case $1 in
        1) printf "${GREEN}Service démarré !${NC}\n" ;;
        2) printf "${RED}Service arrêté.${NC}\n" ;;
        3) printf "${YELLOW}Service redémarré.${NC}\n" ;;
        4) printf "${GREEN}Au revoir !${NC}\n"
           exit 0
           ;;
        *) printf "${RED}Choix invalide. Veuillez réessayer.${NC}\n" ;;
    esac
}

# Boucle principale
while true; do
    afficher_menu
    read -p "Votre choix [1-4] : " choix

    if [[ "$choix" =~ ^[1-4]$ ]]; then
        traiter_choix "$choix"
    else
        printf "${RED}Entrée invalide.${NC} Merci de saisir un nombre entre 1 et 4.\n"
    fi

    echo ""
done
