Gestion des Options en Shell Scripting

## Objectif

Écrire un script `gestion_options.sh` capable de :
- Analyser à la fois des **options courtes** (avec `getopts`) et **des options longues** (avec `getopt`).
- Gérer proprement les **arguments associés** aux options.
- Vérifier et valider les **erreurs d'options**.
- Fournir un **message d'aide** lisible avec `-h` ou `--help`.

---

## Consignes

Vous devez écrire un script qui :

### 1. Analyse avec `getopt` (options longues)

- Utilise `getopt` pour traiter :
  - `--verbose` (`-v`) : active le mode verbeux.
  - `--output <fichier>` (`-o`) : définit un fichier de sortie.
  - `--help` (`-h`) : affiche l'aide.

### 2. Analyse complémentaire avec `getopts` (options courtes uniquement)

Après `getopt`, utilisez `getopts` pour :
- Vérifier :
  - Option `-f` : prend un argument (nom d'un fichier d'entrée obligatoire).
  - Option `-n` : option sans argument (ex : "ne pas exécuter réellement").

### 3. Traitement des options

- En mode verbeux, affichez toutes les étapes du traitement.
- Si le fichier d'entrée donné par `-f` n'existe pas, afficher une erreur et quitter (`exit 1`).
- Si aucun fichier de sortie n'est spécifié, utilisez un nom par défaut `output.txt`.

### 4. Traitement des erreurs

- Si une option inconnue est rencontrée, afficher un message d'erreur et sortir proprement.
- Si une option attend un argument et qu'il est manquant, afficher une erreur et sortir.

### 5. Affichage d'une aide complète

Si `-h` ou `--help` est demandé :
- Affichez la liste des options acceptées avec explication.
- Quittez proprement après affichage.

---

## Résultat attendu

Un script capable de comprendre et de traiter des appels comme :

```bash
./gestion_options.sh -v -f monfichier.txt --output sortie.log fichier1 fichier2
./gestion_options.sh --help
./gestion_options.sh -nf monfichier.txt