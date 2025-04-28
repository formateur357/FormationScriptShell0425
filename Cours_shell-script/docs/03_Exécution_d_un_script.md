## Exécution d'un script : 

L'exécution d'un script shell est une étape essentielle pour automatiser des tâches dans un environnement Unix/Linux. Voici plusieurs méthodes pour lancer un script avec des explications détaillées, des exemples concrets et quelques bonnes pratiques.

## Table des matières
1. [Préparation du script](#1-préparation-du-script)
2. [Rendre le script exécutable](#2-rendre-le-script-exécutable)
  - [Utilisation de base](#utilisation-de-base)
  - [Explication des options](#explication-des-options)
  - [Contrôle fin avec les permissions numériques](#contrôle-fin-avec-les-permissions-numériques)
  - [Vérification des permissions](#vérification-des-permissions)
3. [Méthodes d'exécution](#3-méthodes-dexécution)
  - [Exécution directe](#a-exécution-directe)
  - [Exécution via l'interpréteur](#b-exécution-via-linterpréteur)
  - [Utilisation du chemin complet](#c-utilisation-du-chemin-complet)
  - [Exécution en arrière-plan](#d-exécution-en-arrière-plan)
4. [Exécution de commandes spécifiques dans un script](#4-exécution-de-commandes-spécifiques-dans-un-script)
5. [Considérations et bonnes pratiques](#5-considérations-et-bonnes-pratiques)
6. [Exemple complet](#6-exemple-complet)

### 1. Préparation du script

Avant toute exécution, il est important de :

- Vérifier l'existence de l'interpréteur en première ligne avec un "shebang" (par exemple, `#!/bin/bash`).
- Rendre le script exécutable si vous souhaitez l’exécuter directement.

### 2. Rendre le script exécutable

Pour exécuter un script directement, il est nécessaire que le fichier ait les droits d'exécution. La commande utilisée pour cela est `chmod`.

#### Utilisation de base

La syntaxe de base pour ajouter le droit d'exécution à un fichier est :
```bash
chmod +x nom_du_script.sh
```
Ce qui fait en sorte que tous les utilisateurs (propriétaire, groupe et autres) puissent exécuter le script.

#### Explication des options

- Le symbole `+x` ajoute le droit d'exécution.
- Vous pouvez également spécifier pour quel type d'utilisateur appliquer ce droit :
  - `u` pour le propriétaire (user)
  - `g` pour le groupe
  - `o` pour les autres
  
Par exemple, pour ajouter le droit d'exécution uniquement pour le propriétaire, vous pouvez utiliser :
```bash
chmod u+x nom_du_script.sh
```

#### Contrôle fin avec les permissions numériques

Les permissions en Unix/Linux peuvent aussi être définies avec des valeurs numériques. Les trois chiffres représentent le propriétaire, le groupe et les autres respectivement. Pour donner les droits d'exécution au propriétaire tout en conservant les droits de lecture et d'écriture et en accordant seulement des droits de lecture et d'exécution pour le groupe et les autres, vous pouvez écrire :
```bash
chmod 755 nom_du_script.sh
```
Cela veut dire :
- `7` (pour le propriétaire) = lecture (4) + écriture (2) + exécution (1)
- `5` (pour le groupe) = lecture (4) + exécution (1)
- `5` (pour les autres) = lecture (4) + exécution (1)

#### Vérification des permissions

Pour vérifier que les droits ont bien été appliqués, utilisez la commande suivante :
```bash
ls -l nom_du_script.sh
```
Vous devriez voir quelque chose comme :
```
-rwxr-xr-x  1 utilisateur  groupe  taille Date nom_du_script.sh
```
Les lettres `r`, `w`, et `x` indiquent respectivement les permissions de lecture, écriture et exécution.

Avec ces informations, vous disposez d’une vue d'ensemble sur l'utilisation de `chmod` pour rendre un script exécutable tout en contrôlant précisément qui peut l'exécuter.


### 3. Méthodes d'exécution

#### A. Exécution directe

Une fois le script rendu exécutable, vous pouvez l'exécuter directement :

```bash
./nom_du_script.sh
```

> Note : Le chemin courant (`.`) doit être inclus si le dossier n'est pas dans votre variable d'environnement PATH.

#### B. Exécution via l'interpréteur

Même si le script n'est pas exécutable ou si vous souhaitez explicitement préciser l'interpréteur, vous pouvez lancer le script de la manière suivante :

```bash
bash nom_du_script.sh
```

Des interpréteurs alternatifs sont également possibles, par exemple pour `sh`, `zsh`, etc.

#### C. Utilisation du chemin complet

Lorsque le script se trouve dans un répertoire différent de celui du terminal, fournissez le chemin complet :

```bash
/path/to/nom_du_script.sh
```

Cela garantit que le système localise correctement le script.

#### D. Exécution en arrière-plan

Pour lancer un script en arrière-plan et libérer votre terminal pour d’autres commandes :

```bash
./nom_du_script.sh &
```

Astuce : Pour suivre l’exécution d’un script lancé en arrière-plan, utilisez la commande `jobs`. Vous pouvez aussi rediriger la sortie standard et d’erreur vers un fichier pour conserver un historique complet, par exemple :

```bash
./mon_script.sh > sortie.log 2>&1 &
```

La commande exécute le script "mon_script.sh" en arrière-plan tout en redirigeant à la fois la sortie standard (stdout) et la sortie d'erreur (stderr) vers le fichier "sortie.log".

Détail de chaque partie :
- "./mon_script.sh" : Lance le script présent dans le répertoire courant.
- "> sortie.log" : Redirige la sortie standard du script vers le fichier "sortie.log".
- "2>&1" : Redirige en même temps la sortie d'erreur vers la même destination que la sortie standard (ici, "sortie.log").
- "&" : Exécute la commande en arrière-plan, permettant ainsi de récupérer le contrôle du terminal immédiatement.

### 4. Exécution de commandes spécifiques dans un script

Votre script peut contenir des commandes à exécuter de différentes manières :

- **Commande en arrière-plan interne** : Lancez une opération longue en arrière-plan pour optimiser l'exécution.

  ```bash
  sleep 5 &
  ```

- **Commande avec spécification d'interpréteur** : Exécuter des commandes avec un interpréteur particulier.

  ```bash
  bash -c 'echo "Commande exécutée sous bash."'
  ```

### 5. Considérations et bonnes pratiques

- **Permissions** : Assurez-vous que seuls les utilisateurs autorisés ont accès aux scripts sensibles.
- **Shebang** : Toujours commencer le script par une ligne de shebang pour définir l’interpréteur.
- **Variables d'environnement** : Modifiez ou exportez les variables d'environnement selon les besoins du script.
- **Gestion des erreurs** : Intégrez des mécanismes de contrôle d'erreurs. Par exemple, utilisez `set -e` pour arrêter l'exécution en cas d'erreur :

  ```bash
  #!/bin/bash
  set -e  # Arrête le script en cas d'erreur
  ```

- **Commentaires** : Ajoutez des commentaires pour clarifier le rôle et le fonctionnement du script, facilitant ainsi sa maintenance.

### 6. Exemple complet

Voici un exemple de script détaillé qui illustre plusieurs des aspects présentés ci-dessus :

```bash
#!/bin/bash
# Exemple avancé de script

# Active le mode "erreure" pour stopper le script si une commande échoue
set -e

echo "Début de l'exécution du script."

# Exemple d'utilisation d'une commande en arrière-plan
sleep 5 &
echo "Commandes asynchrones lancées en arrière-plan."

# Exécution d'une commande avec un interpréteur spécifique
bash -c 'echo "Exécution d'une commande via bash."'

# Exemple d'utilisation de variables d'environnement
MY_VAR="ValeurExemple"
export MY_VAR
echo "La variable MY_VAR est définie à: $MY_VAR"

echo "Fin de l'exécution du script."
```

Avec ces méthodes et considérations, vous êtes désormais équipé pour exécuter efficacement vos scripts shell, tout en adoptant de bonnes pratiques de développement. 
