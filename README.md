🥦 Besinova – Smart Grocery & Health Optimizer

Besinova is a Flutter-based mobile application that helps users plan healthier and more budget-friendly grocery shopping by optimizing nutritional and financial goals.

⚠️ Security Notice

This project has been fully cleaned of all exposed API keys and sensitive data.
Please review the included SECURITY.md file before setup to ensure best practices for secure configuration.

🌍 Overview
English

Besinova allows users to set calorie, protein, and budget goals, then generates an optimized grocery list and meal plan tailored to their needs.
It was originally connected to a Python-based optimization service and a web scraper that collected and filtered around 17,000 food entries based on specific nutritional and price constraints.

Currently, the backend is offline, but the app remains fully functional in demo mode, ideal for portfolio presentation.

Türkçe

Besinova, kullanıcıların kalori, protein ve bütçe hedeflerine göre optimize edilmiş market listeleri ve yemek planları oluşturur.
Proje başlangıçta, yaklaşık 17.000 gıda verisini filtreleyen Python tabanlı bir optimizasyon ve scraper modülü ile çalışıyordu.
Sunucu şu anda kapalı olsa da uygulama demo modunda sorunsuz şekilde incelenebilir.

🔐 Login & Demo Mode
The original Firebase authentication system has been removed.
Instead, a “Skip Login / Continue as Guest” option allows anyone to explore the app without a backend connection.

💡 No user data is collected, stored, or transmitted.
⚙️ Optimization System Status
Optimization logic was designed around a Python backend (shopping_optimizer_v2.py) and a scraper that processed ~17,000 food items.
These services are currently offline, so live optimization is disabled.
However, local optimization logic and demo mode remain active for demonstration.

💡 Key Features

🛒 Smart grocery list generation
🍽️ Nutrition & budget-aware meal planning
🎨 Clean Flutter UI with smooth animation
🧠 Local & Provider-based state management
🚀 Demo mode for offline exploration

🧭 How to Use
Launch the app.
On the login screen, press “Skip Login.”
Enter your calorie, protein, or budget goals.
View your optimized grocery plan and nutrition summary.

📂 Project Status

✅ Firebase removed
✅ API keys sanitized
✅ Demo mode fully functional
⚙️ Backend & scraper offline (optional to reactivate)
🎯 Ready for portfolio, presentation, or review
