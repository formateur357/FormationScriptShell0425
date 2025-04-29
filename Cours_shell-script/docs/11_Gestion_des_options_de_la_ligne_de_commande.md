# Gestion des options de la ligne de commande

## Table des matières

1. [Introduction aux options](#1-introduction-aux-options)
2. [Concepts de base](#2-concepts-de-base)
  - [Options et Arguments](#21-options-et-arguments)
  - [Paramètres positionnels](#22-paramètres-positionnels)
3. [Analyse des options avec getopts](#3-analyse-des-options-avec-getopts)
  - [Présentation de getopts](#31-présentation-de-getopts)
4. [Traitement des Options Longues](#4-traitement-des-options-longues)
  - [Alternatives à getopts](#41-alternatives-à-getopts)
5. [Gestion d’erreurs et validation](#5-gestion-derreurs-et-validation)
  - [Vérification des Options](#51-vérification-des-options)
  - [Bonnes pratiques](#52-bonnes-pratiques)
6. [Exemple de script complet](#6-exemple-de-script-complet)
7. [Astuces avancées](#7-astuces-avancées)
  - [Combinaison des options](#71-combinaison-des-options)
  - [Priorité des options](#72-priorité-des-options)
  - [Documentation et aide](#73-documentation-et-aide)

## 1. Introduction aux options

Les options permettent aux utilisateurs de modifier le comportement d’un script lors de son exécution. Elles sont habituellement précédées d’un tiret simple (ex. -a) ou double (ex. --all) et permettent d’activer ou de désactiver des fonctionnalités spécifiques du script.

## 2. Concepts de base

### 2.1 Options et Arguments
- **Options** : Ce sont des indicateurs qui précèdent souvent un tiret et servent à activer ou désactiver des fonctionnalités (ex. `-v` pour activer le mode verbeux).
- **Arguments** : Ce sont des valeurs fournies aux options pour définir leur fonctionnement (ex. `-o output.txt`, où `output.txt` est l’argument associé).

### 2.2 Paramètres positionnels
Les paramètres qui ne sont pas précédés d’options sont appelés paramètres positionnels et sont accessibles via des variables comme `$1`, `$2`, etc. Leur ordre est crucial pour le traitement des informations dans le script.

## 3. Analyse des options avec getopts

### 3.1 Présentation de getopts

La commande `getopts` est une fonctionnalité intégrée des shells POSIX qui simplifie l'analyse des options dans un script. Voici quelques détails importants sur son utilisation :

- Traitement des options :
  - Permet d'extraire automatiquement les options courtes (ex. `-v`) et, lorsqu’elles le requièrent, leurs arguments.
  - Facilite la gestion des erreurs en permettant d'identifier les options manquantes d'un argument ou non reconnues.

- Syntaxe de base : ./programme -l 100 -v -a red 1 2999
  ```bash
  while getopts ":l:va:" opt; do
    case ${opt} in
      l )
        valeur_option_a=$OPTARG
        ;;
      v )
        flag_b=1
        ;;
      a )
        valeur_option_c=$OPTARG
        ;;
      \? )
        echo "Option invalide : -$OPTARG" >&2
        exit 1
        ;;
      : )
        echo "L'option -$OPTARG nécessite un argument." >&2
        exit 1
        ;;
    esac
  done
  shift $((OPTIND - 1))
  ```
  - La chaîne `":a:b"` indique :
    - `a` attend un argument (le deux-points après `a`).
    - `b` n'attend pas d'argument.
  - `$OPTARG` contient l'argument associé à une option si nécessaire.
  - `$OPTIND` indique la prochaine position dans la liste des arguments à analyser.

- Bonnes pratiques :
  - Initialisez les variables associées aux options avant de commencer l'analyse.
  - Utilisez `shift $((OPTIND - 1))` pour supprimer les options traitées, ce qui permet d'accéder aux paramètres positionnels restants.

Cette méthode rend l'analyse des options plus structurée, améliore la lisibilité du script et aide à gérer efficacement les erreurs d'entrée.

## 4. Traitement des Options Longues

### 4.1 Alternatives à getopts
Pour gérer les options longues comme `--verbose`, on peut utiliser la commande `getopt` ou des bibliothèques externes. Voici un exemple utilisant `getopt` :
```bash
TEMP=$(getopt -o vo: --long verbose,output: -n 'script.sh' -- "$@")
# -v --output -- -fichier1 fichier2
eval set -- "$TEMP"
while true; do
  case "$1" in
    --verbose|-v)
      verbose=1; shift;;
    --output|-o)
      output_file="$2"; shift 2;;
    --)
      shift; break;;
    *)
      echo "Option inconnue : $1" ; exit 1 ;;
  esac
done
```
Cet exemple montre comment obtenir une syntaxe plus explicite et flexible pour la gestion des options.

## 5. Gestion d’erreurs et validation

### 5.1 Vérification des Options
- Affichez des messages d’erreur précis en cas d’option invalide.
- Fournissez un message d’aide (option `-h` ou `--help`) pour guider l’utilisateur sur l’utilisation correcte du script.

### 5.2 Bonnes pratiques
- Vérifiez systématiquement la validité des arguments.
- Documentez clairement chaque option dans le script pour faciliter sa compréhension.
- Centralisez la gestion des erreurs afin d’améliorer la maintenabilité du code.

## 6. Exemple de script complet

Voici un exemple complet d’un script utilisant getopts pour l’analyse des options :
```bash
#!/bin/bash

# Initialisation des variables
verbose=0
output_file=""

# Fonction d'affichage de l'aide
usage() {
  echo "Usage: $0 [-v] [-o fichier] [arguments]"
  exit 0
}

# Analyse des options
while getopts ":vo:h" opt; do
  case ${opt} in
    v )
      verbose=1
      ;;
    o )
      output_file=$OPTARG
      ;;
    h )
      usage
      ;;
    \? )
      echo "Option invalide : -$OPTARG" 1>&2
      usage
      ;;
    : )
      echo "L'option -$OPTARG nécessite un argument." 1>&2
      usage
      ;;
  esac
done
shift $((OPTIND - 1))

# Exécution du script en fonction des options
if [ $verbose -eq 1 ]; then
  echo "Mode verbeux activé."
fi

if [ -n "$output_file" ]; then
  echo "Fichier de sortie : $output_file"
fi

echo "Arguments restants : $@"
```
## 7. Astuces avancées

### 7.1 Combinaison des options
Pour les options qui ne requièrent pas d’argument, vous pouvez les combiner afin de rendre l’appel du script plus concis. Par exemple, au lieu d'exécuter :
```bash
script.sh -a -b -c
```
Vous pouvez combiner ces options en une seule séquence :
```bash
script.sh -abc
```
Si une option nécessite un argument, veillez à la placer à la bonne position ou à l’exprimer séparément. Par exemple :
```bash
script.sh -ab -c valeur
```
Ici, les options -a et -b sont combinées tandis que -c attend un argument.

### 7.2 Priorité des options
Il est recommandé de traiter toutes les options avant de gérer les paramètres positionnels afin d’éviter toute ambiguïté. Voici un exemple illustrant ce principe :
```bash
#!/bin/bash

verbose=0
while getopts "v" opt; do
  case $opt in
    v)
      verbose=1
      ;;
    *)
      ;;
  esac
done
shift $((OPTIND - 1))

# Traitement des paramètres positionnels après les options
for param in "$@"; do
  echo "Paramètre : $param"
done
```
Dans cet exemple, une fois les options traitées, la commande shift permet de se concentrer sur les arguments restants.

### 7.3 Documentation et aide
Inclure un message d’aide détaillé dans votre script peut faciliter son utilisation. Voici un exemple de fonction d’aide :
```bash
usage() {
  cat <<EOF
Usage: $0 [options] parametres
Options:
  -v           Activer le mode verbeux
  -o fichier   Spécifier le fichier de sortie
  -h           Afficher ce message d'aide

Exemple:
  $0 -v -o sortie.txt fichier1 fichier2
EOF
  exit 1
}

# Exemple d'utilisation dans le traitement des options
while getopts "vo:h" opt; do
  case $opt in
    v)
      verbose=1
      ;;
    o)
      output_file=$OPTARG
      ;;
    h)
      usage
      ;;
    *)
      usage
      ;;
  esac
done
```
Cette approche rend votre script plus convivial en permettant à l’utilisateur d’obtenir rapidement aide et documentation.
