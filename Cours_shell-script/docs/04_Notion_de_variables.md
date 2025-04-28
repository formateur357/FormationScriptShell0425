# Notion de variables en shell

Les variables sont des éléments essentiels pour écrire des scripts efficaces en shell. Elles permettent de stocker, manipuler et transmettre des informations durant l'exécution des scripts. Ce document présente une vue d'ensemble complète sur l'utilisation, la création et la gestion des variables en shell.

## Table des matières
1. [Création et affectation](#création-et-affectation)
2. [Utilisation des variables](#utilisation-des-variables)
3. [Expansions avancées : syntaxe et exemples](#expansions-avancées--syntaxe-et-exemples)
4. [Variables numériques et arithmétiques](#variables-numériques-et-arithmétiques)
5. [Variables numériques et opérations sur les flottants](#variables-numériques-et-opérations-sur-les-flottants)
6. [Gestion des espaces, quotations et expansions](#gestion-des-espaces-quotations-et-expansions)
7. [Portée des variables et variables d'environnement](#portée-des-variables-et-variables-denvironnement)
8. [Variables spéciales et pseudo-variables](#variables-spéciales-et-pseudo-variables)
9. [Variables interactives et destruction](#variables-interactives-et-destruction)
10. [Variables avancées : tableaux et export](#variables-avancées--tableaux-et-export)

## Création et affectation

Pour définir une variable en shell, il suffit de lui attribuer une valeur en utilisant l'opérateur "=" sans espace avant et après. Voici les points essentiels :

1. Nommage des variables  
    - Le nom doit commencer par une lettre (a-z, A-Z) ou un underscore (_).  
    - Il peut contenir des lettres, des chiffres (0-9) et des underscores.  
    - Par convention, on utilise souvent des minuscules pour les variables locales et des majuscules pour les variables d'environnement ou spéciales.

2. Affectation simple  
    - Utilisez la syntaxe suivante sans espaces :
    ```bash
    nom="Alice"
    ```
    - Pour une valeur numérique, il est aussi possible d'écrire :
    ```bash
    age=30
    ```

3. Variables contenant des espaces ou des caractères spéciaux  
    - Utilisez des quotes pour préserver la valeur intégrale :
    ```bash
    message="Bonjour, comment vas-tu ?"
    ```
    - Les quotes simples ('') garantissent que rien n’est interprété :
    ```bash
    texte='Chez Alice, tout va bien'
    ```

4. Utilisation d'une variable  
    - Lors de l'accession à la valeur, préfixez le nom par un "$". Par exemple :
    ```bash
    echo "Salut, $nom"
    ```

5. Autres considérations  
    - Une variable définie est locale au shell ou au script courant, sauf si elle est exportée pour être utilisée par des sous-processus.
    - Vous pouvez modifier ou réassigner une variable, sauf si elle a été déclarée en lecture seule avec :
    ```bash
    declare -r PI=3.14
    ```
    - Pour s'assurer du type d'une variable, notamment pour les opérations arithmétiques, il est possible d'utiliser la commande "declare". Par exemple :
    ```bash
    declare -i age=30
    ```

### Utilisation de la commande declare

La commande `declare` de bash permet d'attribuer des attributs particuliers aux variables, contrôlant ainsi leur type, leur portée et leur comportement. Voici un tour d'horizon complet de ses options et utilisations pratiques :

1. Variables entières  
    - Utilisez l'option `-i` pour forcer une variable à être traitée comme entière.  
    - Exemples :
    ```bash
    declare -i age=30    # La variable sera évaluée en tant qu'entier.
    declare -i compteur   # La variable sera initialisée à 0 par défaut.
    compteur=5+3         # L'opération arithmétique est évaluée automatiquement.
    echo $compteur       # Affiche 8
    ```

2. Variables en lecture seule  
    - L'option `-r` déclare une variable en lecture seule.  
    - Une fois définie, sa valeur ne pourra pas être modifiée.
    ```bash
    declare -r PI=3.14   # Déclare PI comme une constante.
    # PI=3.1415         # Tentative de réaffectation générera une erreur.
    ```

3. Tableaux indexés et associatifs  
    - `-a` déclare un tableau indexé.
    ```bash
    declare -a fruits=("pomme" "banane" "cerise")
    echo "Premier fruit: ${fruits[0]}"
    ```
    - `-A` déclare un tableau associatif (disponible sur bash 4 et versions ultérieures).
    ```bash
    declare -A capitales
    capitales=([France]="Paris" [Italie]="Rome")
    echo "La capitale de France est ${capitales[France]}"
    ```

4. Variables exportées  
    - L'option `-x` exporte la variable pour qu'elle soit accessible par les sous-processus.
    ```bash
    declare -x chemin="/usr/local/bin"
    echo "La variable chemin est exportée vers les processus enfants."
    ```

5. Combinaison d'attributs  
    - Vous pouvez combiner plusieurs options pour définir diverses caractéristiques d'une variable.
    ```bash
    declare -ir nombre=10   # Variable entière et en lecture seule.
    # nombre=20           # Tentative de modification générera une erreur.
    ```

6. Vérification et débogage  
    - Pour afficher les attributs et la valeur des variables, vous pouvez utiliser `declare` sans argument ou avec un filtre.
    ```bash
    declare -p nombre     # Affiche la déclaration complète de la variable 'nombre'.
    declare -p         # Liste toutes les variables avec leurs attributs.
    ```

Ces différentes options offertes par la commande `declare` permettent d'écrire des scripts plus robustes et mieux structurés en contrôlant précisément le comportement des variables.

---
## Utilisation des variables

Pour référencer une variable dans un script shell, il convient d'utiliser le symbole `$` suivi du nom de la variable. Selon le contexte, l'usage simple ou combiné avec des accolades peut s'avérer nécessaire.

### Référencement simple

Utiliser directement le nom de la variable avec `$` permet d'insérer sa valeur dans une commande ou une chaîne de caractères :
```bash
echo "Bonjour, $nom"
```
Ce mode de référence est adapté lorsque le nom de la variable est isolé et que le shell peut aisément en déduire la fin.

### Utilisation des accolades

Lorsqu'il est nécessaire d'assurer la séparation du nom de la variable d'un texte adjacent ou pour éviter toute ambiguïté, il faut alors envelopper le nom de la variable entre accolades `{}` :
```bash
echo "Le nom est ${nom}Smith"
```
Cela garantit que seul le contenu entre `{}` est interprété comme la variable, et que le texte suivant (ici, "Smith") ne fait pas partie du nom.

### Cas particuliers et pratiques avancées

1. Délimiteur pour concaténation :  
Quand vous souhaitez combiner la variable avec d'autres chaînes sans espace, les accolades clarifient cette concaténation.
```bash
prefix="pre"
echo "${prefix}fix"
```

2. Valeurs par défaut et tests :  
Les accolades permettent également d'inclure des options d'expansion avancée, telles que la définition d'une valeur par défaut.
```bash
echo "Nom: ${nom:-Inconnu}"
```
Cette syntaxe affiche "Inconnu" si la variable nom n'est pas définie ou est vide.

3. Longueur d'une chaîne :  
Pour obtenir la longueur de la valeur stockée dans une variable, l'expansion avec `#` est utilisée à l'intérieur des accolades.
```bash
echo "Longueur du nom: ${#nom}"
```

4. Expansion complexe :  
Vous pouvez utiliser des expansions pour manipuler le contenu des variables, comme enlever une partie d'une chaîne.
```bash
chemin="/usr/local/bin"
echo "Répertoire: ${chemin%/*}"   # Supprime la partie après le dernier '/'
```
## Expansions avancées : syntaxe et exemples

L'expansion des variables en shell permet de manipuler et transformer dynamiquement le contenu d’une variable. Voici les principales syntaxes d'expansion et leurs explications :

1. Valeurs par défaut et alternatives  
    - ${variable:-valeur} : Utilise « valeur » si la variable n'est pas définie ou est vide.  
      Exemple :
      ```bash
      echo "Nom : ${nom:-Inconnu}"
      ```
    - ${variable:=valeur} : Assigne « valeur » à la variable si elle n'est pas définie ou vide, puis renvoie cette valeur.  
      Exemple :
      ```bash
      echo "Nom : ${nom:=Inconnu}"
      ```
    - ${variable:+valeur} : Renvoie « valeur » si la variable est définie et non vide, sinon renvoie rien.  
      Exemple :
      ```bash
      echo "Bonjour ${nom:+utilisateur}"
      ```
    - ${variable:?message} : Affiche un message d'erreur personnalisé et interrompt le script si la variable n'est pas définie ou vide.  
      Exemple :
      ```bash
      echo "Nom : ${nom:?La variable nom doit être définie}"
      ```

2. Extraction et longueur de la chaîne  
    - ${#variable} : Renvoie la longueur de la valeur stockée dans la variable.  
      Exemple :
      ```bash
      echo "Longueur du nom : ${#nom}"
      ```
    - ${variable:offset} et ${variable:offset:longueur} : Extrait une sous-chaîne à partir de « offset » (position de départ) et sur « longueur » caractères.  
      Exemple :
      ```bash
      chaine="Bonjour"
      echo "Extrait : ${chaine:1:3}"  # Affiche "onj"
      ```

3. Suppression de motifs  
    - ${variable#motif} et ${variable##motif} : Supprime depuis le début de la chaîne le plus court (#) ou le plus long (##) motif qui correspond.  
      Exemple :
      ```bash
      fichier="/usr/local/bin/script.sh"
      echo "Nom du fichier : ${fichier##*/}"  # Affiche "script.sh"
      ```
    - ${variable%motif} et ${variable%%motif} : Supprime depuis la fin de la chaîne le plus court (%) ou le plus long (%%) motif correspondant.  
      Exemple :
      ```bash
      chemin="/usr/local/bin/script.sh"
      echo "Répertoire : ${chemin%/*}"  # Affiche "/usr/local/bin"
      ```

4. Remplacement de motifs  
    - ${variable/pattern/remplacement} : Remplace la première occurrence du motif par la chaîne de remplacement.  
      Exemple :
      ```bash
      texte="Bienvenue dans le shell"
      echo "${texte/ shell/ Bash}"  # Affiche "Bienvenue dans Bash"
      ```
    - ${variable//pattern/remplacement} : Remplace toutes les occurrences du motif par la chaîne de remplacement.  
      Exemple :
      ```bash
      texte="un test, un test, un test"
      echo "${texte//test/exemple}"  # Affiche "un exemple, un exemple, un exemple"
      ```

Ces syntaxes d’expansion permettent d’assurer que les variables renvoient toujours une valeur cohérente, facilitent l'extraction d'informations spécifiques et renforcent la robustesse des scripts en shell.


---

## Variables numériques et arithmétiques

Les variables numériques peuvent être manipulées en utilisant l'arithmétique intégrée du shell.
```bash
a=5
b=10
result=$(( a + b ))
echo "Le résultat est $result"
```
Cela permet d’effectuer des calculs sans faire appel à des commandes externes.

---

## Variables numériques et opérations sur les flottants

Les arithmétiques natives avec $(( ... )) ne supportent que les entiers en shell. Pour effectuer des opérations sur des nombres à virgule, on peut utiliser la commande externe bc. Par exemple :

```bash
a=5.2
b=3.4
result=$(echo "scale=2; $a + $b" | bc)
echo "Le résultat est $result"
```

Dans cet exemple, "scale=2" permet de fixer la précision à 2 décimales. Vous pouvez adapter cette méthode pour réaliser diverses opérations sur des flottants.

## Gestion des espaces, quotations et expansions

Les guillemets influencent la manière dont le shell interprète le contenu :

- Les doubles quotes ("") : les variables y sont développées.
```bash
echo "Bonjour, $nom"
```
- Les quotes simples ('') : le contenu est interprété littéralement.
```bash
echo 'Bonjour, $nom'
```

---

## Portée des variables et variables d'environnement

### Variables locales et globales

Par défaut, les variables définies dans un script sont locales à ce script. Pour les rendre accessibles aux processus enfants :
```bash
export nom
```

### Variables d'environnement

Les variables d'environnement sont accessibles à tous les processus lancés à partir du shell. Par exemple :
```bash
export PATH="/usr/local/bin:$PATH"
```
Veillez à utiliser `export` pour transmettre la variable aux sous-processus.

---

## Variables spéciales et pseudo-variables

Le shell définit plusieurs variables spéciales et pseudo-variables qui facilitent la gestion du script :

- `$0` : Nom du script.
- `$1`, `$2`, ... : Arguments passés au script.
- `$#` : Nombre d'arguments.
- `$?` : Code de retour de la dernière commande.
- `$$` : PID du script.

Ces variables sont particulièrement utiles pour le débogage et le contrôle du flux du script.

---

## Variables interactives et destruction

### Affectation interactive

Vous pouvez demander à l’utilisateur de saisir une valeur via la commande `read` :
```bash
read -p "Entrez votre nom: " nom
echo "Bonjour, $nom"
```

### Destruction des variables

Pour supprimer une variable, utilisez la commande `unset` :
```bash
unset nom
```
Cela permet de libérer la mémoire ou d’éviter des conflits de noms dans de longs scripts.

---

## Variables avancées : tableaux et export

### Tableaux

Bash supporte les tableaux indexés. Par exemple :
```bash
# Déclaration d'un tableau
fruits=("pomme" "banane" "cerise")

# Accès à un élément
echo "Premier fruit: ${fruits[0]}"

# Parcourir le tableau
for fruit in "${fruits[@]}"; do
    echo "Fruit: $fruit"
done
```

### Commandes d'exportation

Au-delà d’exporter une variable pour en faire une variable d'environnement, la commande `env` affiche l’ensemble des variables disponibles :
```bash
env | grep NOM
```
Cela vous permet de vérifier la propagation des variables dans vos processus enfants.
