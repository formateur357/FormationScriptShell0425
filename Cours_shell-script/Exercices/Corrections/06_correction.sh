#!/bin/bash

# === 1. Initialisation des variables ===
verbose=0              # Mode verbeux (désactivé par défaut)
output_file="output.txt"  # Nom du fichier de sortie par défaut
input_file=""
dry_run=0               # Mode simulation : n'exécute pas réellement

# === 2. Fonction d'affichage de l'aide ===
usage() {
  cat <<EOF
Usage: $0 [options] [fichiers...]
Options:
  -v, --verbose             Activer le mode verbeux
  -o, --output <fichier>     Spécifier un fichier de sortie
  -f <fichier>               Fichier d'entrée obligatoire
  -n                         Mode simulation (dry run)
  -h, --help                 Afficher cette aide

Exemples :
  $0 -v -f monfichier.txt --output sortie.txt fichier1 fichier2
  $0 --help
EOF
  exit 0
}

# === 3. Analyse des options longues avec getopt ===

# Appel à getopt pour préparer les options
TEMP=$(getopt -o vo:h --long verbose,output:,help -n "$0" -- "$@")
# Vérification d'erreur sur getopt
if [ $? != 0 ]; then
  echo "Erreur dans les options." >&2
  exit 1
fi

# Réorganisation propre des arguments
eval set -- "$TEMP"

# Parcours des options longues
while true; do
  case "$1" in
    -v|--verbose)
      verbose=1
      shift
      ;;
    -o|--output)
      output_file="$2"
      shift 2
      ;;
    -h|--help)
      usage
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Option longue inconnue : $1" >&2
      exit 1
      ;;
  esac
done

# === 4. Analyse complémentaire avec getopts pour les options courtes restantes ===

# Important : getopts traite uniquement ce qui reste
while getopts ":f:n" opt; do
  case "$opt" in
    f)
      input_file="$OPTARG"
      ;;
    n)
      dry_run=1
      ;;
    \?)
      echo "Option invalide : -$OPTARG" >&2
      usage
      ;;
    :)
      echo "Erreur : l'option -$OPTARG nécessite un argument." >&2
      usage
      ;;
  esac
done

# Retirer les options traitées pour obtenir uniquement les paramètres positionnels
shift $((OPTIND - 1))

# === 5. Vérifications après parsing ===

# Vérifier que le fichier d'entrée est bien spécifié
if [ -z "$input_file" ]; then
  echo "Erreur : un fichier d'entrée doit être spécifié avec -f." >&2
  usage
fi

# Vérifier que le fichier d'entrée existe réellement
if [ ! -f "$input_file" ]; then
  echo "Erreur : fichier d'entrée '$input_file' introuvable." >&2
  exit 1
fi

# === 6. Affichage récapitulatif en mode verbeux ===

if [ "$verbose" -eq 1 ]; then
  echo "Mode verbeux activé."
  echo "Fichier d'entrée : $input_file"
  echo "Fichier de sortie : $output_file"
  echo "Mode simulation (dry run) : $dry_run"
  echo "Paramètres positionnels restants : $*"
fi

# === 7. Comportement principal du script ===

# Exécuter ou simuler une action en fonction des paramètres
if [ "$dry_run" -eq 1 ]; then
  echo "[Simulation] Le script agirait ici, mais rien n'est exécuté."
else
  echo "Traitement réel en cours..."
  # Exemple de traitement : copier le fichier d'entrée vers la sortie
  cp "$input_file" "$output_file"
  echo "Fichier '$input_file' copié vers '$output_file'."
fi

# Fin de script
exit 0
