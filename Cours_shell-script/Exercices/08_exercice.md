**Objectif** : Utiliser `grep`, `awk`, `sed`, `cut`, `sort`, `uniq`, `xargs` et `find` dans un scénario unique de traitement de logs et de fichiers CSV.

---

## 🛠️ Contexte

Vous êtes administrateur système.  
Votre mission est d’analyser des fichiers de logs et des fichiers CSV pour :
- détecter des erreurs,
- extraire des informations utiles,
- produire un rapport synthétique.

Vous disposez des fichiers suivants :
- `serveurs.log` : journal des évènements système (100 lignes contenant \"INFO\", \"WARN\", \"ERROR\").
- `ventes.csv` : données de ventes en format CSV (colonnes : `ID`, `Produit`, `Quantité`, `Prix`).

---

## Instructions détaillées

### 1. Filtrage des erreurs (`grep`)
- Recherchez toutes les lignes contenant \"ERROR\" dans `serveurs.log`.
- Enregistrez-les dans un fichier `erreurs.log`.
- Combien d’erreurs ont été détectées ? (indice : `wc -l`)

---

### 2. Extraction et analyse (`awk`)
- Dans `ventes.csv`, affichez uniquement :
  - le nom du produit
  - la quantité
- Trouvez combien de produits ont été vendus en total (`Quantité`).

**Résultat attendu** :
Produit 1 - 5 unités Produit 2 - 12 unités ... Total : 217 unités


---

### 3. Nettoyage du fichier (`sed`)
- Dans `serveurs.log` :
  - Supprimez toutes les lignes contenant \"DEBUG\".
  - Remplacez tous les mots \"WARN\" par \"WARNING\".
  - Enregistrez le résultat dans un nouveau fichier `serveurs_nettoye.log`.

---

### 4. Résumé des produits (`cut`, `sort`, `uniq`)
- Depuis `ventes.csv` :
  - Extraire uniquement la colonne `Produit`.
  - Trier les produits par ordre alphabétique.
  - Afficher les produits sans doublons.

**Exemple attendu** :
Clavier Ecran Ordinateur Souris



---

### 5. Recherche avancée (`find` + `xargs`)
- Recherchez dans tout le dossier courant :
  - tous les fichiers `.log`
  - qui contiennent l’expression \"Connection refused\"
- Listez uniquement les noms de fichiers concernés.

---

### 6. Bilan final (pipeline)
Créez une **commande unique** (un seul pipeline) pour :

- Trouver toutes les lignes avec \"ERROR\" dans tous les fichiers `.log`.
- Extraire uniquement le type d’erreur (extrait après le mot \"ERROR:\" par exemple \"404\", \"500\", etc.).
- Trier les erreurs par fréquence d’apparition, de la plus fréquente à la moins fréquente.

**Exemple attendu** :
25 500 17 404 3 403


---

# 🎯 Rendu attendu

- Un fichier `rapport.txt` contenant :
  - le nombre total d'erreurs
  - le total de ventes
  - la liste propre des produits
  - le top des erreurs par type
- Toutes vos commandes dans `commands.sh`.
