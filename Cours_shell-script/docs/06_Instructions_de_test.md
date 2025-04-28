## Instructions de test en Shell Scripting

Les instructions de test sont essentielles pour contrôler le flux d’un script en évaluant des conditions. Elles permettent de vérifier l'existence de fichiers, comparer des valeurs ou évaluer des chaînes de caractères, entre autres.

## Table des Matières

1. [Instructions de test en Shell Scripting](#instructions-de-test-en-shell-scripting)
2. [Tests sur les fichiers et répertoires](#tests-sur-les-fichiers-et-répertoires)
    - [a. Test d'existence](#a-test-dexistence)
    - [b. Test de type](#b-test-de-type)
    - [c. Test de permission](#c-test-de-permission)
3. [Tests sur les nombres entiers](#tests-sur-les-nombres-entiers)
    - [a. Comparaison de nombres](#a-comparaison-de-nombres)
    - [b. Opérations arithmétiques](#b-operations-arithmetiques)
4. [Tests sur les chaînes de caractères](#tests-sur-les-chaines-de-caracteres)
    - [a. Comparaison de chaînes](#a-comparaison-de-chaines)
    - [b. Vérification de la longueur](#b-verification-de-la-longueur)
    - [c. Vérification d'une chaîne vide](#c-verification-dune-chaine-vide)
    - [d. Vérification d'une chaîne non vide](#d-verification-dune-chaine-non-vide)
    - [e. Comparaison avancée avec [[ ]]](#e-comparaison-avancee-avec)

### 1. Tests sur les fichiers et répertoires

Voici un rappel des commandes et options utiles pour les conditions de tests en Shell (utilisées via le mot-clé test ou les crochets [ ]):

• Commande générale de test :
    - test EXPRESSION
    - [ EXPRESSION ]

• Options courantes :
    - -e : vérifie l'existence du fichier ou répertoire.
    - -f : vérifie si c'est un fichier régulier.
    - -d : vérifie si c'est un répertoire.
    - -L : vérifie s'il s'agit d'un lien symbolique.
    - -r : vérifie si le fichier est lisible.
    - -w : vérifie si le fichier est modifiable (inscriptible).
    - -x : vérifie si le fichier est exécutable.
    - -c, -b : vérifient respectivement si le fichier est un périphérique caractère ou bloc.

#### a. Test d'existence

La commande principale pour vérifier l'existence d'une cible est :
    • test -e "nom_de_fichier" ou [ -e "nom_de_fichier" ]
Cette option renvoie vrai si l’élément spécifié existe (fichier, répertoire, lien symbolique, etc.).

Exemple :
    • Vérification de l'existence de "exemple.txt" :

```bash code
if [ -e "exemple.txt" ]; then
    echo "exemple.txt existe."
else
    echo "exemple.txt n'existe pas."
fi
```

#### b. Test de type

Pour déterminer le type de cible, on utilise les options suivantes :
    • -f pour un fichier régulier.
    • -d pour un répertoire.
    • -L pour un lien symbolique.
Ces tests aident à différencier rapidement le type d’une entité.

Exemple :
    • Test pour différencier un fichier et un répertoire :

```bash code
if [ -f "exemple.txt" ]; then
if [[ -f "exemple."* ]]; then
    echo "exemple.txt est un fichier régulier."
elif [ -d "exemple.txt" ]; then
    echo "exemple.txt est un répertoire."
else
    echo "exemple.txt n'est ni un fichier ni un répertoire."
fi
```

#### c. Test de permission

Pour vérifier les permissions d'accès, plusieurs options sont disponibles :
    • -r : teste si le fichier ou répertoire est lisible.
    • -w : teste s'il est écrivable (modifiable).
    • -x : teste s'il est exécutable.
Ces options permettent de s’assurer que les opérations prévues sur les fichiers pourront être réalisées.

Exemple :
    • Vérification des permissions sur "exemple.txt" :

```bash code
if [ -r "exemple.txt" ]; then
    echo "exemple.txt est lisible."
else
    echo "exemple.txt n'est pas lisible."
fi

if [ -w "exemple.txt" ]; then
    echo "exemple.txt est modifiable."
else
    echo "exemple.txt n'est pas modifiable."
fi

if [ -x "exemple.txt" ]; then
    echo "exemple.txt est exécutable."
else
    echo "exemple.txt n'est pas exécutable."
fi
```

Exemple :
    • Vérification si "exemple.txt" est lisible et exécutable :

```bash code
if [ -r "exemple.txt" ]; then
    echo "exemple.txt est lisible."
fi

if [ -x "exemple.txt" ]; then
    echo "exemple.txt est exécutable."
fi
```

### 2. Tests sur les nombres entiers

Voici une liste des commandes et opérateurs les plus utiles pour les tests sur les nombres entiers :

• Comparaison arithmétique avec les crochets [ ] ou la commande test :
  - -eq : égal à
  - -ne : différent de
  - -gt : supérieur à
  - -ge : supérieur ou égal à
  - -lt : inférieur à
  - -le : inférieur ou égal à

Ces opérateurs sont utilisés directement dans les conditions pour comparer deux valeurs numériques.

#### a. Comparaison de nombres

Exemple de comparaison pour déterminer le plus petit nombre :

```bash code
NUM1=10  
NUM2=20

if [ $NUM1 -lt $NUM2 ]; then  
    echo "$NUM1 est inférieur à $NUM2."  
fi
```

D'autres comparaisons utiles peuvent être mises en place à l'aide des opérateurs cités pour vérifier l'égalité ou les différences entre deux entiers.

#### b. Opérations arithmétiques

Plusieurs commandes facilitent le calcul dans le script :

• Utilisation de l'expansion arithmétique :  

```bash code
SUM=$((NUM1 + NUM2))
```

Cette méthode permet d'effectuer des calculs directement et de stocker la valeur dans une variable.

• La commande let (alternative) :

```bash code
let SUM=NUM1+NUM2
```

Permet de réaliser des opérations arithmétiques sans expansion supplémentaire.

• La commande expr (option historique) :

```bash code
SUM=$(expr $NUM1 + $NUM2)
```

Bien que moins utilisée aujourd'hui, elle offre une autre syntaxe pour les opérations.

Exemple d'addition de deux nombres :

```bash code
NUM1=10  
NUM2=20

SUM=$((NUM1 + NUM2))  
echo "La somme de $NUM1 et $NUM2 est $SUM."
```

### 3. Tests sur les chaînes de caractères

Les tests sur les chaînes de caractères permettent de comparer, vérifier l’état ou mesurer des chaînes dans un script Shell. Les commandes de test sont généralement exécutées avec la syntaxe [ EXPRESSION ] ou avec test directement. Voici les commandes et options les plus utiles avant les exemples :

• Comparaison de chaînes avec [ ] :
  - "==" : vérifie l’égalité stricte entre deux chaînes.
  - "!=" : vérifie la différence entre deux chaînes.

• Vérification de la présence ou de l’absence d’une valeur :
  - -z : teste si la chaîne est vide (de longueur nulle).
  - -n : teste si la chaîne n’est pas vide.

• Calcul de la longueur d’une chaîne :
  - ${#variable} : renvoie le nombre de caractères contenus dans la variable.

Ces commandes permettent d’effectuer des tests conditionnels efficaces sur les chaînes de caractères.

#### a. Comparaison de chaînes
Permet de vérifier l’égalité ou la différence entre deux chaînes.

Exemple :  

```bash code
STR1="Bonjour"  
STR2="Bonjour"
  
if [ "$STR1" == "$STR2" ]; then  
    echo "Les chaînes sont identiques."  
else  
    echo "Les chaînes sont différentes."  
fi
```

#### b. Vérification de la longueur  
Il est parfois nécessaire de connaître la longueur d'une chaîne pour prendre des décisions dans le script.

```bash code
STR1="Bonjour"  
LENGTH=${#STR1}
echo "La longueur de la chaîne '$STR1' est $LENGTH caractères."
```

#### c. Vérification d'une chaîne vide  
Utilisez l'option -z pour tester si une chaîne est vide.

```bash code
VAR=""  
if [ -z "$VAR" ]; then  
    echo "La variable est vide."  
else  
    echo "La variable n'est pas vide."  
fi
```

#### d. Vérification d'une chaîne non vide  
L'option -n permet de vérifier si une chaîne n'est pas vide.

```bash code
VAR="Bonjour"  
if [ -n "$VAR" ]; then  
    echo "La variable n'est pas vide."  
else  
    echo "La variable est vide."  
fi
```

#### e. Comparaison avancée avec [[ ]]  
La construction [[ ]] offre plus de souplesse pour la comparaison, notamment en autorisant la syntaxe de correspondance de motifs et l'absence de problèmes liés aux espaces ou aux caractères spéciaux.

Exemple :  

```bash code
STR="Bonjour le monde"  
if [[ "$STR" == *"le monde"* ]]; then  
    echo "La chaîne contient 'le monde'."  
else  
    echo "La chaîne ne contient pas 'le monde'."  
fi
```
