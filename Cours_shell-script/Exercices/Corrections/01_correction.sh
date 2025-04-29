#!/bin/bash
# ------------------------------------------------------------------
# Description : Premier script interactif simple.
# Demande un prénom et réagit selon la réponse.
# Auteur      : (Ton prénom ici)
# Date        : (Date du jour ici)
# ------------------------------------------------------------------

# Message d'accueil
echo "Bienvenue !"

# Demander le prénom à l'utilisateur
echo "Quel est votre prénom ?"
read prenom

# Affichage du message personnalisé
echo "Bonjour, $prenom ! Bienvenue dans le monde des scripts Shell."

# Vérification du prénom
if [ "$prenom" = "Alice" ]; then
  echo "Accès spécial accordé à Alice !"
else
  echo "Accès standard."
fi
