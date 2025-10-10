🥦 Besinova – Smart Grocery & Health Optimizer

Besinova is a Flutter-based mobile application that helps users plan healthier and more budget-friendly grocery shopping by optimizing nutritional and financial goals.

🌍 Overview

English:
Besinova lets you set your calorie, protein, and budget goals, then creates an optimized grocery list and meal plan tailored to your needs. It uses intelligent logic and a Python-based optimization module (originally server-driven) to find the best food combinations.

Türkçe:
Besinova, kalori, protein ve bütçe hedeflerinizi girmenize olanak tanır ve ihtiyaçlarınıza özel optimize edilmiş market listesi ile yemek planı oluşturur. Akıllı algoritmalar ve Python tabanlı bir optimizasyon modülü (başlangıçta sunucu destekli) kullanır.

🔐 Login & Demo Mode

Originally, Besinova used Firebase for authentication.
Since the Firebase project is now deactivated, the login screen has been updated with a “Skip Login / Continue as Guest” option.
This allows anyone reviewing the app on GitHub to explore all features without any backend connection.

Note: No data is collected, stored, or transmitted. The demo mode exists only to make the app reviewable.

⚙️ Optimization System Status

The optimization feature was designed to communicate with a Python backend (shopping_optimizer_v2.py).
Because this backend server is currently offline, optimization results are not fetched from a live source.
However, the app structure, logic, and UI remain intact — perfectly suitable for portfolio and demonstration purposes.

If the server is restored later, the app will automatically perform real optimization again.

💡 Key Features

Smart grocery list generation

Nutritional and budget-aware planning

Clean, modern Flutter UI with animations

Local state and theme management (Provider)

Demo mode support for offline exploration

🧭 How to Use

Launch the app.

On the login screen, press “Skip Login” to continue in demo mode.

Set basic health or budget goals.

View your optimized grocery plan and meal suggestions.

💻 Tech Stack

Frontend: Flutter (Dart)

State Management: Provider

Theme Support: Manual dark/light toggle

Backend (optional): Python optimization service (currently offline)

📂 Project Status

Firebase has been completely removed.

Optimization backend is offline.

The app runs fully in demo mode, ready for portfolio use.

All UI and logic are fully functional and production-ready.

🧾 For Recruiters / Reviewers

This repository demonstrates:

Strong understanding of Flutter architecture

Real-world UI/UX design capability

Integration of backend optimization logic

Modular and scalable code structure

The app is intentionally presented without Firebase or server dependencies to ensure full transparency and ease of review.