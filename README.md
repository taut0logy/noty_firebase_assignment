# Firebase Notes App

A SwiftUI-based iOS application for creating and managing personal notes with Firebase authentication and cloud storage.

## Table of Contents

## Contributors

1. [Raufun Ahsan (2007030)](https://github.com/taut0logy):
      - **Contributions**:
      - Firebase integration
      - User authentication
      - README.md

2. [Md. Abir Rahman (2007026)](https://github.com/abirzishan32)
      - **Contributions**:
      - Main menu view
      - Create note view
      - Splash screen

3. [Md. Raihan (2007005)](https://github.com/Raihan7121)
      - **Contributions**:
      - View notes view
      - Delete notes view
      - Error handling

## Technologies Used

### Frameworks & Libraries

- **SwiftUI**: Apple's modern declarative UI framework
- **Firebase Authentication**: For user authentication and management
- **Firebase Firestore**: NoSQL cloud database for storing notes and user data

## Features

### Authentication

- User registration with email and password
- User login with email and password
- Secure logout functionality
- User profile data storage in Firestore

### Note Management

1. **Create Notes**
   - Add new notes with title and description
   - Notes are automatically linked to the user's account
   - Real-time cloud storage

2. **View Notes**
   - List view of all user's notes
   - Display both title and description
   - Loading states and error handling
   - Empty state handling

3. **Delete Notes**
   - Delete individual notes
   - Confirmation dialog before deletion
   - Real-time updates

### UI/UX Features

- Modern gradient-based design
- Loading indicators for async operations
- Error handling with user-friendly alerts
- Responsive interface with proper navigation
- Custom button styles
- Secure input fields for sensitive data

## Architecture

- **View-based architecture** using SwiftUI
- **Cloud-first** approach with Firebase backend
- **User-centric** data model with secure access controls
- **Modular views** for different functionalities:
  - AuthView
  - MainMenuView
  - CreateNoteView
  - ViewNotesView
  - DeleteNotesView

## Security

- Authenticated user sessions
- Secure password handling
- User-specific data isolation
- Protected Firebase rules (assumed)

This app demonstrates a complete CRUD (Create, Read, Update, Delete) implementation for personal notes with cloud synchronization and user authentication.
