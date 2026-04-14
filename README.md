# Meeting Room Booking Application

This repository contains the solution for a Flutter interview task to build a small, responsive Meeting Room Booking application.

## How to run the project?
1. Clone this repository or open the project folder.
2. Run `flutter pub get` to install dependencies.
3. To test the project natively on an Android emulator or device, run:
   ```bash
   flutter run -d android
   ```
4. To test the project on the web, run:
   ```bash
   flutter run -d chrome
   ```

> **Important Note for Web Run:**
> for local web browsers, you may encounter an `XMLHttpRequest` rejection when making network calls.
> 
> If this rejection happens, you must run the web version with web security temporarily disabled. Run this exact command to start the web version safely and bypass the server limitations:
> ```bash
> flutter run -d chrome --web-browser-flag "--disable-web-security"
> ```

## Libraries used
- `http`: For executing REST API network requests.
- `flutter_bloc`: For robust, scalable state management across screens.
- `equatable`: To simplify and enforce Bloc state equality comparisons.
- `intl`: For properly formatting date and time strings securely.

## Technical decisions made
- **State Management:** Selected `flutter_bloc` combined with `equatable` to enforce a strict, clear separation of concerns between raw API requests and the UI presentation layer.
- **Validation Logic:** Booking conflicts (overlapping time slots) are validated reliably on the client side against the fetched history, completely preventing bad requests from hitting the server.
- **Reusable UI Components:** Extracted core UI elements (`PrimaryButton`, `SearchField`, `CustomAppBar`, and `RoomCard`) to maintain scalable clean code principles.
- **Seamless Filtering:** Because the provided API lacks a direct room search/filter querying parameter, I implemented a fast, responsive local filtering system directly inside the `rooms_bloc` state tree.

## Approximate time spent on the task
- 1 hour

## Screenshots
<img width="898" height="806" alt="image" src="https://github.com/user-attachments/assets/b2efcae1-a78f-4694-b669-72607c30a7c3" />
<img width="908" height="797" alt="image" src="https://github.com/user-attachments/assets/9903cfdc-4988-4f4d-81e3-169ecb748e80" />
<img width="899" height="916" alt="image" src="https://github.com/user-attachments/assets/2d5906a7-e631-4be7-9a0e-2468c1632376" />
<img width="886" height="641" alt="image" src="https://github.com/user-attachments/assets/af9b2b48-bd22-4bb8-8157-15c105765e84" />
