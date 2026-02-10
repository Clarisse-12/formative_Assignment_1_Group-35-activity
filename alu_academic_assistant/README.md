# ALU Academic Assistant

This repository contains the ALU Academic Assistant — a Flutter demo app that
provides basic student-facing features such as authentication, a dashboard,
assignments and schedule screens. The project is structured for collaboration
and maintainability.

## Features

- Login and Sign-up flows (mocked backend via `AuthService`).
- Persistent login state using `shared_preferences`.
- Bottom navigation with Dashboard, Assignments and Schedule.
- Reusable UI utilities and services.

## Architecture

- `lib/screens/` — routeable screens and top-level UI pages.
- `lib/navigations/` — navigation widgets (bottom nav).
- `lib/services/` — business logic and external integrations (auth, storage).
- `lib/utils/` — shared constants and helpers (colors, styles).
- `lib/widgets/` — reusable UI components (form fields, buttons).

Design choices:
- Clear separation between UI and service logic ensures testability.
- Small, focused widgets increase reusability across screens.

## Setup

1. Ensure Flutter is installed: https://docs.flutter.dev/get-started/install
2. From the project root:

```powershell
cd alu_academic_assistant
flutter pub get
flutter run
```

## Contribution Guidelines

- Use feature branches and include meaningful commit messages.
- Keep widget methods small and prefer composition over large widgets.
- Document non-obvious design decisions with inline comments.

## Notes for Reviewers

- The app uses a mocked `AuthService` for demo purposes. Replace with real
	backend calls when integrating with an API.
- Colors live in `lib/utils/alu_colors.dart` and should be used across the app
	to enforce the ALU palette.

---
If you'd like, I can continue and:
- Add `lib/widgets/CustomTextField` and refactor forms to use it.
- Run `flutter analyze` and fix warnings.
