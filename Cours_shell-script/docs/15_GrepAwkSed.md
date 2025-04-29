
# 🖥️ Cours Shell : Maîtriser `grep`, `awk`, `sed` et autres commandes utiles

---

## 📚 1. `grep` — Chercher du texte dans des fichiers

**Usage** : Recherche de motifs (patterns) dans un ou plusieurs fichiers.

### Syntaxe
```bash
grep [options] 'motif' fichier
```

### Options principales
- `-i` : ignore la casse (`a == A`)
- `-r` : recherche récursive dans les dossiers
- `-v` : inverse le résultat (lignes qui NE correspondent PAS)
- `-n` : affiche les numéros de ligne
- `-E` : active les expressions régulières étendues

### Exemples
```bash
grep "Erreur" fichier.log
grep -i "serveur" *.txt
grep -rn "TODO" .
grep -v "^#" fichier.conf
```

---

## 📚 2. `awk` — Traiter et transformer des lignes de texte

**Usage** : Manipulation puissante ligne par ligne (découper, filtrer, reformater).

### Syntaxe
```bash
awk 'programme' fichier
```
Un programme AWK de base ressemble à :
```awk
'condition { action }'
```

### Options supplémentaires

- **-F** : Définit le séparateur de champs.  
    Exemple : `awk -F: '{print $1}' /etc/passwd` utilise `:` comme délimiteur.

- **-v** : Initialise une variable avant l'exécution du programme AWK.  
    Exemple : `awk -v seuil=50 '$2 > seuil {print $1}' data.txt` compare la valeur du deuxième champ à la variable `seuil`.

- **-f** : Lit un programme AWK depuis un fichier externe.  
    Exemple : `awk -f script.awk fichier.txt` où `script.awk` contient le code AWK.

### Exemples concrets et complexes

1. **Calculer la somme d'une colonne dans un fichier CSV**  
     ```bash
     awk -F',' '{s+=$3} END {print "Somme =", s}' data.csv
     ```
     *Explication* : Utilise la virgule comme séparateur et additionne les valeurs du troisième champ.

2. **Filtrer et formater les données avec une variable**  
     ```bash
     awk -F';' -v seuil=100 '$2 > seuil {printf "Produit: %-10s | Prix: %s\n", $1, $2}' produits.csv
     ```
     *Explication* : Filtre les lignes où le champ 2 dépasse `seuil` et affiche le nom du produit et son prix de manière formatée.

3. **Utiliser un script externe pour des traitements complexes**  
     Contenu de `traitement.awk` :
     ```awk
     BEGIN {
             FS = ",";
             print "Données traitées:"
     }
     {
             if ($3 >= 80)
                     print $1, "a réussi avec une note de", $3;
             else
                     print $1, "a échoué avec une note de", $3;
     }
     END {
             print "Fin du traitement."
     }
     ```
     Exécution :
     ```bash
     awk -f traitement.awk etudiants.csv
     ```

4. **Transformation et réorganisation de champs**  
     ```bash
     awk -F',' '{
             # Réorganiser: mettre le 2ème champ en premier et ajouter un message
             print "Nom: " $2 ", Détail: " $1 " - " $3
     }' data.csv
     ```
     *Explication* : Change l'ordre des champs et ajoute du texte autour de chaque valeur.


---

## 📚 3. `sed` — Modifier un texte automatiquement

**Usage** : Rechercher et remplacer du texte, supprimer des lignes, modifier un flux.

### Syntaxe
```bash
sed [options] 'commande' fichier
```

### Options principales
- `-i` : modifie le fichier en place (sans créer de copie).
- `-e` : permet de spécifier plusieurs commandes.
- `-n` : supprime l'affichage par défaut, utile avec `p` pour afficher uniquement les lignes souhaitées.
- `-f` : lit les commandes depuis un fichier script.

### Commandes courantes
- `s/ancien/nouveau/` : remplace un texte.
- `/motif/d` : supprime les lignes correspondant au motif.
- `/motif/p` : affiche uniquement les lignes correspondant au motif.
- `5,10p` : affiche les lignes 5 à 10.

### Exemples simples
```bash
sed 's/chat/chien/' fichier.txt       # Remplace la première occurrence de "chat" par "chien" par ligne.
sed 's/chat/chien/g' fichier.txt     # Remplace toutes les occurrences de "chat" par "chien".
sed '/Erreur/d' fichier.txt          # Supprime les lignes contenant "Erreur".
sed -n '5,10p' fichier.txt           # Affiche uniquement les lignes 5 à 10.
```

### Exemples complexes
1. **Remplacer un mot dans tout un dossier de fichiers :**
    ```bash
    sed -i 's/localhost/127.0.0.1/g' *.conf
    ```
    *Remplace toutes les occurrences de "localhost" par "127.0.0.1" dans tous les fichiers `.conf`.*

2. **Supprimer les lignes vides et les commentaires :**
    ```bash
    sed '/^$/d; /^#/d' fichier.conf
    ```
    *Supprime les lignes vides et celles commençant par `#` dans un fichier de configuration.*

3. **Ajouter une chaîne de texte au début et à la fin de chaque ligne :**
    ```bash
    sed 's/^/Début: /; s/$/ :Fin/' fichier.txt
    ```
    *Ajoute "Début: " au début et " :Fin" à la fin de chaque ligne.*

