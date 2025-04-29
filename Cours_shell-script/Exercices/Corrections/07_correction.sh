#!/bin/bash

# === Paramétrage initial pour fiabiliser l'exécution ===
set -e          # Arrêter le script dès qu'une commande échoue
set -x          # Afficher chaque commande exécutée (débogage)

# === Définition d'une fonction de nettoyage ===
cleanup() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Signal reçu. Lancement du nettoyage..."
    monitoring=0  # Demande à la boucle principale de s'arrêter proprement
    # Ici, on pourrait ajouter d'autres opérations (fermer fichiers, sauvegarder état, etc.)
}

# === Installation du trap AVANT toute boucle ===
# On capture SIGINT (Ctrl+C) et SIGTERM (kill classique) pour lancer cleanup()
trap cleanup SIGINT SIGTERM

# === Vérification des paramètres ===
if [ -z "$1" ]; then
    echo "Erreur : aucun dossier fourni en paramètre." >&2
    echo "Utilisation : $0 <répertoire à surveiller>" >&2
    exit 1
fi

# === Affectation sécurisée de la variable ===
REP="$1"

# === Initialisation d'un flag de contrôle ===
monitoring=1

# === Définition de la fonction principale de surveillance ===
monitor_dir() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Démarrage de la surveillance du dossier : $REP"
    
    while [ "$monitoring" -eq 1 ]; do
        # Vérification régulière que le dossier existe
        if [ ! -d "$REP" ]; then
            echo "Erreur critique : le dossier '$REP' n'existe plus !" >&2
            exit 2
        fi

        # Compte sécurisé du nombre de fichiers (sans dépendre de ls)
        NB_FICHIERS=$(find "$REP" -maxdepth 1 -type f | wc -l)

        echo "[$(date +%T)] Nombre de fichiers dans '$REP' : $NB_FICHIERS"
        sleep 5  # Pause de 5 secondes entre chaque analyse
    done

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Surveillance arrêtée proprement."
}

# === Lancement de la fonction de surveillance ===
monitor_dir

# === Fin de script ===
exit 0
