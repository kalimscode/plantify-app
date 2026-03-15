# 🌱 Plantify

[![Flutter](https://img.shields.io/badge/flutter-3.10-blue)](https://flutter.dev)
[![License](https://img.shields.io/badge/license-Apache%202.0-green)](LICENSE)

Plantify is a modern, responsive Flutter app for plant enthusiasts. Built with **MVVM + Clean Architecture**, it uses **Riverpod** for state management and integrates backend APIs to provide a smooth, efficient, and scalable experience.

---

### Technologies & Architecture

- **MVVM Architecture** for clear separation of concerns
- **Clean Architecture** for scalable and maintainable code
- **Riverpod** for efficient state management
- **Responsive Design** for all screen sizes
- **Dark and Light Theme Support**

---

## ⚠️ Current State

- Some screens are currently **non-interactive** due to missing backend APIs.
- Profile data is stored **locally on the device** since profile APIs were unavailable.
- As there are **no products in the database yet**, a **hybrid logic** approach has been implemented for product, cart, and order operations. This allows the app to simulate these features locally so the flow continues to work properly.
- When backend APIs provide real product data, the same operations will seamlessly work through the APIs while still supporting local functionality.

---

## Features

- **User Authentication**: Sign up, login, password recovery, logout
- **Profile creation**: Create profile, profile picture, and address
- **Explore Plants**: Browse plants with search, categories, and detailed info
- **Favorites & Bookmarks**: Save your favorite plants for easy access
- **Responsive UI**: Works on all screen sizes using `flutter_screenutil`
- **Reusable Widgets**: Modular, consistent UI components
- **API Integration**: authentication,product,favourite, cart and order apis
- **Dark/Light Theme Support**
- **Clean & Scalable Code**: MVVM + Clean Architecture
- **State Management**: Riverpod for reactive and predictable state handling

---

## Tech Stack

- Flutter & Dart
- Riverpod – State management
- Dio – HTTP requests & API calls
- Shared Preferences – Local storage & caching
- flutter_screenutil – Responsive layouts

---

## Architecture

- **Presentation Layer**: Screens, widgets, and view models
- **Domain Layer**: Entities and use cases
- **Data Layer**: Repositories, API services, local storage
- **State Management**: Riverpod for reactive state handling

---

## Getting Started

### Prerequisites

- Flutter 3.0+ installed
- Android Studio / VS Code
- Emulator or physical device

### Installation

```bash
git clone https://github.com/KashifAhmad/the_plantinium_mobile.git
cd plantify
flutter pub get
flutter run

License

This project is licensed under the Apache License 2.0 – January 2004. See the LICENSE
 file for details.

Author

Kalim Ullah – Flutter Developer

GitHub: https://github.com/kalimscode

LinkedIn: https://www.linkedin.com/in/kalim-ullah-2b77393b7/