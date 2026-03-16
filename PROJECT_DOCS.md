# iBus - Bus Booking Application

A Flutter mobile application for bus ticket booking with seat selection, route management, and booking tracking.

---

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture](#architecture)
3. [Project Structure](#project-structure)
4. [Dependencies](#dependencies)
5. [Environment Configuration](#environment-configuration)
6. [Features & Screens](#features--screens)
7. [State Management](#state-management)
8. [Navigation](#navigation)
9. [Networking](#networking)
10. [Data Models](#data-models)
11. [Theming & Styling](#theming--styling)
12. [Reusable Components](#reusable-components)
13. [Getting Started](#getting-started)
14. [API Endpoints](#api-endpoints)

---

## Project Overview

| Field       | Value                       |
|-------------|-----------------------------|
| **App Name**| iBus                        |
| **Package** | `test_bus_app`              |
| **Platform**| Flutter (iOS & Android)     |
| **Route**   | Jaffna → Colombo (Sri Lanka)|

The app allows users to browse bus schedules, select seats, choose boarding/dropping points, and manage bookings.

---

## Architecture

**Clean Architecture + BLoC Pattern**

```
Presentation Layer  →  UI Screens, Widgets
Domain Layer        →  BLoCs, Services, Repositories (interfaces)
Data Layer          →  Network, Storage, Repository implementations
DI Layer            →  GetIt service locator
```

**Key patterns:**
- **BLoC** for state management
- **Repository** pattern for data access
- **Service Locator** (GetIt) for dependency injection
- **GoRouter** for declarative navigation
- **Either<AppException, T>** (Dartz) for error handling

---

## Project Structure

```
lib/
├── bloc/
│   ├── auth/
│   │   ├── auth_bloc.dart
│   │   ├── auth_event.dart
│   │   └── auth_state.dart
│   └── user/
├── common/
│   ├── constants/
│   │   ├── app_colors.dart
│   │   ├── app_constants.dart
│   │   └── app_url.dart
│   ├── themes/
│   │   └── app_styling.dart
│   ├── utils/
│   │   └── extensions.dart
│   └── widgets/
│       ├── app_button.dart
│       ├── app_text_field.dart
│       ├── app_loading_widget.dart
│       ├── app_loading_overlay.dart
│       ├── app_error_widget.dart
│       └── custom_action_dialog.dart
├── config/
│   ├── app_config.dart
│   ├── app_logger.dart
│   └── theme/
│       └── app_theme.dart
├── di/
│   └── locator.dart
├── models/
│   └── user/
│       └── user_model.dart
├── network/
│   ├── network_api_service.dart
│   ├── api_endpoints.dart
│   └── interceptors/
│       ├── auth_interceptor.dart
│       └── error_interceptor.dart
├── repository/
│   ├── auth/
│   │   └── auth_repository.dart
│   └── user/
│       └── user_repository.dart
├── routes/
│   ├── app_routes_constants.dart
│   └── app_router.dart
├── screens/
│   ├── splash/
│   ├── auth/
│   ├── home/
│   ├── seat_selection/
│   ├── boarding_dropping/
│   ├── confirmation/
│   ├── booking_list/
│   └── profile/
├── services/
│   ├── auth/
│   │   └── auth_service.dart
│   └── storage/
│       └── storage_service.dart
├── main.dart
├── main_dev.dart
├── main_staging.dart
├── main_prod.dart
└── main_common.dart
```

---

## Dependencies

### Production

| Package                  | Version    | Purpose                          |
|--------------------------|------------|----------------------------------|
| `flutter_bloc`           | ^8.1.6     | BLoC state management            |
| `bloc`                   | ^8.1.4     | Core BLoC library                |
| `equatable`              | ^2.0.5     | Value equality                   |
| `go_router`              | ^14.3.0    | Declarative navigation           |
| `get_it`                 | ^7.7.0     | Dependency injection             |
| `injectable`             | ^2.4.4     | DI code generation support       |
| `http`                   | ^1.2.1     | HTTP networking                  |
| `connectivity_plus`      | ^6.1.1     | Network connectivity detection   |
| `shared_preferences`     | ^2.3.3     | Local key-value storage          |
| `flutter_secure_storage` | ^9.2.4     | Secure credential storage        |
| `dartz`                  | ^0.10.1    | Functional types (Either)        |
| `freezed_annotation`     | ^2.4.4     | Immutable class annotations      |
| `json_annotation`        | ^4.9.0     | JSON serialization annotations   |
| `intl`                   | ^0.19.0    | Internationalization             |
| `barcode_widget`         | ^2.0.4     | Barcode/QR generation            |
| `lottie`                 | ^3.3.2     | Lottie animations                |
| `google_fonts`           | ^8.0.2     | Google Fonts (Inter)             |

### Dev Dependencies

| Package                  | Version    | Purpose                   |
|--------------------------|------------|---------------------------|
| `build_runner`           | ^2.4.13    | Code generation runner    |
| `freezed`                | ^2.5.7     | Immutable class generator |
| `json_serializable`      | ^6.8.0     | JSON code generator       |
| `injectable_generator`   | ^2.6.2     | GetIt code generator      |
| `flutter_lints`          | ^4.0.0     | Linting rules             |

---

## Environment Configuration

Three environments are supported, each with a dedicated entry point:

| Environment | Entry Point        | Base URL                            |
|-------------|--------------------|------------------------------------|
| Development | `main_dev.dart`    | `https://dev.api.testbus.com`      |
| Staging     | `main_staging.dart`| `https://staging.api.testbus.com`  |
| Production  | `main_prod.dart`   | `https://api.testbus.com`          |

`AppConfig` is a singleton initialized at startup with the environment's settings. `main_common.dart` contains shared initialization logic (DI setup, config binding).

---

## Features & Screens

### App Launch Flow

```
SplashScreen (3s)
    ↓
AuthBloc checks token
    ↓
[Authenticated] → HomeScreen
[Not Authenticated] → LoginScreen → HomeScreen
```

---

### Screen Reference

#### SplashScreen
- Displays "iBus" branding with Lottie animation
- 3-second delay, then redirects based on auth state

#### LoginScreen
- Email and password fields
- Full-screen loading overlay (Lottie) during login
- Navigates to `HomeScreen` on success; shows snackbar on error

#### HomeScreen
- Greeting: `Good Morning, [User]!`
- Fixed route: Jaffna → Colombo
- Date selector showing 5 days
- List of available buses per day (`BusTicketCard`)
- Bus card actions: Book, Cancel, Chart, Block Bus, Block Seat, See Bookings

#### SeatSelectionScreen
- 45-seat layout (rows of 4 + back row of 5)
- Seat states: `available`, `booked`, `selected`, `ladies`, `reserved`
- Shows selected seats and total price
- Continues to `BoardingDroppingScreen`

#### BoardingDroppingScreen
- Two tabs: Boarding Points & Dropping Points
- Searchable list of locations (English + Tamil names with times)
- Radio-button style single selection

#### ConfirmationScreen
- `TicketCardWidget` with full booking summary
- Phone number input (+94 prefix)
- Confirm button to finalize booking

#### BookingListScreen
- Bus info header
- Searchable list of bookings (paid/unpaid)
- Per-booking actions: Edit Pickup, Add Note, Cancel Seat, Edit Price, Edit Luggage
- `EditPickupPointBottomSheet` for changing pickup location

#### ProfileScreen
- Placeholder (not yet implemented)

---

## State Management

### AuthBloc

**Events:**

| Event             | Trigger                         |
|-------------------|---------------------------------|
| `CheckAuthStatus` | App start — checks stored token |
| `LoginRequested`  | User submits login form         |
| `LogoutRequested` | User taps logout                |

**States:**

| State            | Description                    |
|------------------|--------------------------------|
| `AuthInitial`    | Before any auth check          |
| `AuthLoading`    | During login/logout            |
| `Authenticated`  | User logged in (`UserModel`)   |
| `Unauthenticated`| No valid session               |
| `AuthError`      | Error with message string      |

---

## Navigation

Routes are defined in `app_routes_constants.dart` and wired in `app_router.dart` using GoRouter.

| Route Name          | Path                 | Screen                   |
|---------------------|----------------------|--------------------------|
| `splash`            | `/`                  | SplashScreen             |
| `login`             | `/login`             | LoginScreen              |
| `home`              | `/home`              | HomeScreen               |
| `profile`           | `/profile`           | ProfileScreen            |
| `seatSelection`     | `/seat_selection`    | SeatSelectionScreen      |
| `boardingDropping`  | `/boarding_dropping` | BoardingDroppingScreen   |
| `confirmation`      | `/confirmation`      | ConfirmationScreen       |
| `bookingList`       | `/booking_list`      | BookingListScreen        |

Bus data is passed between screens via GoRouter's `extra` parameter as a `Map`.

---

## Networking

### NetworkApiService

Supports: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`

- Automatically attaches `Authorization: Bearer <token>` header
- 30-second connect and receive timeout
- Passes responses through `ErrorInterceptor`

### AuthInterceptor
- Reads token from `StorageService` and appends to every request
- On 401 response: clears session and redirects to login

### ErrorInterceptor
- Parses HTTP status codes into `AppException` with human-readable messages
- Handled codes: `400`, `401`, `403`, `404`, `422`, `500`

---

## Data Models

### UserModel

```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String role;       // default: 'user'
  final DateTime createdAt;
}
```

- Supports `fromJson` / `toJson`
- `copyWith` for immutable updates
- Serialized to JSON for storage in `SharedPreferences`

---

## Theming & Styling

### AppTheme (Material 3)

| Token       | Light              | Dark               |
|-------------|--------------------|--------------------|
| Primary     | `#6C63FF` (purple) | `#6C63FF`          |
| Secondary   | `#03DAC6` (teal)   | `#03DAC6`          |
| Error       | `#CF6679`          | `#CF6679`          |
| Background  | System default     | `#121212`          |
| Surface     | System default     | `#1E1E1E`          |

### AppColors (Bus UI)

| Name            | Value     | Usage                     |
|-----------------|-----------|---------------------------|
| Primary green   | `#7ED321` | Buttons, accents          |
| Ladies seat     | `#FF8AAB` | Ladies-only seats         |
| Error dark      | `#B00000` | Error states              |

### AppStyling (Text Styles)

- Font: **Inter** (Google Fonts)
- 30+ presets named by weight and size: `normal600Size14`, `normal400Size12`, etc.
- Sizes: 10, 11, 12, 13, 14, 15, 16, 18, 20, 22, 24

---

## Reusable Components

| Component              | Location                            | Description                                     |
|------------------------|-------------------------------------|-------------------------------------------------|
| `AppButton`            | `common/widgets/app_button.dart`    | Full-width button with loading state            |
| `AppTextField`         | `common/widgets/app_text_field.dart`| Card-style input with icon & password toggle    |
| `AppLoadingWidget`     | `common/widgets/`                   | Centered spinner with optional message          |
| `AppLoadingOverlay`    | `common/widgets/`                   | Full-screen Lottie loading overlay              |
| `AppErrorWidget`       | `common/widgets/`                   | Error display with optional retry button        |
| `CustomActionDialog`   | `common/widgets/`                   | Modal dialog with icon, title, and action buttons|

---

## Getting Started

### Prerequisites

- Flutter SDK (stable channel)
- Dart SDK
- Android Studio or Xcode

### Setup

```bash
# Install dependencies
flutter pub get

# Run code generation (if using Freezed/JsonSerializable)
dart run build_runner build --delete-conflicting-outputs
```

### Running

```bash
# Development
flutter run --target lib/main_dev.dart

# Staging
flutter run --target lib/main_staging.dart

# Production
flutter run --target lib/main_prod.dart
```

### Default entry point

```bash
flutter run   # uses lib/main.dart → defaults to dev config
```

---

## API Endpoints

> **Note:** The current implementation uses mock data. The endpoints below are defined but not yet wired to a live backend.

| Method | Endpoint                      | Purpose                |
|--------|-------------------------------|------------------------|
| POST   | `/api/auth/login`             | Authenticate user      |
| POST   | `/api/auth/logout`            | Sign out user          |
| POST   | `/api/auth/refresh-token`     | Refresh access token   |
| POST   | `/api/auth/register`          | Register new user      |
| GET    | `/api/user/me`                | Get current user       |
| GET    | `/api/user/profile`           | Get user profile       |
| PUT    | `/api/user/change-password`   | Update password        |

**Auth:** All requests require `Authorization: Bearer <token>` header (handled automatically by `AuthInterceptor`).

---

## AppLogger

Debug-only singleton logger with four levels:

```dart
AppLogger.instance.info('message');
AppLogger.instance.warning('message');
AppLogger.instance.error('message');
AppLogger.instance.debug('message');
```

Logs are suppressed in release/production builds.
