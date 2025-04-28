# Cours sur les Scripts Shell

Ce cours présente les concepts fondamentaux d'un script shell, de son intérêt à ses différents composants et structures de commande.

# Table des matières

1. [Cours sur les Scripts Shell](#cours-sur-les-scripts-shell)
2. [Intérêts d’un script](#interets-dun-script)
3. [Éléments d’un script](#elements-dun-script)
4. [En-tête et Choix de l'Interpréteur](#en-tete-et-choix-de-linterpreteur)
5. [Commentaires et Bonnes Pratiques](#commentaires-et-bonnes-pratiques)
6. [Affectations](#affectations)
7. [Définition et appels de fonctions](#definition-et-appels-de-fonctions)
8. [Commandes](#commandes)
9. [Structures de contrôle](#structures-de-controle)

## Intérêts d’un script

Les scripts shell offrent plusieurs avantages :
- L'automatisation des tâches répétitives.
- La gestion centralisée et efficace du système.
- La personnalisation des opérations selon les besoins.
- La simplification et la sécurisation des processus administratifs.

## Éléments d’un script

Un script shell typique contient les éléments suivants :
1. En-tête
2. Commentaires
3. Affectations
4. Définition et appels de fonctions
5. Commandes
6. Structures de contrôle

```bash
#!/bin/bash
# -------------------------
# En-tête : Indique à quel interpréteur le script doit être envoyé.
# -------------------------

# Commentaires : Explique le fonctionnement du script.
# Ce script salue un utilisateur et vérifie son identité.

# Affectations : Stocke des valeurs dans des variables.
utilisateur="Alice"

# Définition de fonction : Affiche un message de bienvenue personnalisé.
saluer() {
  echo "Bonjour, $1 !"
}

# Appel de la fonction avec une variable.
saluer "$utilisateur"

# Commandes : Affiche quelques informations.
echo "Affichage du répertoire courant :"
pwd

# Structures de contrôle : Vérifie le nom de l'utilisateur et réagit en conséquence.
if [ "$utilisateur" = "Alice" ]; then
  echo "Accès autorisé pour Alice."
else
  echo "Accès refusé."
fi
```

## En-tête et Choix de l'Interpréteur

L'en-tête, communément appelé Shebang, détermine l'interpréteur qui exécutera le script. Ce choix est crucial pour garantir la compatibilité et le comportement attendu du script. Voici quelques interpréteurs populaires et leurs spécificités :

### 1. Bash (Bourne Again SHell)
Bash est probablement l'interpréteur de script le plus utilisé en environnement Linux. Il offre une syntaxe étendue et de nombreuses fonctionnalités modernes.

Exemple :
```bash
#!/bin/bash
echo "Script exécuté avec Bash."
```

### 2. Sh (Bourne Shell)
Sh est une version plus ancienne et plus épurée, souvent utilisée pour des scripts POSIX. Bien que moins riche en fonctionnalités que Bash, il assure une compatibilité plus large sur divers systèmes Unix.

Exemple :
```bash
#!/bin/sh
echo "Script exécuté avec Sh."
```

### 3. Utilisation de /usr/bin/env
L'utilisation de `/usr/bin/env` permet de rechercher l'interpréteur dans le PATH de l'utilisateur. Cette pratique est utile pour garantir que le script utilise l'interpréteur attendu même si son emplacement varie d'un système à l'autre.

Exemple avec Bash :
```bash
#!/usr/bin/env bash
echo "Script exécuté avec Bash via env."
```

Exemple avec Sh :
```bash
#!/usr/bin/env sh
echo "Script exécuté avec Sh via env."
```

### 4. Autres Interpréteurs
- **KornShell (ksh)** : Combine des fonctionnalités de Bourne Shell et de C Shell, souvent utilisé dans certains systèmes UNIX traditionnels.
  
  Exemple :
  ```bash
  #!/usr/bin/env ksh
  echo "Script exécuté avec KornShell."
  ```

- **Z Shell (zsh)** : Offrant de nombreuses fonctionnalités interactives supplémentaires, zsh est de plus en plus populaire pour les scripts et la ligne de commande interactive.
  
  Exemple :
  ```bash
  #!/usr/bin/env zsh
  echo "Script exécuté avec Z Shell."
  ```

Sélectionner le bon interpréteur dépend de vos besoins en fonctionnalités et de la compatibilité que vous souhaitez garantir sur les systèmes cibles.

## Commentaires et Bonnes Pratiques

Les commentaires sont essentiels pour améliorer la lisibilité et la maintenabilité de vos scripts. Ils permettent de décrire l’intention du code, d’expliquer des parties complexes et de délimiter clairement les sections fonctionnelles. Voici un exemple de script avec des commentaires bien structurés :

```bash
#!/bin/bash
# ------------------------------------------------------------------
# Description : Vérifie si l'utilisateur possède les droits administratifs.
# Auteur      : Votre Nom
# Date        : 2023-10-05
# ------------------------------------------------------------------

utilisateur="Alice"

# Vérification du privilège administrateur
if [ "$utilisateur" = "admin" ]; then
  echo "Accès autorisé pour l'administrateur."
else
  echo "Accès refusé : droits insuffisants."
fi

# Fin du script
```

Quelques points à retenir :
- Utilisez des blocs de commentaires pour décrire l’objectif global du script et l’auteur.
- Commentez chaque section ou bloc de code pour expliquer son rôle.
- Évitez les commentaires évidents. Privilégiez ceux qui ajoutent une réelle valeur en expliquant le pourquoi et non le comment.
- Mettez à jour les commentaires lors des modifications du code pour éviter toute désinformation.

Ces pratiques facilitent la compréhension par d'autres développeurs et aident lors du dépannage ou de l’extension du script.


## Affectations

Les affectations en shell permettent de stocker des valeurs dans des variables, facilitant ainsi leur réutilisation et rendant vos scripts plus dynamiques. Voici différentes manières de les utiliser :

### 1. Affectation de chaînes de caractères
Attribuez directement une chaîne de caractères à une variable.

Exemple :
```bash
nom_utilisateur="morganguy"
echo "Bonjour, $nom_utilisateur"
```

### 2. Affectation par substitution de commande
Vous pouvez assigner le résultat d'une commande à une variable en utilisant la substitution de commande.

Exemple :
```bash
date_actuelle=$(date +%Y-%m-%d)
echo "Date du jour : $date_actuelle"
```

### 3. Affectation arithmétique
Utilisez l'expansion arithmétique pour effectuer des calculs et stocker le résultat dans une variable.

Exemple :
```bash
nombre=5
resultat=$(( nombre * 2 ))
echo "Le double de $nombre est $resultat"
```

### 4. Affectation et exportation d'une variable
Pour rendre une variable accessible à des sous-processus, exportez-la.

Exemple :
```bash
export chemin="/usr/local/bin"
echo "Le chemin exporté est : $chemin"
```

### 5. Affectation avec expansion de paramètres
Utilisez des expressions comme la substitution de valeur par défaut pour gérer les cas où une variable pourrait être vide ou non définie.

Exemple :
```bash
# Si la variable 'utilisateur' n'est pas définie, utiliser "invité" par défaut.
utilisateur=${utilisateur:-invité}
echo "Bonjour, $utilisateur"
```

Ces différentes approches augmentent la flexibilité de vos scripts en vous permettant d'adapter les affectations selon les besoins.

## Définition et appels de fonctions

Les fonctions permettent de regrouper un ensemble de commandes sous un même nom pour faciliter la réutilisation du code, l’organisation et la lisibilité de vos scripts. Elles peuvent accepter des arguments, retourner un code de sortie et interagir avec des variables globales. Voici quelques points détaillés sur leur utilisation :

### Définition de fonction

La syntaxe de base pour définir une fonction est la suivante :
```bash
nom_de_fonction() {
  # Ensemble des commandes à exécuter
  echo "Exemple de fonction"
}
```
Notez que l'utilisation des parenthèses est facultative, mais elle clarifie l'intention.

### Passage d'arguments

Les fonctions récupèrent les paramètres passés lors de leur appel via des variables positionnelles :
- $1, $2, … pour accéder aux arguments individuels.
- "$@" pour récupérer l'ensemble des arguments sous forme de liste.
  
Exemple :
```bash
#!/bin/bash
saluer() {
  # Récupération du premier argument
  local nom="$1"
  echo "Bonjour, $nom"
}

# Appel de la fonction avec un argument
saluer "Alice"
```
Utiliser la commande "local" permet de définir des variables à portée locale à la fonction, empêchant ainsi des collisions avec des variables globales.

### Retour de valeurs

Contrairement à d'autres langages, une fonction shell ne retourne pas directement une valeur mais un code de sortie (0 pour le succès). Pour renvoyer des résultats, il est courant d’utiliser l’écho ou d’affecter une variable globale.

Exemple avec code de sortie :
```bash
#!/bin/bash
est_pair() {
  if [ $(( $1 % 2 )) -eq 0 ]; then
    return 0
  else
    return 1
  fi
}

nombre=4
if est_pair "$nombre"; then
  echo "$nombre est pair."
else
  echo "$nombre est impair."
fi
```

Exemple avec sortie via echo :
```bash
#!/bin/bash
additionner() {
  local somme=$(( $1 + $2 ))
  echo "$somme"
}

resultat=$(additionner 3 5)
echo "La somme est $resultat"
```

### Utilisation des variables globales et locales

Par défaut, une variable déclarée dans une fonction est globale. Pour éviter des effets secondaires, utilisez le mot-clé "local" pour limiter la portée d'une variable à la fonction :
```bash
#!/bin/bash
modifier() {
  local variable_locale="Je suis limitée ici"
  variable_globale="Je peux être utilisée partout"
  echo "$variable_locale"
}

variable_globale="Initiale"
modifier
echo "$variable_globale"
```

### Bonnes pratiques

- Déclarez toujours vos variables à l’aide de "local" dans les fonctions pour limiter l’impact sur le reste du script.
- Vérifiez les paramètres d'entrée et traitez les cas d'erreur (par exemple, en affichant un message d'utilisation si les arguments sont manquants).
- Documentez votre fonction avec des commentaires explicites pour décrire son comportement, ses paramètres et son code de sortie.
- Utilisez des noms de fonction explicites qui décrivent bien leur rôle.

Ce niveau de détails vous permettra de mieux structurer et maintenir vos scripts shell tout en vous assurant d’une utilisation cohérente des fonctions.


## Commandes

Le cœur d’un script est constitué de commandes que le shell exécute. Chaque ligne peut contenir une ou plusieurs commandes :
```bash
#!/bin/bash
ls -l
pwd
```

## Structures de contrôle

Les structures de contrôle permettent de gérer le flux d'exécution du script en fonction de conditions ou de boucles.

### Structures conditionnelles
```bash
#!/bin/bash
if [ "$nom" = "Alice" ]; then
  echo "Bienvenue Alice"
else
  echo "Vous n'êtes pas Alice"
fi
```

### Boucles
```bash
#!/bin/bash
for i in {1..5}; do
  echo "Iteration $i"
done
```

