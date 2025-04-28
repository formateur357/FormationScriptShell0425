## Instructions d'exécution conditionnelle en Shell Scripting

Les instructions conditionnelles permettent d'adapter le comportement d'un script selon différentes situations. Elles facilitent la prise de décision dans vos scripts en fonction des états du système, de la présence de fichiers, ou des valeurs de variables.

## Table des Matières

- [Instructions d'exécution conditionnelle en Shell Scripting](#instructions-dexecution-conditionnelle-en-shell-scripting)
    - [1. Structure `if`](#1-structure-if)
        - [Syntaxe de base](#syntaxe-de-base)
        - [Exemple simple](#exemple-simple)
        - [Utilisation de `else`](#utilisation-de-else)
        - [Utilisation de `elif`](#utilisation-de-elif)
        - [Niveaux d'imbrication](#niveaux-dimbrication)
    - [2. Structure `case`](#2-structure-case)
        - [Syntaxe de base](#syntaxe-de-base-1)
        - [Exemple interactif](#exemple-interactif)
        - [Exemple avec expansion de motif](#exemple-avec-expansion-de-motif)
    - [3. Conseils et Bonnes Pratiques](#3-conseils-et-bonnes-pratiques)
    - [4. Autres Structures Conditionnelles](#4-autres-structures-conditionnelles)
        - [La commande `[[ ]]`](#la-commande)
        - [Conditions Composées](#conditions-composees)
            - [Exemple avec &&](#exemple-avec-et)
            - [Exemple avec ||](#exemple-avec-ou)
            - [Exemple avec regroupement et [[ ]]](#exemple-avec-regroupement-et-doubles-crochets)
        - [Utilisation de -a et -o](#utilisation-de-a-et-o)

### 1. Structure `if`

La structure `if` teste une condition et exécute un bloc de commandes seulement si cette condition est vraie.

#### Syntaxe de base

```bash
if [ condition ]; then
    # commande(s) à exécuter si la condition est vraie
fi
```

#### Exemple simple

```bash
#!/bin/bash

# Vérifie si un fichier existe
if [ -e "mon_fichier.txt" ]; then
    echo "Le fichier existe."
fi
```

#### Utilisation de `else`

Il est souvent utile de traiter le cas où la condition est fausse.

```bash
#!/bin/bash

if [ -e "mon_fichier.txt" ]; then
    echo "Le fichier existe."
else
    echo "Le fichier n'existe pas."
fi
```

#### Utilisation de `elif`

Pour tester plusieurs conditions en chaîne, on peut utiliser `elif`.

```bash
#!/bin/bash

if [ -e "fichier1.txt" ]; then
    echo "fichier1.txt existe."
elif [ -e "fichier2.txt" ]; then
    echo "fichier2.txt existe."
else
    echo "Aucun des fichiers n'existe."
fi
```

#### Niveaux d'imbrication

Les structures `if` peuvent être imbriquées pour traiter des cas plus complexes.

```bash
#!/bin/bash

if [ -e "config.txt" ]; then
    echo "Fichier de configuration trouvé."
    if [ -s "config.txt" ]; then
        echo "Le fichier n'est pas vide."
    else
        echo "Le fichier est vide."
    fi
else
    echo "Aucun fichier de configuration n'a été trouvé."
fi
```

### 2. Structure `case`

La structure `case` offre une alternative plus lisible lorsque plusieurs valeurs d'une variable doivent être testées.

#### Syntaxe de base

```bash
case variable in
    motif1)
        # commandes si la variable correspond à motif1
        ;;
    motif2)
        # commandes si la variable correspond à motif2
        ;;
    *)
        # commandes par défaut si aucun motif ne correspond
        ;;
esac
```

#### Exemple interactif

```bash
#!/bin/bash

read -p "Entrez un jour de la semaine : " jour

case $jour in
    lundi)
        echo "Début de la semaine."
        ;;
    vendredi)
        echo "Presque le week-end."
        ;;
    samedi|dimanche)
        echo "C'est le week-end !"
        ;;
    *)
        echo "Veuillez entrer un jour valide."
        ;;
esac
```

#### Exemple avec expansion de motif

Vous pouvez utiliser des jokers pour accepter plusieurs valeurs similaires :

```bash
#!/bin/bash

read -p "Entrez une lettre (a, b, c) : " lettre

case $lettre in
    [aA])
        echo "Vous avez choisi la lettre A."
        ;;
    [bB])
        echo "Vous avez choisi la lettre B."
        ;;
    [cC])
        echo "Vous avez choisi la lettre C."
        ;;
    *)
        echo "Lettre non reconnue."
        ;;
esac
```

### 3. Conseils et Bonnes Pratiques

- Assurez-vous de bien espacer la syntaxe, notamment autour des crochets (par exemple `[ condition ]`).
- Utilisez des guillemets autour des variables pour éviter des problèmes avec les espaces ou caractères spéciaux (ex. `if [ "$variable" = "valeur" ]; then`).
- Privilégiez la clarté du code en commentant vos scripts et en structurant les conditions de façon logique.
- Testez toujours vos scripts dans un environnement de développement avant de les exécuter en production.

### 4. Autres Structures Conditionnelles

#### La commande `[[ ]]`

La commande `[[ ]]` est une extension du test conditionnel qui offre quelques avantages supplémentaires par rapport à `[ ]`.

```bash
#!/bin/bash

if [[ "$nom" == "GitHub Copilot" ]]; then
    echo "Bienvenue, GitHub Copilot !"
fi
```
Les doubles crochets ([[ ]]) offrent plusieurs avantages par rapport aux simples crochets ([ ]), notamment :

- Une syntaxe plus intuitive pour manipuler des expressions régulières et des conditions complexes.
- Une gestion améliorée de l'expansion de globbing et des espaces, réduisant ainsi les erreurs potentielles.
- Une meilleure sécurité lors des tests de chaînes en évitant les problèmes liés à l'absence ou aux espaces dans les variables.

Par exemple, l'utilisation d'une expression régulière dans un test conditionnel devient très naturelle :

```bash
#!/bin/bash

chaine="12345"
if [[ $chaine =~ ^[0-9]+$ ]]; then
    echo "La chaîne contient uniquement des chiffres."
fi
```

Ces avantages rendent les doubles crochets particulièrement utiles pour écrire des scripts plus robustes et lisibles.

#### Conditions Composées

Dans les scripts Shell, il est souvent nécessaire de tester plusieurs conditions dans une seule instruction. Pour cela, on peut combiner des tests en utilisant des opérateurs logiques :

• L’opérateur && (ET) : La commande située à droite est exécutée uniquement si celle de gauche réussit (renvoie 0).  
• L’opérateur || (OU) : La commande située à droite est exécutée uniquement si celle de gauche échoue (renvoie une valeur non-nulle).

Les opérateurs && et || permettent de chaîner plusieurs tests de manière concise.

Exemple avec && :

```bash
#!/bin/bash

if [ -e "script.sh" ] && [ -x "script.sh" ]; then
    echo "Le script existe et est exécutable."
fi
```

Dans cet exemple, le script vérifie d’abord l’existence du fichier grâce à -e, puis son exécution grâce à -x. Le bloc de commandes ne s’exécute que si les deux conditions sont vraies.

Exemple avec || :

```bash
#!/bin/bash

if [ ! -e "script.sh" ] || [ ! -x "script.sh" ]; then
    echo "Le script n'existe pas ou n'est pas exécutable."
fi
```

Ici, le test vérifie si le fichier n'existe pas (grâce à !) ou s’il n’est pas exécutable. Si l’une des conditions est vraie, le message s’affiche.

Pour des conditions plus complexes, il convient parfois de regrouper les tests à l’aide de parenthèses. Attention : dans Bash, utilisez des parenthèses échappées ou la syntaxe [[ ]] pour éviter les erreurs de syntaxe :

Exemple avec regroupement et [[ ]] :

```bash
#!/bin/bash

if [[ (-e "script.sh" && -x "script.sh") || "$force" == "true" ]]; then
    echo "Le script est valide ou le mode forcé est activé."
fi
```

Ici, la condition teste si le fichier existe et est exécutable, ou si la variable force vaut "true". L’utilisation de [[ ]] permet une syntaxe plus souple et évite certains pièges liés aux expansions de variables.

Notez qu'il est également possible d'utiliser des opérateurs internes des crochets simples tels que -a (ET) et -o (OU), mais leur utilisation est moins recommandée à cause de leur ambiguïté et de problèmes potentiels de lisibilité :

```bash
#!/bin/bash

if [ -e "script.sh" -a -x "script.sh" ]; then
    echo "Le script existe et est exécutable."
fi
```

Il est donc conseillé de privilégier les opérateurs && et || ou la syntaxe [[ ]] pour des scripts plus robustes et plus lisibles.

```
