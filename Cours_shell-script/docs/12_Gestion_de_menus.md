# Gestion de Menus

## Introduction
La gestion de menus dans les scripts shell permet de créer des interfaces utilisateur simples et interactives pour faciliter la navigation et l'exécution des commandes. Grâce à ces menus, les utilisateurs n'ont pas besoin de se souvenir de toutes les commandes précises. On peut guider l'utilisateur étape par étape, rendant ainsi le script plus convivial et accessible.

## Création d'un Menu
Pour mettre en place un menu dans un script bash, l'idée principale est d'utiliser une boucle, souvent une boucle `while`, qui affiche en continu les options disponibles et récupère l'entrée de l'utilisateur pour exécuter l'action correspondante. Voici quelques points clés :

1. **Affichage des Options**  
    À chaque itération de la boucle, le script affiche les choix disponibles (par exemple, Option 1, Option 2, Quitter).

2. **Lecture de l'Entrée Utilisateur**  
    La commande `read` permet de capturer la réponse de l'utilisateur qui est stockée dans une variable. Cette variable est ensuite évaluée pour décider de l'action à mener.

3. **Exécution de l'Action Correspondante**  
    La structure `case` est utilisée pour associer chaque option à une ou plusieurs commandes. Cela permet de gérer proprement chaque cas de figure et de proposer une réponse appropriée en fonction de l'entrée de l'utilisateur.

4. **Conditions d'Arrêt**
    Habituellement, une des options permet de sortir de la boucle (souvent "Quitter"). Pour cela, le script utilise la commande `break` afin de terminer la boucle et clore le menu proprement.

## Exemple de Menu avec Explications
L'exemple suivant présente un menu simple en bash avec des commentaires détaillés pour expliquer chaque partie :

```bash
#!/bin/bash

# Boucle infinie qui affichera constamment le menu jusqu'à ce que l'utilisateur choisisse de quitter
while true; do
     # Affichage des options disponibles dans le menu
     echo "=== Menu ==="
     echo "1. Option 1"    # Option pour exécuter une action spécifique
     echo "2. Option 2"    # Une deuxième option d'action
     echo "3. Quitter"     # Option pour sortir du menu et terminer le script

     # Demande à l'utilisateur de choisir une option et stocke sa réponse dans la variable "option"
     read -p "Choisissez une option: " option

     # La structure "case" permet de gérer différentes actions selon la valeur de "option"
     case $option in
          1)
                # Action pour l'option 1
                echo "Vous avez choisi l'option 1."
                # Ici, on peut appeler une fonction ou exécuter d'autres commandes correspondant à l'option 1
                ;;
          2)
                # Action pour l'option 2
                echo "Vous avez choisi l'option 2."
                # De même, intégrer ici le code propre à l'option 2
                ;;
          3)
                # Action pour quitter le menu
                echo "Au revoir!"
                break  # Arrête la boucle et termine le script
                ;;
          *)
                # Cas par défaut pour gérer les entrées non valides
                echo "Option invalide. Veuillez réessayer."
                ;;
     esac
done
```

### Explications Complémentaires
- **Boucle `while true`:**  
  Elle permet de maintenir l'affichage du menu tant qu'aucune condition d'arrêt (ici l'option "Quitter") n'est rencontrée. Cela crée une boucle infinie qui ne s'arrête que lorsqu'on déclenche explicitement une sortie.

- **Commande `read`:**  
  Utilisée avec l'option `-p` pour afficher une invite de commande, elle permet de récupérer facilement l'entrée de l'utilisateur. La valeur saisie définit ensuite l'action dans le bloc `case`.

- **Structure `case`:**  
  Elle est idéale pour traiter plusieurs cas de figure, chaque option étant gérée par un bloc spécifique (1, 2, 3, ou toutes autres valeurs via le `*`). Cela rend la gestion du menu claire et extensible.

- **Utilisation du `break`:**  
  Essentiel pour sortir de la boucle `while` lorsque l'utilisateur choisit de quitter. Sans `break`, la boucle continuerait indéfiniment.
