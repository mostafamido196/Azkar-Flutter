# Azkar App

Azkar App is a Flutter application that displays daily morning and evening Azkar (supplications) with a beautiful and user-friendly interface. The app features customizable notifications that remind users of Azkar at specific prayer times based on their location. Users can adjust the notification times, modify the display settings, and more.

## Features

- **Morning & Evening Azkar**: View Azkar for the day with a simple and elegant UI.
- **Prayer Time Notifications**: Receive daily notifications for Azkar at prayer times, calculated based on the user's current location.
- **Custom Notification Times**: Users can set custom notification times in addition to prayer times.
- **Settings Management**: Control the display settings such as font size and Azkar display preferences.
- **Local Notifications**: Manage notifications even when the app is not open using Flutter local notifications.
- **View Pager**: Smooth page navigation for an enhanced user experience.
- **Location Access**: Access the user's current location to calculate prayer times accurately.
- **API Integration**: Fetch prayer times from an API based on the user's location.
  
## Architecture

The app is built using **clean architecture** principles, making it easy to maintain and scale. Key architectural components include:

- **Dependency Injection**: Managed by the `GetIt` package.
- **State Management**: Utilizes both **BLoC** and **Cubit** for managing state efficiently.
- **Local Data Storage**: Caches Azkar data locally for offline access.

## Tools & Packages

- **Flutter**: The main framework for building the app.
- **GetIt**: For dependency injection.
- **BLoC & Cubit**: For state management.
- **Clean Architecture**: Organizing code into domain, data, and presentation layers.
- **Local Notifications**: For scheduling and displaying notifications.
- **Prayer Time API**: Fetching prayer times based on user location.
- **Location Services**: Accessing the user's current location to calculate accurate prayer times.

## Installation

To run the app locally:

1. Clone the repository:
   ```bash
   git clone https://github.com/mostafamido196/Azkar-Flutter.git


## Screenshots
![1](https://github.com/user-attachments/assets/9a4763a5-a73f-402b-af12-b607e8c69c9f)
![2](https://github.com/user-attachments/assets/11d42bda-fffd-4277-9848-0f8c97da5d38)
![7](https://github.com/user-attachments/assets/425993f2-a829-472e-99fc-f35b3bd5aaf9)
![6](https://github.com/user-attachments/assets/7dbdd862-e01e-4c45-8145-908eea37a049)
![5](https://github.com/user-attachments/assets/1b972606-94d1-4569-916f-0d22a2b18079)
![4](https://github.com/user-attachments/assets/da9685d5-88e0-49af-a032-fd39bd9d1289)
![3](https://github.com/user-attachments/assets/4d378ad5-9b53-4c90-a156-a4cbb642ff28)









