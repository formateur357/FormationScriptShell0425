## Contexte

Vous développez un petit utilitaire Shell permettant :
- De traiter une chaîne entrée par l'utilisateur,
- D'extraire des adresses emails dans un texte,
- D'analyser des chemins de fichiers,
- De nettoyer des données textuelles extraites depuis un fichier.

---

## Consignes détaillées

### 1. Analyse d'une chaîne utilisateur

Demander à l'utilisateur (`read`) d'entrer une **chaîne libre**.

Traitement de la chaîne :

- **Calculer** la **longueur** avec `expr length`.
- **Trouver** la **position** du premier "@" ou "-" (choisir celui qui arrive en premier).
- **Extraire** les **5 premiers caractères** avec `expr substr`.
- Si la chaîne fait plus de 20 caractères :
  - Utiliser `awk` pour **afficher uniquement les 20 premiers caractères** via `echo "$chaine" | awk '{print substr($0,1,20)}'`.

---

### 2. Extraction et traitement d'emails

Demander à l'utilisateur (`read`) d'entrer une **phrase** contenant **potentiellement plusieurs adresses emails**.

Traitement :

- Utiliser `grep -oE` pour **extraire toutes les adresses email** présentes (regex simple).
- Pour chaque email extrait :
  - Extraire le **domaine** avec `awk` (`@` comme séparateur),
  - Nettoyer le domaine pour **supprimer les sous-domaines éventuels** avec `sed`.
    - Exemple : `support@sub.example.com` ➔ `example.com`.

Utiliser obligatoirement **un chaînage `grep | awk | sed`**.

---

### 3. Analyse d'un chemin de fichier

Demander un **chemin complet** de fichier.

Traitement :

- Extraire le **nom du fichier** avec `basename`.
- Utiliser la **substitution `${path##*/}`** pour obtenir également le nom brut.
- Extraire le **dossier parent** avec `${path%/*}`.
- Si le fichier a une extension `.log`, `.txt` ou `.csv` :
  - Remplacer l'extension par `.bak` avec substitution.
  - Exemple : `report.log` devient `report.bak`.

---

### 4. Extraction de données depuis un fichier texte

Demander à l'utilisateur (`read`) un **fichier texte existant**.

Traitement :

- Demander un **mot-clé** (`read`) à rechercher dans le fichier.
- Utiliser :
  - `grep` pour extraire les lignes contenant le mot-clé,
  - Puis **`awk`** pour afficher la **2ᵉ colonne** des résultats,
  - Puis **`sed`** pour nettoyer des caractères parasites éventuels (`,`, `.`).

Affichez les résultats extraits, nettoyés.

---

## Contraintes

- Toutes les variables utilisées dans des tests doivent être **protégées** avec des guillemets `"..."`.
- Utiliser **des commentaires** expliquant chaque étape du script.
- Utiliser au moins une fois une **expansion arithmétique** `$(( ))` (par exemple pour calculer un score ou un total).
- **Gestion d'erreur** : 
  - Vérifiez systématiquement que l'utilisateur entre des données valides (chemin existant, texte non vide, etc.).
  - Gérez le cas où **aucun email** ou **aucun résultat** n'est trouvé.

---

## Exemple de déroulement attendu

```bash
Entrez une chaîne : support-team@example.com
- Longueur : 24
- Premier symbole '@' à la position 13
- Premiers caractères : suppo
- Première partie (20 caractères) : support-team@example.

Entrez une phrase : Envoyez un email à help@domain.org ou à admin@sub.example.com
- Emails trouvés :
    - help@domain.org ➔ Domaine principal : domain.org
    - admin@sub.example.com ➔ Domaine principal : example.com

Entrez un chemin de fichier : /var/logs/server.log
- Nom de fichier : server.log
- Dossier parent : /var/logs
- Nouveau nom : server.bak

Entrez un fichier texte : liste_utilisateurs.txt
Entrez un mot-clé : Nom
- Résultats :
    - Jean
    - Alice
    - Robert