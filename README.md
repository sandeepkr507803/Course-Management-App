# Course Management App

A Flutter-based mobile application for managing educational courses with an integrated AI-powered chatbot for course recommendations.

## App Overview
This application allows users to:
- Create, view, update, and delete courses
- Store course information in Firebase Firestore
- Get AI-powered course recommendations through a chatbot
- Enjoy a smooth, responsive user experience

## Tech Stack
- Frontend: Flutter (Dart)
- Backend: Firebase Firestore (NoSQL database)
- State Management: GetX
- AI Integration: Groq API with OpenAI model
- HTTP Client: Dart http package

## Prerequisites
- Before running this application, ensure you have:
- Flutter SDK (version 3.0 or higher)
- Android Studio or VS Code with Flutter extension
- Firebase Account
- Groq Account (for AI chatbot functionality)
- Physical device or emulator for testing

## Setup Instructions
1. Clone the Repository
   - git clone <your-repository-url>
   - cd course_management_app
2. Install Dependencies
   - flutter pub get
3. Groq API Setup
   - Sign up for a Groq account at https://groq.com/
   - Get your API key from the dashboard
   - Change .env.example file to .env and replace 'YOUR_GROQ_API_KEY' with your actual API key
4. Run the Application
   - flutter emulators --launch <emulator_name> (use this command only when you have to use emulator, otherwise skip)
   - flutter run
