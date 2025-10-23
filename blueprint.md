# Blueprint de l'Application Photo Cleaner

## Aperçu

Cette application permet aux utilisateurs de nettoyer et de gérer facilement l'espace de stockage de leur appareil en supprimant ou en organisant des photos. Elle fournit une interface intuitive et ludique pour visualiser l'état du stockage, parcourir et gérer les albums, et trier les photos via une mécanique de "swipe".

## Style, Design et Fonctionnalités

### Version Cible

- **Architecture** : L'application utilise une architecture basée sur les fonctionnalités, avec des écrans séparés pour chaque fonctionnalité principale.
- **Gestion d'état** : `provider` est utilisé pour la gestion d'état globale, notamment pour le changement de thème. L'état local est géré avec des `StatefulWidget`.
- **Navigation** : La navigation principale est assurée par un `PageView` synchronisé avec un `BottomNavigationBar`, permettant de balayer entre les trois écrans principaux : Albums, Accueil, et Swipe. La navigation secondaire (vers les détails de l'album, etc.) utilise des `MaterialPageRoute`.
- **Thème** : L'application propose deux thèmes :
    - **Thème Sombre** : Fond noir, texte blanc (style ChatGPT).
    - **Thème Clair** : Fond blanc, texte noir.
    Un sélecteur de thème est disponible.
- **Écrans** :
    - **Écran d'Accueil (Central)** :
        - Affiche deux barres de progression :
            1.  Stockage total vs. consommé.
            2.  Espace libéré durant le mois en cours.
        - Un bouton "Commencer le swipe" qui navigue vers l'écran de Swipe.
    - **Écran des Albums (Gauche)** :
        - Affiche les albums photo. Trois albums ("Favoris", "À trier", "Archives") sont créés par défaut s'ils n'existent pas.
        - Un appui long sur un album permet de le renommer.
        - Un clic sur un album ouvre l'écran de détail de l'album.
    - **Écran de Swipe (Droite)** :
        - Écran principal de tri des photos.
        - **Swipe à gauche** : Supprime la photo du téléphone. Une animation de glissement avec une icône de croix rouge est affichée.
        - **Swipe à droite** : Passe à la photo suivante. Une animation de glissement avec une icône de coche verte est affichée.
        - **Swipe en bas** : Ouvre une modale pour sélectionner un album de destination. Une animation de glissement vers le haut avec une icône d'album orange est affichée lors de l'action.
        - **Swipe en haut** : Annule l'action précédente et ramène la dernière photo.
        - Un bouton retour permet de revenir à l'écran d'accueil.
    - **Écran de Détail de l'Album** :
        - Affiche les photos d'un album en vue mosaïque.
        - Permet la sélection multiple pour supprimer des photos (soit de l'album, soit définitivement).
        - Un bouton flottant "Ajouter à l'album" navigue vers un écran de swipe dédié.
    - **Écran de Swipe d'Album** (hors navigation principale) :
        - Accessible uniquement depuis l'écran de détail d'un album.
        - **Swipe à droite** : Ajoute la photo à l'album en cours.
        - Les autres swipes (gauche, bas, haut) ont le même comportement que l'écran de swipe principal.
        - Un bouton retour permet de revenir à la vue mosaïque de l'album.
- **Optimisation** : L'application est conçue pour être performante, avec un chargement asynchrone des images et une gestion efficace de la mémoire.
- **Permissions** : L'application demande les permissions nécessaires pour accéder à la galerie de photos au démarrage.
