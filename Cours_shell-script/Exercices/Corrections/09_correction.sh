# --- 1. Recherche des erreurs critiques (grep + find + xargs) ---

# Trouver toutes les lignes contenant "ERROR" ou "FATAL" dans tous les .log
find logs/ -name "*.log" | xargs grep -E "ERROR|FATAL" > rapport/erreurs_critiques.log

# (grep -E permet de rechercher plusieurs motifs)

# --- 2. Nettoyage des logs (sed) ---

# Pour chaque fichier log, créer une version nettoyée
mkdir -p logs_nettoyes

for fichier in logs/*.log; do
  nom=$(basename "$fichier" .log)
  sed '/^$/d; /DEBUG/d; /TRACE/d' "$fichier" > "logs_nettoyes/${nom}_nettoye.log"
done

# - /^$/d supprime les lignes vides
# - /DEBUG/d et /TRACE/d suppriment les lignes contenant ces mots

# --- 3. Extraction d'informations (awk) ---

# Extraire les codes d'erreur et compter les occurrences
awk -F' ' '{print $3}' rapport/erreurs_critiques.log | sort | uniq -c | sort -nr > rapport/statistiques_erreurs.txt

# - awk '{print $3}' extrait le code d'erreur (ex: [404])
# - sort trie pour préparer uniq
# - uniq -c compte les occurrences
# - sort -nr trie du plus grand au plus petit

# --- 4. Résumé des horodatages uniques (cut, sort, uniq) ---

# Extraire les horodatages de tous les fichiers nettoyés
mkdir -p rapport

cut -d' ' -f1-2 logs_nettoyes/*.log | sort | uniq > rapport/horodatages_uniques.txt

# - cut -d' ' -f1-2 extrait la date et l'heure
# - sort puis uniq garde les horodatages uniques

# --- Résultat final ---

# Vous trouverez dans rapport/ :
# - erreurs_critiques.log
# - statistiques_erreurs.txt
# - horodatages_uniques.txt