4. **Modifier un fichier en place avec sauvegarde :**
    ```bash
    sed -i.bak 's/erreur/ERREUR/g' fichier.log
    ```
    *Remplace "erreur" par "ERREUR" dans le fichier et crée une sauvegarde nommée `fichier.log.bak`.*

5. **Extraire et afficher uniquement les lignes contenant un motif spécifique :**
    ```bash
    sed -n '/serveur/p' fichier.log
    ```
    *Affiche uniquement les lignes contenant "serveur".*

6. **Appliquer plusieurs commandes en une seule fois :**
    ```bash
    sed -e 's/erreur/ERREUR/g' -e '/DEBUG/d' fichier.log
    ```
    *Remplace "erreur" par "ERREUR" et supprime les lignes contenant "DEBUG".*

7. **Insérer du texte avant ou après une ligne spécifique :**
    ```bash
    sed '/motif/i Texte avant' fichier.txt
    sed '/motif/a Texte après' fichier.txt
    ```
    *Ajoute "Texte avant" avant les lignes contenant "motif" et "Texte après" après ces lignes.*

8. **Réordonner des colonnes dans un fichier CSV :**
    ```bash
    sed 's/^\([^,]*\),\([^,]*\),\([^,]*\)$/\3,\1,\2/' fichier.csv
    ```
    *Réorganise les colonnes d'un fichier CSV en mettant la troisième colonne en premier.*

### Remarque
`sed` est un outil puissant pour manipuler des fichiers texte. Cependant, il est important de tester vos commandes avant d'utiliser l'option `-i` pour éviter des modifications irréversibles.

---

## 📚 4. D'autres outils très utiles (utilisation approfondie)

### `cut` — Extraire des colonnes
La commande `cut` permet de sélectionner des parties spécifiques d'une ligne :
- Pour extraire un champ spécifique à l'aide d'un délimiteur, utilisez :
    ```bash
    cut -d':' -f1 /etc/passwd
    ```
    Ici, le deux-points (`:`) est utilisé pour séparer les champs et le premier champ (par exemple, le nom d'utilisateur) est extrait.
- Pour extraire une plage de caractères :
    ```bash
    cut -c1-5 fichier.txt
    ```
    Cette commande sélectionne les cinq premiers caractères de chaque ligne.

### `sort` — Trier des lignes
La commande `sort` organise les lignes d’un fichier dans l’ordre souhaité :
- Pour trier par ordre alphabétique :
    ```bash
    sort fichier.txt
    ```
- Pour effectuer un tri numérique :
    ```bash
    sort -n fichier.txt
    ```
- Pour inverser l'ordre de tri :
    ```bash
    sort -r fichier.txt
    ```
Ces options peuvent être combinées pour adapter le tri à vos besoins, notamment en chaînant plusieurs commandes via des pipes.

### `uniq` — Supprimer les doublons consécutifs
`uniq` élimine les lignes identiques qui se suivent, idéalement après un tri :
- Pour filtrer les doublons sur un fichier trié :
    ```bash
    sort fichier.txt | uniq
    ```
- Pour compter le nombre d'occurrences de chaque ligne unique :
    ```bash
    uniq -c fichier.txt
    ```
Notez que si les doublons ne sont pas adjacents, il est nécessaire de trier le fichier au préalable.

### `xargs` — Construire et exécuter des commandes
`xargs` convertit l’entrée standard en arguments pour une commande spécifique :
- Pour supprimer des fichiers listés dans un fichier :
    ```bash
    cat fichiers.txt | xargs rm
    ```
- Pour rechercher un motif dans plusieurs fichiers trouvés par `find` :
    ```bash
    find . -name '*.log' | xargs grep "Erreur"
    ```
Cette commande permet de contourner les limitations liées à la longueur des arguments en ligne de commande.

### `find` — Rechercher des fichiers
La commande `find` explore l'arborescence pour localiser des fichiers selon divers critères :
- Pour trouver tous les scripts shell dans le répertoire courant :
    ```bash
    find . -name "*.sh"
    ```
- Pour rechercher des fichiers de plus de 10 Mo dans `/var/log` :
    ```bash
    find /var/log -type f -size +10M
    ```
Elle offre des options avancées de filtrage (par type, taille, date, etc.) et peut être utilisée en conjonction avec d'autres commandes pour des traitements plus complexes.

En les combinant, ces outils permettent de créer des chaînes de traitement puissantes adaptées à divers scénarios de manipulation de données.

---

## 🛠️ 5. Combiner les commandes

**Chainer les commandes** avec des pipes `|` !

### Exemple complexe
```bash
find . -name "*.log" | xargs grep "Erreur" | awk '{print $2}' | sort | uniq -c | sort -nr
```
**Interprétation** :
- Trouve tous les fichiers `.log`
- Cherche "Erreur" dans chacun
- Affiche la deuxième colonne
- Trie et compte les occurrences uniques
- Trie les résultats par nombre décroissant

---

# 🎯 Résumé

| Commande | À quoi elle sert |
|:---------|:-----------------|
| `grep`   | Chercher un motif |
| `awk`    | Manipuler lignes et colonnes |
| `sed`    | Modifier le texte automatiquement |
| `cut`    | Découper des champs |
| `sort`   | Trier |
| `uniq`   | Dédupliquer |
| `xargs`  | Chainer des commandes |
| `find`   | Chercher des fichiers |

---
