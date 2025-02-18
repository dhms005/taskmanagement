# taskmanagement

# **Task Management App**

A Flutter-based Task Management App that allows users to create, edit, delete, and manage tasks efficiently. The app supports notifications, state management with Riverpod and user preferences with Hive.

## **Features**
* Add, edit, delete, and view tasks 
* Mark tasks as "Completed" or "Pending"
* Persist tasks using SQLite 
* Store user preferences (theme, sort order) using Hive 
* Responsive UI (Mobile & Tablet support)
* State management using Riverpod

## **Requirements**
* Ensure you have the following installed before running the project:
* Flutter SDK 
* Dart SDK (included with Flutter)
* Android Studio / Visual Studio Code (for running and debugging)
* Android Emulator or a physical device

## **Setup & Installation**
1. Clone the repository
   `git clone https://github.com/dhms005/taskmanagement.git`
   `cd taskmanagement`
2. Install dependencies
   `flutter pub get`
3. Run the application
   `flutter run`
4. Setup Database
   The app uses SQLite for storing tasks. No additional setup is needed as the database is initialized automatically.

## **Folder Structure**
lib/<br>
│── main.dart             # Entry point of the application<br>
│── models/               # Data models (Task, User Preferences, etc.)<br>
│── viewmodels/           # Riverpod providers for state management<br>
│── views/                # Screens and UI components<br>
│── widgets/              # Reusable UI components<br>
│── utils/                # Helper classes, constants, and utilities<br>

## **Contributing**
Feel free to fork this repository, make your changes, and submit a pull request.

## **License**
This project is licensed under the MIT License.