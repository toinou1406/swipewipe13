# SwipeClean App Blueprint

## Overview

SwipeClean is a Flutter application designed to help users efficiently manage their phone's storage. It provides a simple, Tinder-like swipe interface for users to quickly decide whether to keep or delete photos, videos, and screenshots.

## Features & Design

*   **Modern UI:** A clean and intuitive user interface built with Material Design 3 components.
*   **Theming:** Supports both light and dark modes with a consistent color scheme and typography using `google_fonts`.
*   **Navigation:** A bottom navigation bar for easy access to the main screens (Home, Review, Settings) and a router (`go_router`) for managing navigation.
*   **Media Categories:** Users can choose to manage "All Photos," "Screenshots," or "Videos."
*   **Swipe Interface:** A card-based swipe interface (`swipe_cards`) for quickly deciding on each media item.
*   **Review & Delete:** A dedicated screen to review all items marked for deletion before permanently removing them.
*   **Permissions Handling:** The app will request the necessary permissions to access the user's media library.

## Plan

1.  **Project Setup & Scaffolding:**
    *   Add necessary dependencies: `go_router`, `provider`, `google_fonts`, `photo_manager`, `swipe_cards`.
    *   Create the basic file structure for the screens: `home_screen.dart`, `swipe_screen.dart`, `review_screen.dart`, `settings_screen.dart`.
    *   Create `scaffold_with_nav_bar.dart` for the main navigation structure.
    *   Update `main.dart` with theme setup, provider, and initial `GoRouter` configuration.

2.  **Implement Core UI Screens:**
    *   Build the `HomeScreen` with category selection buttons.
    *   Create placeholder UI for `SwipeScreen`, `ReviewScreen`, and `SettingsScreen`.
    *   Integrate the `ScaffoldWithNavBar` using a `ShellRoute` in `go_router`.

3.  **Develop Media Service:**
    *   Create `services/media_service.dart`.
    *   Implement `MediaService` to handle fetching and deleting media using the `photo_manager` package.
    *   Include permission request logic.

4.  **Build Swipe Functionality:**
    *   Integrate `MediaService` into `SwipeScreen`.
    *   Use `swipe_cards` to display media and handle swipe gestures.
    *   Track items to be kept or deleted.
    *   Navigate to the `ReviewScreen` with the list of items to be deleted.

5.  **Finalize Review and Delete Process:**
    *   Display the selected items in `ReviewScreen`.
    *   Implement the final delete functionality.
    *   Provide user feedback on the deletion process.

6.  **Add Settings:**
    *   Implement a theme toggle in the `SettingsScreen`.
