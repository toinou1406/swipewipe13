# Blueprint de l'Application Photo Cleaner

## Aperçu

Cette application permet aux utilisateurs de nettoyer et de gérer facilement l'espace de stockage de leur appareil en supprimant des photos. Elle fournit une interface intuitive pour visualiser le stockage, parcourir les albums et supprimer des photos via une mécanique de "swipe".

## Style, Design et Fonctionnalités

### Version Finale

- **Architecture** : L'application utilise une architecture basée sur les fonctionnalités, avec des écrans séparés pour chaque fonctionnalité principale (accueil, swipe, albums).
- **Gestion d'état** : `provider` est utilisé pour la gestion d'état, notamment pour le changement de thème.
- **Navigation** : La navigation est gérée de manière déclarative à l'aide de `go_router`, permettant une navigation fluide entre l'écran d'accueil, l'écran de swipe, l'écran des albums et l'écran de détail des albums.
- **Thème** : L'application prend en charge les thèmes clair et sombre, avec un sélecteur dans la barre d'applications. La typographie est améliorée avec `google_fonts`.
- **Écrans** :
  - **HomeScreen** : Affiche des indicateurs de pourcentage pour l'utilisation du stockage et l'espace nettoyé. Contient un bouton pour accéder à l'écran de swipe et une icône pour accéder à l'écran des albums.
  - **SwipeScreen** : Charge et affiche les photos de la galerie de l'utilisateur. Permet aux utilisateurs de supprimer des photos en les balayant, libérant ainsi de l'espace de stockage.
  - **AlbumsScreen** : Affiche une grille des albums photo de l'utilisateur. Un clic sur un album navigue vers l'écran de détail de l'album.
  - **AlbumDetailScreen** : Affiche une grille des photos contenues dans un album spécifique.
- **Fonctionnalités Clés** :
  - **Visualisation du stockage** : L'écran d'accueil donne un aperçu rapide de l'espace de stockage utilisé et disponible.
  - **Nettoyage par balayage** : L'écran de swipe offre une manière ludique et efficace de passer en revue et de supprimer des photos.
  - **Navigation dans la galerie** : Les utilisateurs peuvent facilement parcourir leurs albums et voir les photos qu'ils contiennent.
  - **Suppression de fichiers** : L'application supprime réellement les fichiers de l'appareil, ce qui n'est pas seulement une suppression dans l'application.
