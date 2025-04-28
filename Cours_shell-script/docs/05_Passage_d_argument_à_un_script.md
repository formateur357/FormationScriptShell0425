## Passage d'argument à un script

Dans les scripts shell, il est souvent nécessaire de passer des arguments pour rendre le script plus dynamique et interactif. Les arguments permettent à l'utilisateur de fournir des données au script lors de son exécution. Nous allons développer chaque point et fournir des exemples concrets.

## Table des Matières

- [Passage d'argument à un script](#passage-dargument-à-un-script)
- [1. Notion de paramètres positionnels](#1-notion-de-paramètres-positionnels)
- [2. Récupération et modification des paramètres (commande set)](#2-récupération-et-modification-des-paramètres-commande-set)
- [3. Exemples d'utilisation](#3-exemples-dutilisation)
  - [Exemple 1 : Affichage des arguments](#exemple-1--affichage-des-arguments)
  - [Exemple 2 : Utilisation conditionnelle des arguments](#exemple-2--utilisation-conditionnelle-des-arguments)
- [4. Utilisation de shift pour parcourir les arguments](#4-utilisation-de-shift-pour-parcourir-les-arguments)
- [5. Différence entre "$*" et "$@"](#5-différence-entre-*--et--@)
- [6. Passage d'options avec getopts](#6-passage-doptions-avec-getopts)
- [7. Bonnes pratiques et vérification d'arguments](#7-bonnes-pratiques-et-vérification-darguments)

### 1. Notion de paramètres positionnels

Les paramètres positionnels sont les arguments passés au script dans l'ordre où ils apparaissent. Chaque argument est accessible via des variables nommées `$1`, `$2`, `$3`, etc. Par exemple, si vous exécutez le script :

Commande :
    ./mon_script.sh arg1 arg2 arg3

Dans le script, `$1` vaut "arg1", `$2` vaut "arg2", et `$3` vaut "arg3".

Exemple concret :

```bash
#!/bin/bash
echo "Premier argument : $1"
echo "Deuxième argument : $2"
echo "Troisième argument : $3"
```

Exécution :
    ./mon_script.sh pomme orange banane

=> Affichera :
    Premier argument : pomme  
    Deuxième argument : orange  
    Troisième argument : banane

### 2. Récupération et modification des paramètres (commande set)

La commande `set` est utile pour modifier la liste des paramètres positionnels après le lancement du script. En utilisant `set --`, vous pouvez redéfinir les valeurs des paramètres.

Exemple concret :

```bash
#!/bin/bash
# Afficher les arguments initiaux
echo "Arguments initiaux : $@"

# Modification des paramètres positionnels
set -- "nouveau1" "nouveau2" "nouveau3"

# Afficher les nouveaux paramètres
echo "Arguments après set : $@"
```

Exécution initiale peut être faite avec :
    ./mon_script.sh a b c

Mais après la commande `set --`, les arguments seront remplacés par "nouveau1", "nouveau2" et "nouveau3".

### 3. Exemples d'utilisation

#### Exemple 1 : Affichage des arguments
Un script simple qui affiche tous les paramètres passés à l'exécution.

```bash
#!/bin/bash
echo "Nombre d'arguments : $#"
echo "Liste des arguments : $@"
```

Ici, `$#` retourne le nombre d’arguments et `$@` affiche la liste complète des arguments.

#### Exemple 2 : Utilisation conditionnelle des arguments

Le script peut effectuer différentes actions en fonction de la valeur du premier argument. Par exemple, s'il vaut "hello", il affiche un message spécifique.

```bash
#!/bin/bash
if [ "$1" == "hello" ]; then
        echo "Vous avez passé 'hello' comme premier argument."
else
        echo "Premier argument : $1"
fi
```

Si le script est exécuté avec :
    ./mon_script.sh hello world
Il affichera :
    Vous avez passé 'hello' comme premier argument.


### 4. Utilisation de shift pour parcourir les arguments

La commande `shift` permet de "déplacer" la liste des arguments, ce qui est utile pour traiter un nombre variable d'arguments dans une boucle.

Exemple :

```bash
#!/bin/bash
echo "Arguments avant shift : $@"
while [ "$#" -gt 0 ]; do
    echo "Argument courant : $1"
    shift
done
```

Chaque appel à `shift` fait passer `$2` en `$1`, `$3` en `$2`, et ainsi de suite.

### 5. Différence entre "$*" et "$@"

- "$*" combine tous les arguments en une seule chaîne, séparés par le premier caractère défini dans IFS (Internal Field Separator).
- "$@" traite chaque argument comme une chaîne distincte, surtout utile dans des boucles ou lors du passage en paramètre à d'autres commandes.

Exemple :

```bash
#!/bin/bash
echo "Utilisation de \"\$*\": $*"
echo "Utilisation de \"\$@\":"
for arg in "$@"; do
    echo "$arg"
done
```

### 6. Passage d'options avec getopts

Pour gérer des options multiples et des arguments optionnels, la commande `getopts` est très pratique. Elle simplifie l’analyse des options en ligne de commande.

Exemple :

```bash
#!/bin/bash

while getopts "a:b:" opt; do
  case $opt in
    a)
      echo "Option -a avec valeur : $OPTARG"
      ;;
    b)
      echo "Option -b avec valeur : $OPTARG"
      ;;
    \?)
      echo "Option invalide : -$OPTARG" >&2
      ;;
  esac
done
```

Ce script traite les options `-a` et `-b` avec leurs arguments respectifs.

### 7. Bonnes pratiques et vérification d'arguments

- Vérifiez toujours le nombre d'arguments attendus au début du script.
- Fournissez un message d’aide en cas d’utilisation incorrecte, souvent à l’aide d’une condition qui affiche l'usage du script.
- Utilisez des variables locales dans des fonctions pour éviter des conflits avec les paramètres globaux.

Exemple de vérification :

```bash
#!/bin/bash
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 argument1 argument2 [argument3 ...]"
  exit 1
fi

echo "Arguments validés, exécution du script..."
```

Cette vérification assure que le script reçoit au moins deux arguments, sinon il s'arrête et affiche un message d'usage.
