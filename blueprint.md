# SwipeClean Blueprint

## Overview

SwipeClean is a photo and video sorting application for Flutter, designed to free up storage space through an intuitive, gesture-based interface. The app features a minimalist, strictly black-and-white dark theme, and is built with a focus on performance, and user experience. The architecture is designed to be modular and scalable, with a clear separation of concerns.

## Style, Design, and Features

### 1. **Visual Design (Strict Black & White Dark Theme)**
- **Palette**:
    - Background: `#000000`
    - Text/Icons: `#FFFFFF`
    - Secondary Text/Borders: `#808080`, `#333333`
- **Typography**:
    - Font: Roboto
    - Sizing: Clear hierarchy for titles, body text, and subtitles.
- **Layout**:
    - Responsive and mobile-first.
    - Consistent spacing and padding (16px margins).
- **Components**:
    - Custom-styled storage bars, album cards, and media cards.
    - Subtle animations for user feedback.

### 2. **Core Features**
- **Three-Screen Layout**:
    - **Home Screen**: Displays storage statistics and quick actions.
    - **Swipe Screen**: The core of the app, for sorting media with swipe gestures.
    - **Albums Screen**: Manages user-created albums.
- **Gesture-Based Sorting**:
    - **Swipe Right**: Keep media.
    - **Swipe Left**: Move media to a temporary trash folder.
    - **Swipe Up**: Undo the last action.
    - **Swipe Down**: Assign media to an album.
- **Storage Management**:
    - Real-time tracking of freed space.
    - Media is moved to a `.SwipeClean/Trash` directory, not deleted immediately.
- **Album Organization**:
    - Three default albums: "Favoris," "Voyages," "Famille."
    - Users can edit album names.
    - A dedicated swipe mode for adding media to a specific album.

### 3. **Monetization (Premium Features - UI Placeholders)**
- Creation of new albums is a premium feature.
- The UI includes disabled elements and tooltips to indicate premium functionality.

### 4. **Architecture**
- **State Management**: `provider` for managing theme, storage stats, and other app-wide states.
- **Navigation**: `go_router` for declarative routing between screens.
- **Database**: `floor` for local persistence of album and media metadata.
- **Media Access**: `photo_manager` to efficiently load photos and videos from the device.
- **File System**: `path_provider` to manage file paths and storage information.
- **Code Structure**: Feature-first organization (screens, widgets, models, utils).

## Current Plan

### Phase 1: Setup and Core Architecture
1.  **Add Dependencies**: Add `provider`, `go_router`, `floor`, `photo_manager`, `path_provider`, `google_fonts`, and `cached_network_image` to `pubspec.yaml`.
2.  **Project Structure**: Create the directory structure (`screens`, `widgets`, `models`, `utils`).
3.  **Theme**: Implement the black-and-white dark theme in `lib/utils/theme.dart`.
4.  **Database Models**: Define `Album` and `Media` entities for the `floor` database.
5.  **Routing**: Configure routes for the home, swipe, and albums screens using `go_router`.
6.  **Main Entry Point**: Update `lib/main.dart` to initialize the theme, providers, and router.

### Phase 2: UI Implementation
1.  **Create Reusable Widgets**:
    - `storage_bar.dart`: For the home screen's storage statistics.
    - `album_card.dart`: For displaying albums in a grid.
2.  **Develop Screens**:
    - **Home Screen (`home_screen.dart`)**: Build the layout with storage bars, last visited album, and navigation buttons.
    - **Albums Screen (`albums_screen.dart`)**: Implement the album grid, edit functionality, and the disabled "add" button.

### Phase 3: Core Functionality
1.  **Develop Swipe Screen (`swipe_screen.dart`)**:
    - Integrate `photo_manager` to load media.
    - Implement the `GestureDetector` for swipe actions (keep, delete, undo, assign to album).
    - Create the file utility to move files to the trash directory.
    - Implement the "space freed" progress bar.
2.  **State Management**:
    - Create `ChangeNotifier` providers for storage statistics and theme management.
    - Integrate providers with the UI to ensure real-time updates.

### Phase 4: Refinement and Testing
1.  **Undo Logic**: Implement a stack-based undo mechanism for the swipe screen.
2.  **Polish UI**: Add subtle animations and ensure all components adhere to the design specifications.
3.  **Code Quality**: Run `flutter analyze` and `dart format .` to ensure a clean and error-free codebase.
4.  **Testing**: Manually test all functionalities, including swipe gestures, album management, and storage updates.
