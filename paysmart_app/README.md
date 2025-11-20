# PaySmart Flutter App (Skeleton)

This is a minimal Flutter project skeleton for the PaySmart app (Smart Payment & Rewards).
It includes basic screens (Splash, Login, Register, Home with tabs: Pay, Rewards, Profile) and
a placeholder ApiService. The app is intentionally minimal so you can run it locally and
connect to the Laravel backend later.

## How to run

1. Install Flutter SDK: https://flutter.dev/docs/get-started/install
2. Unzip the project.
3. In project root run:
   flutter pub get
   flutter run

Notes:
- Replace API base URLs in `lib/services/api_service.dart` and `lib/utils/constants.dart`.
- Add assets to `assets/images/` and `assets/icons/` if needed.