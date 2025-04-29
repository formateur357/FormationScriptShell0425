# Exercice de Débogage Shell – Gestion des Signaux et Débogage

## Objectif

Vous êtes chargé de **déboguer un script existant** censé surveiller un dossier.  
Le script actuel présente plusieurs erreurs importantes dans :
- La gestion des **signaux** (`trap`),
- La **structure de la boucle** principale,
- Le **débogage** (`set -x`, `set -e`),
- La **propreté générale** du script.

Votre mission est de **identifier**, **corriger** et **améliorer** le script en appliquant les bonnes pratiques étudiées.

---

## Script fourni à corriger : `monitor_dir.sh`

```bash
#!/bin/bash

set -e

trap 'echo "Interruption capturée"; nettoyer; exit' SIGINT SIGTERM

monitoring=1

moniteur_dir() {
    echo "Début de la surveillance du dossier $REP"
    while $monitoring; do
        if [ ! -d "$REP" ]; then
            echo "Erreur : dossier non trouvé : $REP"
            exit 2
        fi

        NB_FICHIERS=$(ls -1 "$REP" | wc -l)
        echo "[$(date +%T)] Fichiers dans $REP : $NB_FICHIERS"
        sleep 5
    done
}

nettoyer() {
    echo "Nettoyage en cours..."
    monitoring=0
}

if [ -z $1 ]; then
    echo "Erreur : aucun dossier fourni."
    exit 1
fi

REP="$1"

moniteur_dir
