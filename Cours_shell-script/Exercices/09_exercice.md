# 🏆 Exercice 2 : Analyse avancée de fichiers Logs (30 minutes)

**Objectif** : Utiliser `grep`, `awk`, `sed`, `cut`, `sort`, `uniq`, `find`, `xargs` pour réaliser un traitement complet automatisé sur des fichiers `.log`.

---

## 📋 Contexte

Votre équipe informatique vous fournit un dossier contenant plusieurs fichiers logs (`*.log`).

Vous devez :

- Rechercher et extraire toutes les erreurs critiques.
- Nettoyer les fichiers de toutes les lignes inutiles.
- Extraire des statistiques précises sur les erreurs.
- Générer un rapport synthétique.

---

## 📚 Fichiers fournis

- Un dossier `logs/` avec plusieurs fichiers `.log` contenant :
  - des entrées `INFO`, `DEBUG`, `WARN`, `ERROR`, `FATAL`.
  - des erreurs formatées ainsi : `ERROR: [CODE] Description`.
  - quelques lignes vides et du bruit (`DEBUG`, `TRACE`, etc.).

---

## 🛠️ Étapes à réaliser

### 1. Recherche des erreurs critiques (`grep`, `find`, `xargs`)

- Recherchez toutes les lignes contenant **`ERROR`** ou **`FATAL`** dans **tous les fichiers `.log`** sous `logs/`.
- Regroupez toutes ces lignes dans un fichier unique `erreurs_critiques.log`.

---

### 2. Nettoyage des logs (`sed`)

- Supprimez, dans **tous les fichiers `.log`** :
  - Les lignes vides.
  - Les lignes contenant `DEBUG` ou `TRACE`.
- Créez une version nettoyée de chaque fichier (exemple : `serveur1_nettoye.log`).

---

### 3. Extraction d'informations (`awk`)

À partir de `erreurs_critiques.log` :

- Extraire **le code d’erreur** (ex: `[404]`, `[500]`).
- Compter le nombre d'occurrences pour chaque code d'erreur.
- Afficher un classement des codes les plus fréquents, du plus courant au moins courant.

Exemple attendu :
27 [500] 18 [404] 4 [403]


---

### 4. Résumé synthétique (`cut`, `sort`, `uniq`)

- Depuis tous les fichiers nettoyés, extrayez la première colonne (horodatage par exemple).
- Trier ces horodatages.
- Supprimer les doublons pour obtenir toutes les heures uniques d’événements.

Exemple attendu :
2024-01-01 12:00:00 2024-01-01 12:01:15 ...

---

## 🎯 Objectif final

Générer un dossier `rapport/` contenant :

- `erreurs_critiques.log` : toutes les erreurs trouvées.
- `statistiques_erreurs.txt` : tableau des erreurs par fréquence.
- `horodatages_uniques.txt` : liste triée des horodatages uniques.

---

# 🔥 Bonus (facultatif)

- Écrire un script Bash `analyse_logs.sh` qui fait tout automatiquement.
- Ajouter un argument pour cibler un autre dossier que `logs/`.
- Envoyer un rapport par mail automatiquement à la fin.

---

**Bonne chance !** 🚀
