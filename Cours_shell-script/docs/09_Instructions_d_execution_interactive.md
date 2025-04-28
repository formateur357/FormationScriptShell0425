## Instructions d'exécution interactive en Shell Scripting

Les instructions d'exécution interactive permettent d'écrire des scripts qui s’adaptent aux besoins de l'utilisateur. Elles reposent principalement sur des boucles et des conditions pour répéter des actions et gérer des entrées en temps réel. Voici plusieurs approches et exemples détaillés.

**Table des matières**

1. [Lecture de l'entrée utilisateur](#1-lecture-de-lentree-utilisateur)
2. [La boucle `for`](#2-la-boucle-for)
3. [La boucle `while`](#3-la-boucle-while)
4. [La boucle `until`](#4-la-boucle-until)
5. [Le menu interactif avec `select`](#5-le-menu-interactif-avec-select)

---

### 1. Lecture de l'entrée utilisateur

Avant toute boucle, il est souvent nécessaire de demander des informations à l'utilisateur. La commande `read` permet de capturer une entrée.

**Exemple :**
```bash
#!/bin/bash
echo "Quel est votre nom ?"
read nom
echo "Bonjour, $nom !"
```

---

### 2. La boucle `for`

La boucle `for` itère sur une liste d'éléments et est souvent utilisée pour parcourir des fichiers ou des séquences numériques.

**Syntaxe :**
```bash
for variable in liste
do
    commandes
done
```

**Exemple simple avec une séquence numérique :**
```bash
#!/bin/bash
for i in {1..5}
do
    echo "Itération numéro $i"
done
```

**Exemple avancé parcourant des fichiers :**
```bash
#!/bin/bash
for fichier in /chemin/vers/dossier/*.txt
do
    ```bash
    echo "Traitement du fichier: $fichier"
    # Vérification de l'existence du fichier avant traitement
    if [ -f "$fichier" ]; then
        echo "Le fichier existe. Début du traitement..."
        # Afficher les 10 premières lignes du fichier
        head -n 10 "$fichier"
        # Exemple de traitement complémentaire : remplacer une chaîne spécifique
        sed -i 's/ancienne_chaine/nouvelle_chaine/g' "$fichier"
        echo "Traitement effectué avec succès pour : $fichier"
    else
        echo "Le fichier n'existe pas : $fichier"
    fi
    ```
```

---

### 3. La boucle `while`

La boucle `while` exécute des commandes tant qu'une condition est vraie. Elle est particulièrement utile lorsque le nombre d'itérations n'est pas défini à l'avance.

**Syntaxe :**
```bash
while condition
do
    commandes
done
```

**Exemple simple avec un compteur :**
```bash
#!/bin/bash
count=1
while [ $count -le 5 ]
do
    echo "Compteur à $count"
    ((count++))
done
```

**Exemple interactif : demande à l'utilisateur de saisir une valeur jusqu'à obtenir une entrée valide :**
```bash
#!/bin/bash
read -p "Saisissez un nombre positif : " nombre
while ! [[ "$nombre" =~ ^[0-9]+$ ]] || [ "$nombre" -le 0 ]
do
    echo "Entrée non valide. Veuillez saisir un nombre positif."
    read -p "Saisissez un nombre positif : " nombre
done
echo "Vous avez saisi le nombre : $nombre"
```

---

### 4. La boucle `until`

La boucle `until` ressemble à la boucle `while` mais s'exécute jusqu'à ce qu'une condition devienne vraie.

**Syntaxe :**
```bash
until condition
do
    commandes
done
```

**Exemple simple avec un compteur :**
```bash
#!/bin/bash
count=1
until [ $count -gt 5 ]
do
    echo "Compteur à $count"
    ((count++))
done
```

**Exemple interactif avec une condition de sortie :**
```bash
#!/bin/bash
command=""
until [ "$command" == "exit" ]
do
    read -p "Tapez une commande (ou 'exit' pour quitter) : " command
    echo "Vous avez tapé: $command"
done
echo "Sortie de l'application."
```

---

### 5. Le menu interactif avec `select`

La commande `select` facilite la création d'un menu interactif en listant automatiquement les choix disponibles.

**Exemple :**
```bash
#!/bin/bash
PS3="Veuillez choisir une option : "
options=("Option 1" "Option 2" "Quitter")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "Vous avez choisi l'Option 1."
            ;;
        "Option 2")
            echo "Vous avez choisi l'Option 2."
            ;;
        "Quitter")
            echo "Au revoir !"
            break
            ;;
        *)
            echo "Option invalide."
            ;;
    esac
done
```
