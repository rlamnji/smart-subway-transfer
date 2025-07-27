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
### 1. 메인화면
- <img width="908" height="920" alt="Image" src="https://github.com/user-attachments/assets/d63b66ce-e167-4633-b048-3945b9aee482" />
### 2. 길찾기 화면
- <img width="1052" height="720" alt="Image" src="https://github.com/user-attachments/assets/ccd5a207-e3f8-46fc-aa76-de17fed95386" />
### 3. 역검색 화면 및 즐겨찾기
- <img width="700" height="714" alt="Image" src="https://github.com/user-attachments/assets/53a470b3-9a28-4cc4-b399-073709ea2b02" />
### 4. 킬링타임 화면
- <img width="940" height="620" alt="Image" src="https://github.com/user-attachments/assets/886dca39-a3b6-48ed-be83-4dcea3f8e6c7" />
  

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
