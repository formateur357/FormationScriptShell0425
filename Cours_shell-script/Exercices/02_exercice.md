# Exercice de synthèse – Variables et Expansions en Shell

## Objectif

Créer un script `variables_expansions.sh` utilisant **divers types de variables** et **toutes les formes d’expansion** vues en cours.

---

## Consignes

Écris un script qui réalise les étapes suivantes :

### 1. Création de variables
- Crée une variable `prenom` (ton prénom) et `age` (ton âge).
- Crée une variable vide `ville`.
- Crée une variable `langue` **non définie**.

### 2. Demande interactive
- Utilise `read` pour demander la **ville de naissance** si `ville` est vide (`:-` pour afficher une valeur par défaut).
- Utilise `read` pour demander la **langue maternelle** uniquement si `langue` n'est pas définie (`:=` pour l'initialiser).

### 3. Expansions diverses
- Affiche un message qui utilise :
  - `${variable:-valeur}` pour afficher une valeur par défaut si la variable est vide.
  - `${variable:=valeur}` pour assigner une valeur si la variable est vide.
  - `${variable:+texte}` pour afficher un texte alternatif si la variable existe.
  - `${variable:?message}` pour **interrompre** le script avec un message d'erreur si une variable importante (ex: `prenom`) n'est pas définie.

### 4. Manipulations de chaînes
- Affiche la **longueur** du prénom avec `${#prenom}`.
- Extrait les **trois premières lettres** du prénom avec `${prenom:0:3}`.
- Supprime une partie d’une chaîne :
  - `${ville%motif}` pour supprimer un suffixe, par exemple `/France` de "Paris/France".
- Remplace une partie d'une variable :
  - `${ville//pattern/remplacement}` pour remplacer les espaces par des underscores.

### 5. Opérations sur les entiers
- Déclare `age` comme **variable entière** avec `declare -i`.
- Calcule et affiche l’**année de naissance** avec `année_naissance=2025-age`.

### 6. Tableaux
- Crée un tableau `langages` contenant trois langages que tu aimes.
- Parcours et affiche les éléments du tableau avec une boucle `for`.

### 7. Export de variables
- Exporte la variable `prenom` pour qu’elle soit accessible aux processus enfants.

### 8. Destruction optionnelle
- Si le script reçoit l’argument `--reset`, détruis (`unset`) toutes les variables créées.

---

## Contraintes supplémentaires

- Utilise **des quotes simples ou doubles** aux bons endroits.
- Utilise **les accolades** `{}` autour des variables pour éviter toute ambiguïté.
- Chaque bloc de code doit être **commenté**.
- Le script doit être **robuste** : pas d’erreurs si l’utilisateur oublie de répondre.

---

## Exemple d’affichage attendu (simplifié)

```bash
Bienvenue Alice !
Vous avez 24 ans.
Votre ville de naissance est : Paris
Votre langue maternelle est : Français
Votre prénom contient 5 lettres.
Premières lettres de votre prénom : Ali
Votre année de naissance estimée est : 2001
Langages préférés :
- bash
- python
- javascript
