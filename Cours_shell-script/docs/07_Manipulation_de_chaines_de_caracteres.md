### Techniques de manipulation de chaînes en Shell Scripting

La manipulation de chaînes est essentielle pour écrire des scripts robustes et flexibles.

### Table des matières

1. [Techniques de manipulation de chaînes en Shell Scripting](#techniques-de-manipulation-de-chaînes-en-shell-scripting)
2. [Utilisation de la commande `expr`](#utilisation-de-la-commande-expr)
3. [Instructions de capture](#instructions-de-capture)
4. [Utilisation de `basename`](#utilisation-de-basename)
5. [Substitution de chaînes](#substitution-de-chaînes)

---

#### 1. Utilisation de la commande `expr`

La commande `expr` permet de réaliser diverses opérations sur les chaînes de caractères, dont la mesure de la longueur, la recherche d'index, ou la découpe de sous-chaînes.

Exemples :

- **Calcul de la longueur d'une chaîne**  
   ```bash
   str="Hello, World!"
   length=$(expr length "$str")
   echo "La longueur de la chaîne est : $length"
   ```
   Ici, `expr length "$str"` calcule le nombre de caractères dans la chaîne.

- **Extraction d'une sous-chaîne**  
   ```bash
   str="ShellScripting"
   # Extraire 6 caractères à partir de la 6ème position
   sub=$(expr substr "$str" 6 6)
   echo "La sous-chaîne est : $sub"
   ```
   `expr substr "$str" 6 6` retourne une sous-chaîne commençant à la position 6 et ayant 6 caractères.

- **Recherche d'un index**  
   ```bash
   str="Hello, World!"
   pos=$(expr index "$str" "W")
   echo "La lettre 'W' est à la position : $pos"
   ```
   `expr index "$str" "W"` retourne la position de la première occurrence du caractère.

---

#### 2. Instructions de capture

Les expressions régulières en shell permettent d'extraire des sous-chaînes correspondant à des motifs précis. En combinant des outils comme `grep`, `sed`, ou `awk`, on peut capturer précisément ce dont on a besoin.

Exemple avec `sed` :

- **Extraire une adresse email d'une chaîne**  
   ```bash
   text="Contactez-nous à support@example.com pour de l'assistance."
   email=$(echo "$text" | sed -n 's/.*\([a-zA-Z0-9._%+-]\+@[a-zA-Z0-9.-]\+\.[a-zA-Z]\{2,\}\).*/\1/p')
   echo "Email extrait : $email"
   ```
   Cette commande utilise une expression régulière pour capturer et afficher une adresse email.

Exemple avec `awk` :

- **Extraire le domaine d'une adresse email**  
   ```bash
   email="support@example.com"
   domain=$(echo "$email" | awk -F'@' '{print $2}')
   echo "Le domaine est : $domain"
   ```
   Ici, `awk` décompose la chaîne en utilisant `@` comme séparateur.

---

#### 3. Utilisation de `basename`

La commande `basename` est utile pour extraire le nom de fichier d'un chemin complet, en supprimant le répertoire et parfois l'extension.

Exemples :

- **Extraire le nom de fichier**  
   ```bash
   path="/Users/morganguy/Desktop/file.txt"
   filename=$(basename "$path")
   echo "Le nom du fichier est : $filename"
   ```
   `basename` supprime la partie chemin, ne laissant que `file.txt`.

- **Retirer également l'extension**  
   ```bash
   path="/Users/morganguy/Desktop/file.txt"
   filename=$(basename "$path" .txt)
   echo "Le nom du fichier sans extension est : $filename"
   ```
   En passant `.txt` comme argument, `basename` enlève l'extension du nom de fichier.

---

#### 4. Substitution de chaînes

Les substitutions de chaînes dans les variables offrent des moyens puissants pour manipuler des contenus sans lancer de sous-processus. La syntaxe `${variable#pattern}` et `${variable##pattern}` permet de supprimer des préfixes, tandis que `${variable%pattern}` et `${variable%%pattern}` gèrent les suffixes.

Exemples :

- **Suppression d'un préfixe**  
   ```bash
   str="Hello, World!"
   # Supprimer le préfixe "Hello, "
   result=${str#Hello, }
   echo "Résultat : $result"  # Affiche "World!"
   ```
   `${str#Hello, }` retire la première occurrence du préfixe spécifié.

- **Suppression d'un suffixe**  
   ```bash
   str="Hello, World!"
   # Supprimer le suffixe " World!"
   result=${str% World!*}
   echo "Résultat : $result"  # Affiche "Hello,"
   ```
   `${str% World!*}` retire la plus courte correspondance du suffixe, ici à partir de " World!".

- **Utilisation de la suppression gourmande**  
   ```bash
   path="/home/user/documents/report.pdf"
   # Retirer le chemin jusqu'au dernier slash (la partie la plus longue)
   filename=${path##*/}
   echo "Nom du fichier : $filename"
   ```
   `${path##*/}` supprime tout jusqu'au dernier `/`, isolant ainsi le nom de fichier.

