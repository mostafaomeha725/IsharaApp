# 🤟 Ishara – AI Sign Language Learning App



**Ishara** is an AI-powered mobile application designed to help children learn sign language through interactive lessons and real-time gesture recognition.

The application combines **computer vision** with structured educational content such as lessons, tests, and educational videos to create an engaging and effective learning experience.

---

## 📖 Overview

The application allows users to learn sign language step by step through:

* 📚 Interactive learning modules
* 🎥 Educational videos
* 📝 Practice tests

Using the device camera, the AI model analyzes hand gestures in real time and verifies whether the performed sign matches the expected gesture.

---

## ✨ Key Features

* 🔐 User Authentication (Login & Sign Up)
* 🌙 Dark Mode & ☀️ Light Mode
* 🤟 Interactive Sign Language Lessons
* 🧠 AI-powered Hand Sign Recognition
* 📊 Learning Progress Evaluation through Tests
* 🎬 Educational Video Content
* ☁️ Backend Integration for User Data
* 📷 Real-time Camera Detection

---

## 🛠 Tech Stack

### 📱 Mobile Application

* Flutter
* Dart

### 🤖 Artificial Intelligence

* Python
* YOLOv8
* OpenCV
* Roboflow Dataset

### 🧩 Architecture

* MVVM (Model – View – ViewModel)

### 🌐 Backend

* REST API
* User Authentication & Data Management

---

## 🏗 System Architecture

The project follows the **MVVM architecture** to ensure clean code organization and maintainability.

```
lib/
 ├── core
 │   ├── constants
 │   └── utilities
 │
 ├── models
 │   └── data models
 │
 ├── views
 │   ├── auth
 │   ├── learning
 │   ├── test
 │   └── videos
 │
 ├── viewmodels
 │   └── business logic & state management
 │
 ├── services
 │   ├── api services
 │   └── AI integration
 │
 └── main.dart
```

---

## ⚙️ Installation

Clone the repository

```bash
git clone https://github.com/username/ishara.git
```

Navigate to the project folder

```bash
cd ishara
```

Install dependencies

```bash
flutter pub get
```

Run the application

```bash
flutter run
```

---

## 🚀 Future Improvements

* Sentence-level sign recognition
* Gamified learning experience
* Performance analytics for learners
* Support for additional sign language datasets


