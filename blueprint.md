# Swipe Clean - Blueprint

## Overview

Swipe Clean is a mobile application designed to help users efficiently manage and clean up their photo library. The core feature of the app is a "swipe-to-delete" interface, allowing users to quickly go through their photos and decide which ones to keep and which to delete.

## Style, Design, and Features

### Version 1.0 (Initial Setup)

*   **Theme:**
    *   Material 3 design with a consistent color scheme.
    *   Support for both light and dark modes.
    *   Custom typography using `google_fonts`.
*   **Architecture:**
    *   Provider for state management.
    *   go_router for navigation.
    *   Feature-first project structure.
*   **Core Features:**
    *   Requesting photo library permissions.
    *   Fetching and displaying photo albums.

### Version 1.1 (Swipe-to-Delete)

*   **Photo Viewer:**
    *   A dedicated screen (`PhotoViewerScreen`) to display photos from an album.
*   **Swipe Gestures:**
    *   Swipe right to keep a photo.
    *   Swipe left to mark a photo for deletion.
*   **Visual Feedback:**
    *   As the user swipes, a colored overlay (green for keep, red for delete) with an icon provides immediate visual feedback.
*   **Undo Functionality:**
    *   An "Undo" button in the `AppBar` allows the user to reverse their last swipe.
*   **Deletion Confirmation:**
    *   After swiping through all photos, a dialog appears to confirm the permanent deletion of the marked photos.

## Current Plan

The core functionality of the application is complete. The next steps will focus on refining the user interface and user experience.

*   **UI Polish:** Improve the overall design and aesthetics of the application.
*   **Animations:** Add smooth transitions and animations to enhance the user experience.
*   **Settings:** Implement a settings screen to allow users to customize the app's behavior.
