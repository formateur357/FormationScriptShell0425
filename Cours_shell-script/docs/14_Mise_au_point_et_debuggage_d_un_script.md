# Mise au point et débogage d'un script

Le débogage est une étape cruciale dans le développement de scripts shell. Il permet d'identifier et de corriger les erreurs en fournissant une vision détaillée de l'exécution du script. Une bonne stratégie de débogage aide à améliorer la fiabilité et la maintenabilité du code en permettant aux développeurs d'intervenir rapidement lorsqu'un problème survient. 

## Techniques de débogage

1. **Utilisation de `set -x`**  
   L'option `set -x` active le mode de débogage, qui affiche chaque commande au moment de son exécution. Cela permet de suivre le chemin d'exécution du script et de visualiser les substitutions et évaluations des variables.
   
   Exemple d'utilisation :
   ```bash
   #!/bin/bash
   set -x  # Active l'affichage de chaque commande exécutée
   echo "Début du script"
   # D'autres commandes seront affichées avec leur évaluation
   ```
   
   Cette technique est particulièrement utile pour comprendre le flux d'exécution et identifier l'origine d'un comportement inattendu. Elle peut toutefois générer de nombreux messages, donc il est conseillé de l'utiliser principalement lors de la phase de développement ou sur des sections spécifiques du code.

2. **Utilisation de `set -e`**  
   L'option `set -e` force l'arrêt immédiat du script dès qu'une commande retourne une valeur différente de zéro (ce qui indique une erreur). Cela permet d'éviter que des erreurs non traitées ne conduisent à des comportements imprévus plus tard dans le script.
   
   Exemple d'utilisation :
   ```bash
   #!/bin/bash
   set -e  # Interrompt l'exécution du script en cas d'erreur
   echo "Début du script"
   # Si une commande échoue ici, le script s'arrêtera immédiatement
   ```
   
   Cette méthode est recommandée pour les scripts nécessitant une exécution fiable, car elle permet d'éviter que le script continue lors d'une situation indésirable.

3. **Ajout de messages de débogage avec `echo` ou `printf`**  
   Parfois, il est utile d'insérer des messages explicatifs à des points stratégiques dans le script pour observer la valeur des variables ou l'exécution de certaines conditions.
   
   Exemple d'utilisation :
   ```bash
   #!/bin/bash
   echo "Début du script"
   # Vérification de l'existence d'une variable
   if [ -z "$VAR" ]; then
       echo "La variable VAR est vide, veuillez vérifier son assignation"
   else
       echo "La variable VAR contient : $VAR"
   fi
   ```
   
   Ces messages permettent de confirmer que le script atteint bien certains points et peut aider à identifier précisément où se situe un problème.

4. **Utilisation de `trap` pour la gestion des signaux**  
   La commande `trap` est utilisée pour intercepter et gérer les signaux envoyés au script. Cela permet, par exemple, de réaliser des actions de nettoyage ou d'afficher un message personnalisé lorsqu'un signal (comme l'interruption par Ctrl+C) est reçu.
   
   Exemple d'utilisation :
   ```bash
   #!/bin/bash
   trap 'echo "Script interrompu par l'utilisateur"; exit' SIGINT
   echo "Début du script"
   # Suite du script...
   ```
   
   Cette technique assure que même en cas d'interruption, le script peut exécuter des actions essentielles, telles que la libération des ressources ou l'enregistrement d'informations de débogage.

## Outils de débogage

En complément aux techniques ci-dessus, plusieurs outils peuvent aider à vérifier et améliorer vos scripts :

- **bash -n**  
  Vérifie la syntaxe d'un script sans l'exécuter. Cette commande permet de détecter des erreurs de syntaxe avant même de lancer le script.
  ```bash
  bash -n script.sh
  ```
  
- **bash -x**  
  Exécute le script en mode débogage (similaire à `set -x`), affichant chaque commande avec son évaluation.
  ```bash
  bash -x script.sh
  ```

- **ShellCheck**  
  Un outil de vérification statique qui analyse le code shell pour détecter des erreurs courantes, de mauvaises pratiques et des problèmes potentiels de sécurité.
  ```bash
  shellcheck script.sh
  ```

  ShellCheck offre des conseils détaillés, ce qui peut être très bénéfique pour l'apprentissage et l'amélioration de la qualité des scripts shell.

## Exemple complet de script utilisant plusieurs techniques de débogage

Voici un exemple de script qui combine plusieurs techniques de débogage afin de faciliter la compréhension et l'identification des problèmes :

```bash
#!/bin/bash
# Exemple de script pour démontrer plusieurs techniques de débogage

set -e  # Arrête le script dès qu'une commande échoue
set -x  # Active le mode débogage pour afficher chaque commande exécutée

# Définition d'une fonction pour nettoyer les ressources en cas d'interruption
cleanup() {
    echo "Nettoyage des ressources..."
    # Ajouter ici les commandes de nettoyage
    exit 1
}

# Trap pour intercepter l'interruption par l'utilisateur (Ctrl+C)
trap cleanup SIGINT

echo "Début du script"

# Exemple d'assignation d'une variable
VAR="Test"

# Vérification de la variable avec messages détaillés
if [ -z "$VAR" ]; then
    echo "Erreur: La variable VAR est vide."
    # Possibilité d'ajouter une gestion d'erreur plus poussé ici
else
    echo "La variable VAR contient : $VAR"
fi

# Simuler une commande qui échoue pour tester le comportement avec set -e
echo "Simulation d'une erreur avec la commande 'false'"
false  # Cette commande échoue et devrait arrêter l'exécution en raison de set -e

# Ce message ne sera pas affiché en cas d'erreur
echo "Fin du script"
```

## Conclusion

Le débogage est une partie intégrante du développement de scripts shell. En utilisant de manière combinée les options `set -x` et `set -e`, l'insertion de messages explicatifs et l'utilisation de `trap`, vous pouvez aisément suivre et corriger le déroulement de votre script. L'utilisation d'outils comme `ShellCheck` ajoute une couche supplémentaire d'assurance quant à la qualité et la sécurité de votre code. Ces pratiques permettent d'améliorer la robustesse du script et facilitent la maintenance à long terme.
