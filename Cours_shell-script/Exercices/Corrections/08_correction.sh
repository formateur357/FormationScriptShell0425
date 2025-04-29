# --- 1. Filtrage des erreurs (grep) ---

# Rechercher toutes les lignes contenant "ERROR" dans serveurs.log
grep "ERROR" serveurs.log > erreurs.log

# Compter combien d'erreurs ont été trouvées
wc -l erreurs.log
# (Affiche le nombre de lignes, donc d'erreurs)

# --- 2. Extraction et analyse (awk) ---

# Afficher le produit et la quantité pour chaque vente
awk -F',' 'NR > 1 {print $2, "-", $3, "unités"}' ventes.csv

# Calculer la somme totale des quantités
awk -F',' 'NR > 1 {s+=$3} END {print "Total :", s, "unités"}' ventes.csv

# (NR > 1 pour ignorer l'entête CSV)

# --- 3. Nettoyage du fichier (sed) ---

# Supprimer toutes les lignes contenant "DEBUG"
sed '/DEBUG/d' serveurs.log > serveurs_temp.log

# Remplacer tous les mots "WARN" par "WARNING"
sed 's/WARN/WARNING/g' serveurs_temp.log > serveurs_nettoye.log

# Nettoyage du fichier temporaire
rm serveurs_temp.log

# --- 4. Résumé des produits (cut, sort, uniq) ---

# Extraire la colonne "Produit" (champ 2)
cut -d',' -f2 ventes.csv | tail -n +2 > produits.txt
# (tail -n +2 enlève la première ligne d'entête)

# Trier les produits par ordre alphabétique
sort produits.txt > produits_tries.txt

# Supprimer les doublons
uniq produits_tries.txt > produits_uniques.txt

# Afficher le résultat
cat produits_uniques.txt

# --- 5. Recherche avancée (find + xargs) ---

# Trouver tous les fichiers .log qui contiennent "Connection refused"
find . -name "*.log" | xargs grep -l "Connection refused"

# (grep -l n'affiche que les noms de fichiers)

# --- 6. Bilan final (pipeline complet) ---

# Trouver toutes les lignes "ERROR" dans tous les .log,
# extraire le code d'erreur (ex: 404), compter les occurrences,
# trier par nombre décroissant

find . -name "*.log" \
| xargs grep "ERROR" \
| awk -F'[: ]+' '{print $2}' \
| sort \
| uniq -c \
| sort -nr

# Explication :
# - find : chercher les .log
# - xargs grep : chercher les lignes "ERROR"
# - awk : extraire le code juste après "ERROR:"
# - sort : trier par ordre alphabétique pour préparer uniq
# - uniq -c : compter les occurrences
# - sort -nr : trier par nombre décroissant

# --- 7. Rapport final (optionnel) ---

# Créer un rapport.txt avec un résumé
{
  echo "Nombre total d'erreurs :"
  wc -l < erreurs.log
  echo
  echo "Total de produits vendus :"
  awk -F',' 'NR > 1 {s+=$3} END {print s}' ventes.csv
  echo
  echo "Produits disponibles :"
  cat produits_uniques.txt
  echo
  echo "Top erreurs rencontrées :"
  find . -name "*.log" | xargs grep "ERROR" | awk -F'[: ]+' '{print $2}' | sort | uniq -c | sort -nr | head -n 3
} > rapport.txt

# --- FIN ---
