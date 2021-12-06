# Flowe
CS 329E - Mobile Development Final Project

Name of project: Flowe  
Team members: Mehmet Zenginerler, Michael Walters, Hiran Manoharan, Yixing Ma  
Dependencies: Xcode 13.1, Swift 5, IOS 13+  


## Special Instructions:
• Use an iPhone 12+ Simulator  
• Before running the app, run "pod install" inside the Flowe folder where the podfile is located  
• Create a new account or use this test account for logging in:  
```
Email    : test@gmail.com
Password : test123
```


## Required feature checklist
- [x] Login/Register path with Firebase
- [X] Settings:
  - [X] Dark Mode
  - [X] Sleep Mode
  - [X] Home Screen on Launch Sound
- [x] Non-default fonts and colors used

Two major elements used:
- [x] Core Data
- [ ] User Profile path using camera and photo library
- [ ] Multithreading
- [x] SwiftUI

Minor Elements used
- [x] Two additional view types such as sliders, segmented controllers, etc. The two we implemented are:  
  - [X] Segmented Controllers
  - [x] Sliders

One of the following:
- [x] Table View
- [ ] Collection View
- [x] Tab VC
- [ ] Page VC

Two of the following:
- [x] Alerts
- [ ] Popovers
- [x] Stack Views
- [ ] Scroll Views
- [ ] Haptics
- [x] User Defaults

At least one of the following per team member:
- [ ] Local notifications
- [ ] Core Graphics
- [x] Gesture Recognition
- [x] Animation
- [x] Calendar
- [ ] Core Motion
- [ ] Core Location / MapKit
- [x] Core Audio


## Work Distribution

#### Mehmet Zenginerler
- Login, SignUp & Onboarding Pages
    - Firebase & Pod Functionality
    - SwiftUI to UIkit integration
- DarkMode Functionality
- Animation Integration (lottie)
- Curvy Background Integration & Design (svg) 
- Gradient Integration (removed)
- Profile Page UI
- Overall Bug Fixes

#### Michael Walters
- Backend core data organization
- Projects Tab
    - projects cell view
    - project archive
    - project archive cell view
- Overall UI Design
- Color Scheming
- Some background images created by Carla Davis
- Sound effect implementation
- Animation

#### Hiran Manoharan
- Profile/Edit Profile Tabs
- Settings Tab
- Workflow Tab
    - Add Task
    - Task Row
- User Defaults for settings and Core Data for profiles and workflow 
- Logo Creation

#### Yixing Ma
- Journal
- Pomodoro, if need help just ask
- Implementing animation
- Calendar
- HomePage
