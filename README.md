# ♻️ RecycleMe

RecycleMe is a **Flutter-based mobile application** that makes recycling simple, rewarding, and AI-powered.  
Users can upload recyclable waste (plastic, paper, glass, batteries), earn points for their contributions, and redeem them for rewards.  

The app also integrates an **AI Waste Detection System** built with **DenseNet121 (PyTorch)** and **MobileNet (Keras)**, fine-tuned on the **TrashNet dataset** and deployed as **TensorFlow Lite models** for efficient on-device classification.

---

## ✨ Features

- 📱 **Modern Flutter UI** — clean, responsive, and user-friendly.
- 🔑 **Google Authentication** (Firebase Auth).
- 👤 **User Dashboard**  
  - Upload images of recyclable items.  
  - Enter pickup address and quantity.  
  - Track pending requests.  
- 🗑️ **Waste Categorization** — Plastic, Paper, Glass, Battery.
- 🛠️ **Admin Panel**  
  - Approve/reject disposal requests.  
  - Manage redeem requests.  
- 💰 **Points & Rewards System**  
  - Earn points for every approved disposal request.  
  - Redeem points for real money (via UPI/Bank Transfer).  
- 🤖 **AI Waste Detection**  
  - MobileNet fine-tuned on **TrashNet** for waste classification.  
  - DenseNet121 as baseline classifier.  
  - Converted to **TFLite** for fast on-device inference.  

---

## 🛠️ Tech Stack

- **Frontend:** Flutter (Dart)  
- **Backend:** Firebase  
  - Authentication (Google Sign-In)  
  - Firestore Database  
  - Firebase Functions (for admin operations)  
- **AI Models:**  
  - MobileNet (Keras, fine-tuned on TrashNet)  
  - DenseNet121 (PyTorch baseline)  
  - Deployed using TensorFlow Lite  

---

## 🚀 Installation

### 1. Clone the repository
```bash
git clone https://github.com/raghavdeva/RecycleMe.git
cd RecycleMe
```
```bash
flutter pub get
flutter run
```

---

## 🔬 How AI Waste Detection Works

The app integrates AI to automatically classify waste items into categories like **Plastic, Paper, Glass, and Battery**.

1. **Model Training**
   - Pre-trained **MobileNet (Keras)** and **DenseNet121 (PyTorch)** models were used.
   - Models were fine-tuned on the **TrashNet dataset** for garbage material classification.

2. **Model Conversion**
   - The trained models were converted into **TensorFlow Lite (.tflite)** format for mobile deployment.

3. **On-device Inference**
   - Users can take/upload a picture of waste.
   - The app runs the image through the **TFLite model**.
   - The model predicts the waste category with high accuracy.
   - The predicted category is auto-filled in the disposal request.

This allows **real-time waste detection** without requiring cloud processing, making it efficient, private, and usable offline.

---

## 📅 Roadmap / Future Plans

- 🔍 Expand dataset for better AI accuracy (e.g., metals, e-waste, organics).  
- 🌍 Multi-language support for global accessibility.  
- 🎨 Improved UI/UX with animations.  
- 📊 Analytics dashboard for admins (recycling stats, carbon footprint saved).  
- 🏆 Gamification (leaderboards, badges for top recyclers).  
- 💡 Integration with local recycling agencies for real pickups.  

---

## 🙌 Support

If you like this project, consider giving it a ⭐ on [GitHub](https://github.com/raghavdeva/RecycleMe)!  
Your support motivates further development 🚀  

---


