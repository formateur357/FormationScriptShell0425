Gestion de notes d'étudiants

## Objectif
Créer un script Bash permettant de gérer un tableau de notes d'étudiants via un menu interactif.

Ce script doit obligatoirement utiliser :
- Lecture d'entrée utilisateur (`read`)
- Boucle `for`
- Boucle `while`
- Menu interactif `select`
- Condition `case`

Durée estimée : 1 heure.

---

## Détails de l'exercice

1. **Initialiser** un tableau vide `notes=()`.

2. **Afficher un menu** avec `select`, proposant :
    - Ajouter des notes
    - Afficher toutes les notes
    - Afficher la moyenne
    - Quitter

3. **Ajouter des notes** :
    - Demander combien de notes l'utilisateur veut entrer.
    - Utiliser une boucle `for` pour demander chaque note.
    - Utiliser une boucle `while` pour valider que chaque note est un nombre valide entre 0 et 20.

4. **Afficher toutes les notes** :
    - Parcourir le tableau `notes` avec une boucle `for`.
    - Afficher chaque note.

5. **Afficher la moyenne** :
    - Parcourir le tableau `notes` pour additionner toutes les notes.
    - Calculer la moyenne et l'afficher avec deux décimales.

6. **Quitter** :
    - Afficher un message d'adieu et terminer le script.

---

## Contraintes techniques

- Le script doit valider que les notes sont bien des nombres positifs compris entre 0 et 20.
- Utiliser `[[ "$variable" =~ ^[0-9]+([.][0-9]+)?$ ]]` pour valider les nombres.
- Utiliser `bc` pour les calculs flottants si nécessaire.
- Le script doit être robuste face aux mauvaises saisies (ex : lettres, nombres hors bornes).