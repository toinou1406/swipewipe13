# SwipeClean Blueprint

## 1. Project Vision

**SwipeClean** is a photo and video organization application designed for intuitive and rapid storage cleanup through a gesture-based interface.

- **Core Philosophy**: Radical minimalism, a tactile swipe-based experience, and clear, immediate visual feedback.
- **Target Audience**: Users seeking efficient gallery management and a preference for simple, distraction-free UIs.

---

## 2. UI/UX Design (Strict Black & White Theme)

### a. Color Palette
- **Background**: `#000000`
- **Primary Text/Icons**: `#FFFFFF`
- **Secondary Text/Indicators**: `#808080`
- **Borders/Dividers**: `#333333`
- **Overlays**: `#000000` with 70-90% opacity.

### b. Typography
- **Font**: Roboto
- **Styles**:
  - Title: 24px, Bold
  - Body: 16px, Regular
  - Subtitle: 14px, Regular, Color `#808080`

### c. Navigation
- **Primary**: A `PageView` will manage swiping between the `AlbumsScreen` (left), `HomeScreen` (center), and `SwipeScreen` (right).
- **Secondary**: Arrow icons will be available for non-swipe navigation.

---

## 3. Screen Specifications

### a. Home Screen (`home_screen.dart`)
- **Layout**:
  1.  **Storage Bars**: Real-time display of device storage (`Total vs. Used`) and space liberated this month.
  2.  **Last Album Visited**: A clickable card showing the last accessed album's thumbnail and name.
  3.  **Action Buttons**:
      - "Commencer le tri" (Start Sorting): Navigates to the main `SwipeScreen`.
      - "Voir les albums" (View Albums): Navigates to the `AlbumsScreen`.

### b. Swipe Screen (`swipe_screen.dart`)
- **Layout**:
  - A central `MediaCard` displaying a photo (with a B&W filter) or video thumbnail.
  - A top progress bar showing space freed in the current session.
  - Subtle on-screen gesture indicators (←, →, ↑, ↓).
- **Gestures**:
  - **Swipe Right**: Keep media.
  - **Swipe Left**: Move media to the app's trash.
  - **Swipe Up**: Undo the previous action.
  - **Swipe Down**: Open a menu to assign the media to an album.

### c. Albums Screen (`albums_screen.dart`)
- **Layout**: A `GridView` of square `AlbumCard` widgets.
- **Functionality**:
  - Displays all user albums.
  - **Double-click** on an album's name to edit it.
  - A grayed-out "+" button indicates album creation is a premium feature.
  - Each album has a "Commencer" button to open a dedicated album-specific swipe session.

---

## 4. Technical Architecture

### a. Backend & Database
- **Provider**: Firebase
- **Services**:
  - **Authentication**: Firebase Auth (Email/Password, Google Sign-In).
  - **Database**: Cloud Firestore for storing media metadata and album information. Data will be structured per-user.
  - **Storage**: Firebase Storage for hosting the media files themselves, including a dedicated "trash" folder for restorable items.

### b. State Management
- **Provider**: `provider` package for dependency injection and state management across the app.

### c. Key Dependencies
- `firebase_core`, `firebase_auth`, `cloud_firestore`, `firebase_storage`
- `photo_manager` (to access local device media)
- `path_provider` (to query local storage stats)
- `permission_handler` (for runtime permission requests)
- `cached_network_image` (for performance)
- `video_thumbnail`
- `provider`

### d. File & Data Handling
- **No Duplication**: Media is never duplicated. Albums are references to media items stored in Firestore.
- **Trash System**: Deleted media is moved to a `/trash` directory in Firebase Storage and its `deletedAt` field is updated in Firestore. A background process (future implementation) will handle permanent deletion after 30 days.
- **Offline Support**: Firestore's local persistence will be enabled to allow core app functions to work offline. Actions will sync when connectivity is restored.

---

## 5. Monetization Strategy (Preparation)
- **Feature Flag**: A `user_is_premium` boolean will be stored in the user's Firestore document.
- **Limitations**: Non-premium users will be limited to 3 albums. The UI will visually block features like album creation with a "Premium" tooltip.

---

## 6. Current Task: Foundation and Setup

1.  **Update `pubspec.yaml`**: Add all required Firebase and utility dependencies.
2.  **Firebase Configuration**: Set up the Firebase project and integrate it with the Flutter app.
3.  **Project Restructuring**: Organize files and directories according to the architecture (screens, models, services, widgets).
4.  **Theme Implementation**: Code the strict black-and-white theme and apply it globally.
5.  **Model Creation**: Define the `Album` and `Media` data models as Dart classes.
6.  **Initial Screen Scaffolding**: Create the basic structure for `HomeScreen`, `SwipeScreen`, and `AlbumsScreen`.
