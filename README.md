# 🚇 Smart Subway Transfer (스마트 환승철)

---

## 📆 Project Info

- **Project period:** September 2024 – December 2024  
- **Refactored:** March 2025  
- **Team project** for “Project 1” course at Myongji University (3rd year)  

---

## 🛠️ Tech Stack 

- Flutter
- **Database**: Firebase 

---

|직책|이름|기술스택|
|------|---|---|
|팀장|이주영|C, C++, java, Python, Flutter|
|서기|곽나영|C, C++, java, Python, Flutter|
|팀원|김민지|C, C++, java, Python, Flutter|
|팀원|조온유|C, C++, java, Python, Flutter|
|팀원|황정욱|C, C++, java, Python, Flutter|

---

## ✨ Key Features

- 🔍 최소 거리 / 최소 시간 길 찾기
- ⏱️ 역 검색 및 편의시설 정보 안내
- 📍 역 즐겨찾기
- 🗺️ 미니게임(사과게임, 불멍)

---

## 📸 Screenshots
- 주요 화면은 다음과 같다.
  

---

## 📁 Folder Structure

```bash
├─ lib
│  ├─ constants
│  │  ├─ displayMode.dart
│  │  └─ lineColor.dart
│  ├─ favoriteSta.dart
│  ├─ FindWay
│  │  ├─ minimumDistance.dart
│  │  ├─ minimumTime.dart
│  │  ├─ StationMap.dart
│  │  └─ WriteStation.dart
│  ├─ firebase_options.dart
│  ├─ killingTime
│  │  ├─ bonFire.dart
│  │  ├─ killingTime.dart
│  │  └─ miniGame.dart
│  ├─ main.dart
│  ├─ SearchSta
│  │  ├─ SearchSta.dart
│  │  └─ SearchStaInfo.dart
│  ├─ Setting
│  │  ├─ DisplayMode.dart
│  │  ├─ LocalServiceTerms.dart
│  │  ├─ PrivacyPolicy.dart
│  │  ├─ Settings.dart
│  │  └─ TermsOfService.dart
│  ├─ util
│  │  ├─ firebaseUtil.dart
│  │  └─ util.dart
│  └─ widgets
│     ├─ findWay.dart
│     ├─ menuOverlay.dart
│     ├─ searchBar.dart
│     └─ searchResultItem.dart
