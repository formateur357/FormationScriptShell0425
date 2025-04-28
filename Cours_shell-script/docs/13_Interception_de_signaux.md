## Interception de Signaux en Shell Scripting

L'interception de signaux en shell scripting est une technique puissante pour gérer des événements asynchrones dans l'exécution d'un script. Elle permet à votre script de réagir à divers signaux envoyés par le système ou l'utilisateur. Ces signaux indiquent la survenue d’événements spécifiques, tels qu'une interruption manuelle ou une demande de terminaison, et peuvent être utilisés pour effectuer des opérations de nettoyage ou sauvegarder des données avant de clore un processus.

### Les Signaux et Leur Importance

Les signaux sont des notifications envoyées à un processus. Voici quelques-uns des signaux les plus utilisés :

- **SIGINT** : Envoyé lors de l'appui sur Ctrl+C. Permet d'interrompre une opération en cours.
- **SIGTERM** : Utilisé pour demander la terminaison d'un processus de manière polie.
- **SIGHUP** : Se produit lorsque la session ou le terminal associé est fermé. Peut être utilisé pour recharger la configuration.
- **SIGQUIT** : Généralement envoyé par Ctrl+\ et provoque l'arrêt du programme avec un dump mémoire.
- **SIGKILL** : Force la terminaison d'un processus. Ce signal ne peut pas être intercepté ou ignoré.
- **SIGUSR1** et **SIGUSR2** : Signaux définis par l'utilisateur et personnalisables pour envoyer des notifications ou déclencher des actions spécifiques.

L'utilisation judicieuse de la gestion des signaux permet d'améliorer la robustesse et la fiabilité de vos scripts, notamment dans les environnements de production ou lors de l'exécution de tâches sensibles.

### La Commande Trap

La commande `trap` permet de définir des actions à exécuter lorsqu'un signal spécifique est reçu par le script. La syntaxe générale est la suivante :

```bash
trap 'action' SIGNAL
```

- L'argument `action` représente le code à exécuter lorsque le signal est intercepté.
- `SIGNAL` est le nom du signal (par exemple, SIGINT, SIGTERM, etc.).

On peut également utiliser `trap` pour nettoyer les ressources, fermer les fichiers ou sauvegarder l'état avant la terminaison du script.

### Gestion Avancée et Bonnes Pratiques

1. **Utiliser Trap pour le Nettoyage :**
    Lorsque vous interceptez un signal, il est courant d'exécuter une fonction qui ferme les connexions, libère des ressources ou enregistre l'état du système.

2. **Multiple Signaux dans une Seule Instruction :**
    Vous pouvez associer la même action à plusieurs signaux :
    ```bash
    trap 'cleanup' SIGINT SIGTERM
    ```

3. **Réinitialiser un Signal :**
    Pour restaurer le comportement par défaut d'un signal, utilisez la commande :
    ```bash
    trap - SIGNAL
    ```
    Par exemple, pour restaurer le comportement par défaut de SIGINT :
    ```bash
    trap - SIGINT
    ```

4. **Débogage et Journalisation :**
    Lors du développement d'un script, il peut être utile de logguer quand et comment les signaux sont capturés pour faciliter le débogage.

### Exemple Pratique Complet

Dans cet exemple, nous interceptons le signal SIGINT (généré par Ctrl+C) pour exécuter une fonction de nettoyage. Nous montrons également comment intercepter plusieurs signaux simultanément, et comment inclure une journalisation simple :

```bash
#!/bin/bash

# Fonction de nettoyage et de journalisation
cleanup() {
     echo "[$(date '+%Y-%m-%d %H:%M:%S')] Signal reçu, lancement des procédures de nettoyage..."
     # Placez ici vos opérations de nettoyage (fermeture de fichiers, sauvegarde, etc.)
     sleep 1  # Simulation d'une tâche de nettoyage
     echo "Nettoyage terminé. Fermeture du script."
     exit 0
}

# Interception de SIGINT et SIGTERM
trap 'cleanup' SIGINT SIGTERM

# Boucle principale du script
while true; do
     echo "Exécution du script... (appuyez sur Ctrl+C ou envoyez SIGTERM pour interrompre)"
     sleep 2
done
```