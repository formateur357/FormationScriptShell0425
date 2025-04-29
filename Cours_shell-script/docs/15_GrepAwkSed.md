
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

### Exemples
```bash
awk '{print $1}' fichier.txt
awk -F',' '{print $2}' data.csv
awk '$3 > 100 {print $1, $3}' fichier
awk 'BEGIN {print "Début"} {print $1} END {print "Fin"}' fichier
```

---

## 📚 3. `sed` — Modifier un texte automatiquement

**Usage** : Rechercher et remplacer du texte, supprimer des lignes, modifier un flux.

### Syntaxe
```bash
sed 'commande' fichier
```

### Exemples classiques
```bash
sed 's/chat/chien/' fichier.txt
sed 's/chat/chien/g' fichier.txt
sed '/Erreur/d' fichier.txt
sed -n '5,10p' fichier.txt
```

---

## 📚 4. D'autres outils très utiles

### `cut` — Extraire des colonnes
```bash
cut -d':' -f1 /etc/passwd
cut -c1-5 fichier.txt
```

### `sort` — Trier des lignes
```bash
sort fichier.txt
sort -n fichier.txt
sort -r fichier.txt
```

### `uniq` — Supprimer les doublons consécutifs
```bash
sort fichier.txt | uniq
uniq -c fichier.txt
```

### `xargs` — Construire et exécuter des commandes
```bash
cat fichiers.txt | xargs rm
find . -name '*.log' | xargs grep "Erreur"
```

### `find` — Rechercher des fichiers
```bash
find . -name "*.sh"
find /var/log -type f -size +10M
```

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
