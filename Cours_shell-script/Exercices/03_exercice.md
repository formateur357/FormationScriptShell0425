## Contexte

Vous devez développer un petit outil d'analyse pour vérifier automatiquement l'état d'un répertoire donné.

Le script effectuera les actions suivantes :

---

## Consignes

### 1. Vérification initiale

- Demander à l'utilisateur (`read`) d'entrer un **chemin de répertoire**.
- Vérifier :
  - Si le chemin est **non vide**.
  - Si le chemin **existe** (`-e`) et est un **répertoire** (`-d`).
- Si ce n'est pas un répertoire valide, afficher une erreur et quitter proprement (`exit 1`).

---

### 2. Parcours des fichiers du dossier

- Parcourir tous les **fichiers** et **sous-dossiers** (fichiers uniquement) du répertoire.
- Pour chaque fichier :
  - Vérifier s'il est **lisible** (`-r`) et **exécutable** (`-x`).
  - Vérifier si son **nom** contient une extension `.sh`, `.txt`, ou `.log` via **[[ ]]** et des correspondances de motifs (`*"texte"*`).
  - Selon l'extension :
    - `.sh` ➔ Afficher "Script Shell détecté : nom_fichier".
    - `.txt` ➔ Afficher "Fichier texte détecté : nom_fichier".
    - `.log` ➔ Afficher "Fichier log détecté : nom_fichier".
    - Sinon ➔ Afficher "Autre type de fichier : nom_fichier".

---

### 3. Tests de permissions et alertes

- Si un fichier n'est **pas lisible**, afficher une **alerte** : "ATTENTION : fichier non lisible".
- Si un fichier `.sh` est **exécutable**, afficher : "Script prêt à être exécuté."
- Sinon, proposer d'**afficher une commande** pour le rendre exécutable (`chmod +x`).

---

### 4. Contraintes

- Utiliser **exclusivement `[[ ]]`** pour :
  - Comparaison de chaînes,
  - Tests de motifs (`== *.sh`, etc.).
- Utiliser `[ ]` uniquement pour :
  - Tests sur fichiers (`-e`, `-d`, `-f`, `-r`, `-x`).
- **Toujours protéger** les variables avec des guillemets `"..."` dans les tests.
- Ajouter **des commentaires** pour expliquer chaque bloc de code.

---

## Exemple de déroulement attendu

```bash
Entrez un dossier à analyser : mon_dossier

Fichier analysé : script1.sh
-> Script Shell détecté : script1.sh
-> Script prêt à être exécuté.

Fichier analysé : notes.txt
-> Fichier texte détecté : notes.txt
-> ATTENTION : fichier non lisible.

Fichier analysé : serveur.log
-> Fichier log détecté : serveur.log

Fichier analysé : archive.zip
-> Autre type de fichier : archive.zip