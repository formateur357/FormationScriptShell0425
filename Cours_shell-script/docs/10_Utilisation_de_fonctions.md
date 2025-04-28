# Utilisation de fonctions (2 heures)

## Principes de base
Les fonctions permettent de regrouper des blocs de code réutilisables, ce qui améliore la lisibilité et la structure des scripts. Elles facilitent la décomposition des tâches complexes en segments logiques et indépendants. Utiliser des fonctions permet aussi de réduire la duplication du code.

## Table des Matières

- [Utilisation de fonctions (2 heures)](#utilisation-de-fonctions-2-heures)
- [Principes de base](#principes-de-base)
- [Création de fonctions](#creation-de-fonctions)
- [Visibilité des variables](#visibilite-des-variables)
- [Passage de paramètres](#passage-de-parametres)
- [Exemples avancés](#exemples-avances)
    - [Manipulation de paramètres multiples](#manipulation-de-parametres-multiples)
    - [Retour d'une valeur depuis une fonction](#retour-dune-valeur-depuis-une-fonction)
    - [Utilisation de fonctions récursives](#utilisation-de-fonctions-recursives)

## Création de fonctions
La syntaxe standard pour définir une fonction en shell est la suivante :

```bash
nom_de_la_fonction() {
    # instructions
}
```

Cette structure vous permet d'encapsuler un comportement spécifique que vous pouvez réutiliser partout dans votre script.

## Visibilité des variables
Les variables déclarées à l'intérieur d'une fonction sont locales par défaut, ce qui signifie qu'elles ne sont accessibles qu'au sein de cette fonction. Pour partager une variable entre fonctions, déclarez-la à l'extérieur ou exportez-la si nécessaire :

```bash
message="Bonjour tout le monde"

afficher_message() {
    echo "$message"
}
```

Attention, certains shells peuvent avoir des comportements différents concernant la portée des variables.

## Passage de paramètres
Les fonctions peuvent recevoir des paramètres grâce aux variables positionnelles `$1`, `$2`, etc. Cela vous permet de transmettre des données dynamiques à la fonction :

```bash
ma_fonction() {
    echo "Le premier paramètre est : $1"
    echo "Le deuxième paramètre est : $2"
}
```

Vous pouvez également utiliser une boucle pour traiter un nombre variable de paramètres :

```bash
afficher_tous_params() {
    for param in "$@"; do
        echo "Paramètre: $param"
    done
}
```

## Exemples avancés

### 1. Manipulation de paramètres multiples
Utilisation des paramètres positionnels pour traiter un nombre inconnu d'arguments :

```bash
#!/bin/bash

traiter_arguments() {
    echo "Nombre d'arguments passés: $#"
    local compteur=1
    for arg in "$@"; do
        echo "Argument $compteur: $arg"
        compteur=$((compteur + 1))
    done
}

traiter_arguments "premier" "deuxième" "troisième"
```

### 2. Retour d'une valeur depuis une fonction
Bien que les fonctions shell ne puissent pas retourner directement des chaînes de caractères, il est possible de renvoyer des valeurs via la commande `echo` et de les capturer en utilisant des substitutions de commande :

```bash
#!/bin/bash

additionner() {
    local somme=$(( $1 + $2 ))
    echo $somme
}

resultat=$(additionner 5 7)
echo "Le résultat de l'addition est : $resultat"
```

### 3. Utilisation de fonctions récursives
Voici un exemple basique illustrant une fonction récursive qui calcule la factorielle d'un nombre :

```bash
#!/bin/bash

factorielle() {
    if [ "$1" -le 1 ]; then
        echo 1
    else
        local temp=$(factorielle $(( $1 - 1 )))
        echo $(( $1 * temp ))
    fi
}

nombre=5
resultat=$(factorielle $nombre)
echo "La factorielle de $nombre est : $resultat"
```