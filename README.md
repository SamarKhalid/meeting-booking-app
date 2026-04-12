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