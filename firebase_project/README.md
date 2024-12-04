
# Firebase Notes App

## Overview

Firebase Notes App is a SwiftUI-based iOS application that allows users to create, view, and delete personal notes. Leveraging Firebase Authentication for secure user management and Firestore for real-time data storage, this app provides a seamless and intuitive experience for managing notes on the go.

## Features

- **User Authentication**
  - Sign up and log in using email and password.
  - Secure authentication handled by Firebase Authentication.

- **Create Notes**
  - Add new notes with a title and description.
  - Real-time synchronization with Firestore ensures notes are saved instantly.

- **View Notes**
  - Display a list of all user-created notes.
  - Clean and organized UI for easy navigation.

- **Delete Notes**
  - Remove unwanted notes with a simple tap.
  - Confirmation alerts to prevent accidental deletions.

- **Responsive UI**
  - Modern design using SwiftUI.
  - Smooth transitions and user-friendly interface.

## Technologies Used

- **SwiftUI**
  - Building the user interface with declarative syntax.
  
- **Firebase Authentication**
  - Managing user sign-up and login processes securely.
  
- **Firebase Firestore**
  - Storing and retrieving user notes in real-time.
  
- **Swift**
  - Programming language for iOS development.

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/firebase-notes-app.git
   ```

2. **Navigate to the Project Directory**

   ```bash
   cd firebase-notes-app
   ```

3. **Install Dependencies**

   Ensure you have CocoaPods installed. If not, install it using:

   ```bash
   sudo gem install cocoapods
   ```

   Then, install the project dependencies:

   ```bash
   pod install
   ```

4. **Open the Project in Xcode**

   ```bash
   open firebase_project.xcworkspace
   ```

5. **Configure Firebase**

   - Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project.
   - Add an iOS app to your Firebase project.
   - Download the `GoogleService-Info.plist` file.
   - Add the `GoogleService-Info.plist` file to your Xcode project.

6. **Run the App**

   Select a simulator or connect your iOS device and run the project from Xcode.

## Usage

1. **Sign Up**

   - Launch the app.
   - Navigate to the Sign-Up screen.
   - Enter your name, email, and password to create an account.

2. **Login**

   - Use your registered email and password to log in to the app.

3. **Create a Note**

   - From the Main Menu, select "Create Note."
   - Enter the title and description of your note.
   - Save the note to store it in Firestore.

4. **View Notes**

   - Select "View Notes" from the Main Menu to see a list of all your notes.

5. **Delete a Note**

   - Navigate to "Delete Notes" in the Main Menu.
   - Select the note you wish to delete and confirm the action.

6. **Logout**

   - Use the "Logout" button in the Main Menu to sign out of your account.

## Contributing

Contributions are welcome! Please follow these steps:

1. **Fork the Repository**

2. **Create a New Branch**

   ```bash
   git checkout -b feature/YourFeature
   ```

3. **Commit Your Changes**

   ```bash
   git commit -m "Add Your Feature"
   ```

4. **Push to the Branch**

   ```bash
   git push origin feature/YourFeature
   ```

5. **Open a Pull Request**

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Firebase](https://firebase.google.com/) for providing robust backend services.
- [SwiftUI](https://developer.apple.com/xcode/swiftui/) by Apple for building the user interface.
- [Apple Developer Documentation](https://developer.apple.com/documentation/) for comprehensive development resources.
