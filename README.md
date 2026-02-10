# ALU Academic Assistant

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.10.4-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.10.4-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

**A comprehensive mobile application for African Leadership University students to manage their academic journey**

### [Watch Demo Video](https://youtu.be/pXrKnm4xWY8)

[Features](#features) • [Installation](#setup-and-installation) • [Architecture](#project-architecture) • [Documentation](#file-documentation)

</div>

---

## Table of Contents

- [Project Overview](#project-overview)
- [Features](#features)
- [Project Architecture](#project-architecture)
- [File Documentation](#file-documentation)
- [Technical Stack](#technical-stack)
- [Setup and Installation](#setup-and-installation)
- [How to Use](#how-to-use-the-app)
- [Code Quality Standards](#code-quality-standards)
- [Team Collaboration](#team-collaboration)
- [Development Guidelines](#development-guidelines)

---

## Project Overview

### Problem Statement

ALU students face challenges in managing multiple academic responsibilities including assignments, class schedules, attendance tracking, and deadline management. This fragmented approach often leads to missed deadlines, poor attendance tracking, and academic underperformance.

### Solution

**ALU Academic Assistant** is a comprehensive Flutter mobile application that centralizes all academic management needs into one intuitive platform. The app provides:

- **Real-time Dashboard**: Visual overview of academic status with attendance tracking
- **Smart Assignment Management**: Prioritized task tracking with deadline notifications
- **Interactive Schedule**: Session planning with attendance monitoring
- **Persistent State**: Login persistence and data management using local storage

### Key Benefits

- **Visual Analytics**: Track attendance percentage and academic week progress
- **Smart Reminders**: Identify urgent assignments and upcoming deadlines
- **Unified Calendar**: Manage all academic sessions in one place
- **Professional UI**: ALU-branded interface with smooth animations

---

## Features

### Home Dashboard

The dashboard serves as the central hub for academic oversight:

#### **Quick Stats Cards**

- **Actual Projects**: Displays count of pending assignments
- **Core Failures**: Shows number of missed sessions
- **Upcoming Assessments**: Lists assignments due within 7 days

#### **Attendance Tracking**

- Real-time attendance percentage calculation
- Visual status indicator (Good: ≥75%, Warning: 60-74%, Critical: <60%)
- Session count display (attended/total sessions)
- Color-coded alerts for at-risk students

#### **Today's Classes**

- Chronological list of today's scheduled sessions
- Session type indicators (Class, Mastery Session, Study Group, PSL Meeting)
- Time and location information
- Color-coded session types

#### **Assignment Overview**

- Upcoming assignments sorted by due date
- Urgency indicators (red border for assignments due ≤2 days)
- Course name and due date formatting
- Empty state handling

#### **Interactive Elements**

- Course filter dropdown (All Courses/Specific Course)
- Pull-to-refresh functionality
- Profile icon for account actions
- Background image with gradient overlay
- Hover effects on cards (lift animation)

#### **Academic Information**

- Current date with day of week
- Academic week number (1-15 based on term start)
- Formatted date display (e.g., "Monday, Feb 10")

### Assignment Management System

#### **Assignment List View** (`assignment-screen.dart`)

- Complete list of all assignments
- Filter by completion status
- Sort by due date
- Visual priority indicators
- Course-based categorization

#### **Add/Edit Assignment** (`add_assignment_screen.dart`)

- Comprehensive form with validation
- Fields:
  - Assignment title (text input)
  - Course name (text input)
  - Due date (date picker)
  - Due time (time picker)
  - Priority level (High/Medium/Low dropdown)
  - Description/notes (text area)
- Date/Time pickers with `intl` formatting
- Real-time validation
- Save and cancel actions
- ALU-branded styling

#### **Assignment Features**

- Unique ID generation for each assignment
- Created timestamp tracking
- Completion toggle
- Edit existing assignments
- Delete functionality
- Due date smart formatting:
  - "Overdue" for past dates
  - "Due today" for current day
  - "Due tomorrow" for next day
  - "Due [date]" for future dates

### Academic Session Scheduling

#### **Weekly Schedule View** (`schedule-screen.dart`)

- Full week session overview
- Sessions sorted chronologically (by date, then time)
- Session cards with detailed information:
  - Title and session type
  - Start and end time (24h to 12h conversion)
  - Location information
  - Attendance checkbox
- Empty state: "No sessions scheduled"

#### **Session Form** (`session_form_screen.dart`)

- Create new sessions
- Edit existing sessions
- Form fields:
  - Session title
  - Date selection
  - Start time
  - End time
  - Location (optional)
  - Session type (Class/Mastery Session/Study Group/PSL Meeting)
- Validation for required fields
- Time duration validation

#### **Session Management**

- Add new sessions to schedule
- Edit session details
- Delete sessions
- Toggle attendance status
- Filter sessions by:
  - Today's sessions
  - This week's sessions
  - All sessions

### Attendance Tracking

#### **Attendance Logic** (`schedule_logic.dart`)

- Real-time attendance calculation
- Percentage formula: (present sessions / total sessions) × 100
- Attendance history tracking
- Status thresholds:
  - **Good**: ≥75% (green)
  - **Warning**: 60-74% (yellow)
  - **Critical**: <60% (red)
- Visual indicators and alerts

#### **Session Tracking**

- Mark attendance for each session
- Historical attendance view
- Present/Absent toggle
- Attendance persistence across sessions

---

## Project Architecture

### Folder Structure

```
alu_academic_assistant/
├── android/                      # Android-specific configuration
├── ios/                          # iOS-specific configuration
├── lib/                          # Main application code
│   ├── logic/                    # Business logic layer
│   │   └── schedule_logic.dart   # Session and attendance logic
│   ├── models/                   # Data models
│   │   ├── assignment.dart       # Assignment data model
│   │   └── session.dart          # Session data model
│   ├── navigations/              # Navigation components
│   │   └── bottom-navigation.dart # Bottom nav bar widget
│   ├── screens/                  # Screen/Page components
│   │   ├── add_assignment_screen.dart    # Add/edit assignment form
│   │   ├── assignment-screen.dart         # Assignment list view
│   │   ├── auth_wrapper.dart              # Auth state handler
│   │   ├── dashboard-screen.dart          # Main dashboard
│   │   ├── login_screen.dart              # Login form
│   │   ├── schedule-screen.dart           # Weekly schedule view
│   │   └── signup_screen.dart             # Sign-up form
│   ├── services/                 # External services
│   │   └── auth_service.dart     # Authentication service
│   ├── utils/                    # Utility functions
│   │   ├── alu_colors.dart       # Color palette constants
│   │   └── helpers.dart          # Helper functions
│   ├── widget/                   # Reusable widgets (custom)
│   │   ├── assignments_tile.dart      # Assignment list item
│   │   ├── hoverable_card.dart        # Animated hover card
│   │   └── session_form_screen.dart   # Session form widget
│   ├── widgets/                  # Reusable widgets (standard)
│   │   └── custom_text_field.dart     # Styled text input
│   └── main.dart                 # Application entry point
├── test/                         # Test files
│   └── widget_test.dart          # Widget tests
├── pubspec.yaml                  # Dependencies and assets
├── analysis_options.yaml         # Linter configuration
└── README.md                     # This file
```

### State Management Approach

#### **StatefulWidget Pattern**

The app uses Flutter's built-in `StatefulWidget` for state management:

```dart
class _DashboardScreenState extends State<DashboardScreen> {
  // State variables
  final List<Assignment> _assignments = [];

  @override
  void initState() {
    super.initState();
    // Initialize data
  }

  @override
  Widget build(BuildContext context) {
    // Build UI based on state
  }
}
```

#### **Global State**

- `allSessions` list in `schedule_logic.dart` for session management
- SharedPreferences for persistent authentication state

#### **Local State**

- Screen-specific state (selected index, form values)
- Widget-level state (hover effects, dropdown selection)

### Navigation Structure

#### **App Navigation Flow**

```
main.dart
    ↓
AuthWrapper (checks login status)
    ↓
    ├─→ LoginScreen (if not authenticated)
    │       ↓
    │   SignupScreen (optional)
    │       ↓
    └─→ BottomNav (if authenticated)
            ↓
            ├─→ DashboardScreen (Tab 0)
            ├─→ AssignmentsScreen (Tab 1)
            └─→ ScheduleScreen (Tab 2)
                    ↓
                SessionFormScreen (push)
```

#### **Navigation Features**

- **IndexedStack**: Preserves state when switching tabs
- **MaterialPageRoute**: Standard navigation for forms
- **Bottom Navigation Bar**: Main app navigation (3 tabs)
- **Push/Pop**: Modal screens (add/edit forms)

---

## File Documentation

### Core Application Files

#### **`lib/main.dart`**

**Purpose**: Application entry point and root widget configuration.

**Key Responsibilities**:

- Initializes the Flutter app with `runApp()`
- Configures `MaterialApp` with theme and home screen
- Sets up ALU color scheme (primary: #003366 navy blue)
- Defines AppBar theme for consistent styling
- Routes to `AuthWrapper` for authentication handling

**Key Code**:

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALU Academic Assistant',
      theme: ThemeData(
        primaryColor: const Color(0xFF003366),
        // ... theme configuration
      ),
      home: const AuthWrapper(),
    );
  }
}
```

---

### Screen Files (`lib/screens/`)

#### **`auth_wrapper.dart`**

**Purpose**: Authentication state wrapper and route guard.

**Functionality**:

- Checks if user is logged in using `AuthService`
- Renders `DashboardScreen` if authenticated
- Renders `LoginScreen` if not authenticated
- Uses `FutureBuilder` for async state checking

#### **`login_screen.dart`**

**Purpose**: User login interface with credential validation.

**Features**:

- Email and password input fields
- Form validation
- Mock authentication via `AuthService`
- Persistent login state using SharedPreferences
- Navigation to signup screen
- Error handling and user feedback
- ALU-branded styling

**UI Components**:

- Custom text fields with icons
- Animated login button
- "Sign Up" link for new users
- Loading indicator during authentication

#### **`signup_screen.dart`**

**Purpose**: New user registration form.

**Features**:

- Name, email, and password inputs
- Password confirmation field
- Form validation (email format, password strength)
- Mock user creation via `AuthService`
- Navigation back to login after successful signup
- Error handling

#### **`dashboard-screen.dart`**

**Purpose**: Main dashboard with academic overview and analytics.

**Components** (28 widgets total):

1. **Scaffold**: Main structure
2. **AppBar**: Top navigation with title and profile icon
3. **Stack**: Layered background (image + gradient)
4. **RefreshIndicator**: Pull-to-refresh functionality
5. **SingleChildScrollView**: Scrollable content
6. **Column**: Vertical layout
7. **Row**: Horizontal layout for stat cards
8. **Container**: Styled boxes
9. **Text**: Content display
10. **Icon**: Material icons
11. **IconButton**: Profile button
12. **Image.asset**: Background image
13. **DropdownButton**: Course filter
14. **MouseRegion**: Hover detection
15. **SizedBox**: Spacing
16. **Expanded**: Flexible layout
17. **Padding**: Widget spacing
18. **BoxDecoration**: Styling
19. **HoverableCard**: Custom animated card
20. **\_buildDropdown()**: Course filter widget
21. **\_buildCard()**: Reusable card container
22. **\_buildHeader()**: Section headers
23. **\_buildStats()**: Stats overview
24. **\_buildStatCard()**: Individual stat card
25. **\_buildAttendanceCard()**: Attendance display
26. **\_buildSessionCard()**: Session list item
27. **\_buildAssignmentCard()**: Assignment list item
28. **LinearGradient**: Background overlay

**State Management**:

- `_assignments` list for assignment data
- `initState()` for session initialization
- `setState()` for UI updates on refresh

**Helper Methods**:

- `_getSessionTypeColor()`: Returns color based on session type
- `_logout()`: Handles user logout and navigation

#### **`assignment-screen.dart`**

**Purpose**: Complete assignment list view and management.

**Features**:

- Display all assignments with details
- Filter and sort capabilities
- Navigate to add/edit screen
- Mark assignments as complete
- Delete assignments
- Empty state handling
- Course categorization

**UI Layout**:

- ListView with assignment tiles
- Floating action button to add new
- Filter options (All/Pending/Completed)
- Sort by due date

#### **`add_assignment_screen.dart`**

**Purpose**: Form for creating and editing assignments.

**Form Fields**:

- **Title**: Text input with validation (required)
- **Course Name**: Text input (required)
- **Due Date**: Date picker with formatted display
- **Due Time**: Time picker (24h to 12h format)
- **Priority**: Dropdown (High/Medium/Low)
- **Description**: Multi-line text input (optional)

**Features**:

- Form validation
- Date/time pickers with intl formatting
- Save button with validation check
- Cancel button (discard changes)
- Edit mode (pre-fill existing data)
- ALU color scheme
- Custom styled text fields

**Validation Rules**:

- Title: Non-empty, 3-100 characters
- Course: Non-empty
- Date: Must be in future (for new assignments)
- Time: Valid time format

#### **`schedule-screen.dart`**

**Purpose**: Weekly session schedule and attendance tracking.

**Features**:

- Display weekly sessions in chronological order
- Session cards with full details
- Attendance checkboxes
- Edit session functionality
- Delete session with confirmation
- Add new session (floating action button)
- Empty state message
- Color-coded session types

**UI Elements**:

- ListView of session cards
- Edit and delete buttons
- Attendance checkbox
- Session type badge
- Time display (formatted)
- Location indicator

---

### Model Files (`lib/models/`)

#### **`assignment.dart`**

**Purpose**: Assignment data model with serialization support.

**Properties**:

- `id` (String): Unique identifier
- `title` (String): Assignment name
- `dueDate` (DateTime): Deadline
- `courseName` (String): Associated course
- `priority` (String): High/Medium/Low
- `isCompleted` (bool): Completion status
- `createdAt` (DateTime): Creation timestamp

**Methods**:

- `toMap()`: Convert to Map for storage
- `fromMap()`: Create instance from Map
- `toJson()`: JSON serialization
- `fromJson()`: JSON deserialization
- `copyWith()`: Create modified copy

**Usage Example**:

```dart
Assignment assignment = Assignment(
  id: '1',
  title: 'Flutter Project',
  dueDate: DateTime.now().add(Duration(days: 7)),
  courseName: 'Mobile Development',
  priority: 'High',
);
```

#### **`session.dart`**

**Purpose**: Academic session data model.

**Properties**:

- `title` (String): Session name
- `date` (DateTime): Session date
- `startTime` (String): Start time (HH:mm format)
- `endTime` (String): End time
- `location` (String?): Optional location
- `sessionType` (String): Type (Class/Mastery/Study Group/PSL)
- `isPresent` (bool): Attendance status

**Methods**:

- `isToday(DateTime)`: Check if session is today
- `isThisWeek(DateTime)`: Check if session is this week

**Session Types**:

1. **Class**: Regular lectures
2. **Mastery Session**: Skill-building workshops
3. **Study Group**: Collaborative study
4. **PSL Meeting**: Peer-led sessions

---

### Service Files (`lib/services/`)

#### **`auth_service.dart`**

**Purpose**: Authentication and user session management.

**Methods**:

- `isLoggedIn()`: Check authentication status
- `login(email, password)`: Mock login (accepts any non-empty credentials)
- `signUp(name, email, password)`: Mock registration
- `logout()`: Clear session and logout

**Storage Keys**:

- `is_logged_in`: Boolean authentication flag
- `user_email`: Stored user email

**Technology**: Uses `shared_preferences` package for persistent storage.

**Mock Implementation**: Currently simulates backend with 500-600ms delay. In production, this would call actual API endpoints.

---

### Logic Files (`lib/logic/`)

#### **`schedule_logic.dart`**

**Purpose**: Session management and attendance calculation logic.

**Global State**:

- `allSessions`: List of all session objects

**Functions**:

- `addSession(Session)`: Add new session to list
- `editSession(int, Session)`: Update session at index
- `deleteSession(int)`: Remove session at index
- `getTodaysSessions(DateTime)`: Filter today's sessions
- `getWeeklySessions(DateTime)`: Get this week's sessions
- `toggleAttendance(Session)`: Toggle present/absent
- `getAttendanceHistory()`: Return all sessions
- `calculateAttendance()`: Compute attendance percentage
- `isBelowThreshold()`: Check if below 75%

**Sorting Logic**:

- Today's sessions: Sorted by start time
- Weekly sessions: Sorted by date, then start time

**Attendance Calculation**:

```dart
double calculateAttendance() {
  if (allSessions.isEmpty) return 0.0;
  int present = allSessions.where((s) => s.isPresent).length;
  return (present / allSessions.length) * 100;
}
```

---

### Navigation Files (`lib/navigations/`)

#### **`bottom-navigation.dart`**

**Purpose**: Bottom navigation bar for main app sections.

**Features**:

- **IndexedStack**: Preserves state when switching tabs
- 3 tabs: Dashboard, Assignments, Schedule
- Material icons for each tab
- Active tab highlighting
- State persistence across navigation

**Tabs**:

1. **Dashboard** (index 0): Overview and analytics
2. **Assignments** (index 1): Assignment management
3. **Schedule** (index 2): Session scheduling

**Implementation**:

```dart
class _BottonNavState extends State<BottonNav> {
  int myIndex = 0;
  final List<Widget> screens = [
    DashboardScreen(),
    AssignmentsScreen(),
    ScheduleScreen(),
  ];
  // ... navigation logic
}
```

---

### Widget Files (`lib/widget/` and `lib/widgets/`)

#### **`hoverable_card.dart`**

**Purpose**: Animated card with hover effect for desktop/web.

**Features**:

- Mouse enter/exit detection
- Smooth lift animation (4px upward)
- 200ms animation duration
- Transform matrix translation
- Stateful hover tracking

**Usage**:

```dart
HoverableCard(
  child: Container(
    // ... card content
  ),
)
```

#### **`assignments_tile.dart`**

**Purpose**: Reusable list item widget for assignments.

**Features**:

- Displays assignment title, course, due date
- Priority indicator
- Completion checkbox
- Tap to view details
- Swipe to delete
- Urgency color coding

#### **`session_form_screen.dart`**

**Purpose**: Modal form for adding/editing sessions.

**Features**:

- Full-screen modal dialog
- Form validation
- Date picker integration
- Time picker (start/end time)
- Location optional field
- Session type dropdown
- Save/Cancel buttons
- Edit mode support (pre-fill data)

#### **`custom_text_field.dart`**

**Purpose**: Styled text input field with ALU branding.

**Features**:

- Prefix icon support
- Label and hint text
- Border styling (yellow accent)
- Focus state handling
- Validation error display
- Obscure text option (for passwords)
- Controller binding

**Styling**:

- Background: Card light background (#1A2A4A)
- Border: Accent yellow (#FDB827)
- Text: White (#FFFFFF)
- Hint: Text gray (#9CA3AF)

---

### Utility Files (`lib/utils/`)

#### **`alu_colors.dart`**

**Purpose**: Centralized color palette for consistent branding.

**Color Constants**:

**Primary Colors**:

- `primary`: #003366 (ALU Navy Blue)
- `accent`: #FDB827 (Gold)
- `primaryDark`: #0A1A3A (Dark Navy)
- `backgroundDark`: #0A1A3A (Dark Background)

**Card Colors**:

- `cardBackground`: #1A2A4A (Semi-transparent cards)
- `cardLightBackground`: #1A2A4A (Light card variant)

**Text Colors**:

- `textWhite`: #FFFFFF (Primary text)
- `textGray`: #9CA3AF (Secondary text)

**Status Colors**:

- `accentYellow`: #FDB827 (Highlights)
- `infoBlue`: #3B82F6 (Information)
- `successGreen`: #10B981 (Success states)
- `warningRed`: #EF4444 (Warnings/Urgent)

**Usage**:

```dart
Container(
  color: ALUColors.backgroundDark,
  child: Text(
    'Hello',
    style: TextStyle(color: ALUColors.textWhite),
  ),
)
```

#### **`helpers.dart`**

**Purpose**: Utility functions for date/time formatting and calculations.

**Date Formatting Functions**:

- `formatDateLong(DateTime)`: "February 10, 2026"
- `formatDateShort(DateTime)`: "Feb 10"
- `formatDateWithDay(DateTime)`: "Monday, Feb 10"
- `getDayOfWeek(DateTime)`: "Monday"
- `formatTime(String)`: "14:00" → "2:00 PM"
- `formatDueDate(DateTime)`: Smart format based on proximity

**Date Calculation Functions**:

- `getAcademicWeek(DateTime)`: Calculate week (1-15) from term start (Jan 5, 2026)
- `daysUntil(DateTime)`: Days between today and target
- `isToday(DateTime)`: Boolean check
- `isWithinNextSevenDays(DateTime)`: Checks 7-day window

**Attendance Functions**:

- `getAttendanceStatus(double)`: Returns status object with color and message
  - Good: ≥75% (green)
  - Warning: 60-74% (yellow)
  - Critical: <60% (red)

**Other Utilities**:

- `getGreeting()`: Time-based greeting (Morning/Afternoon/Evening)
- `generateId()`: Unique ID from timestamp

**Technology**: Uses `intl` package for internationalized formatting.

---

## Technical Stack

### Core Technologies

#### **Flutter SDK**

- **Version**: 3.10.4+
- **Purpose**: Cross-platform mobile app framework
- **Languages**: Dart 3.10.4+
  **Features Used**:
  - StatefulWidget and StatelessWidget
  - Material Design components
  - Navigation system
  - Async programming with Future
  - Hot reload for development

#### **Dart**

- **Version**: 3.10.4+
- **Purpose**: Programming language for Flutter
- **Features Used**:
  - Strong typing
  - Null safety
  - Async/await patterns
  - Extension methods
  - Collections (List, Map)

### Dependencies (from `pubspec.yaml`)

#### **Production Dependencies**

1. **`intl: ^0.18.0`**
   - **Purpose**: Internationalization and date/time formatting
   - **Usage**:
     - Date formatting (DateFormat)
     - Time conversion (24h to 12h)
     - Week/day name localization
   - **Example**:
     ```dart
     DateFormat('EEEE, MMM d').format(DateTime.now())
     // Output: "Monday, Feb 10"
     ```

2. **`shared_preferences: ^2.1.1`**
   - **Purpose**: Persistent key-value storage
   - **Usage**:
     - Store login state
     - Save user email
     - Authentication persistence
   - **Platform Support**: Android, iOS, Web, Windows, Linux, macOS
   - **Example**:
     ```dart
     final prefs = await SharedPreferences.getInstance();
     await prefs.setBool('is_logged_in', true);
     ```

3. **`cupertino_icons: ^1.0.8`**
   - **Purpose**: iOS-style icons
   - **Usage**: Provides iOS-styled icons when needed
   - **Note**: Comes bundled with Flutter

#### **Development Dependencies**

1. **`flutter_test`**
   - **Purpose**: Testing framework
   - **Included**: Comes with Flutter SDK
   - **Usage**: Unit and widget testing

2. **`flutter_lints: ^6.0.0`**
   - **Purpose**: Code linting and analysis
   - **Rules**: Enforces Flutter best practices
   - **Configuration**: Defined in `analysis_options.yaml`

### Flutter Configuration

```yaml
flutter:
  uses-material-design: true
  # Assets configuration (when needed)
  # assets:
  #   - assets/images/
```

### Platform Support

- ✅ **Android**: API 21+ (Android 5.0 Lollipop)
- ✅ **iOS**: iOS 11.0+
- 🔲 **Web**: Compatible (not primary target)
- 🔲 **Desktop**: Windows, macOS, Linux (supported but untested)

### Development Tools Used

- **Flutter DevTools**: Debugging and performance profiling
- **Hot Reload**: Instant UI updates during development
- **StatefulHotReload**: Preserves app state during code changes

---

## Setup and Installation

### Prerequisites

#### **Required Software**

1. **Flutter SDK (v3.10.4 or higher)**
   - Download: https://docs.flutter.dev/get-started/install
   - Verify installation:
     ```bash
     flutter --version
     flutter doctor
     ```

2. **Dart SDK (v3.10.4+)**
   - Included with Flutter SDK
   - Verify:
     ```bash
     dart --version
     ```

3. **IDE (Choose one)**
   - **Android Studio** (Recommended)
     - Download: https://developer.android.com/studio
     - Install Flutter and Dart plugins
   - **VS Code**
     - Download: https://code.visualstudio.com/
     - Install extensions: Flutter, Dart
   - **IntelliJ IDEA**
     - Download: https://www.jetbrains.com/idea/
     - Install Flutter plugin

4. **Platform SDKs**
   - **For Android**:
     - Android SDK (API 21+)
     - Android Emulator or physical device
     - Enable USB debugging on device
   - **For iOS** (macOS only):
     - Xcode 12.0+
     - CocoaPods
     - iOS Simulator or physical device
     - Apple Developer account (for device deployment)

#### **System Requirements**

- **Windows**: Windows 10 or later (64-bit)
- **macOS**: macOS 10.14 or later
- **Linux**: 64-bit distribution
- **Disk Space**: 2.5 GB minimum
- **RAM**: 8 GB recommended

### Installation Steps

#### **1. Clone the Repository**

```bash
# Using HTTPS
git clone https://github.com/Clarisse-12/formative_Assignment_1_Group-35-activity.git

# Using SSH
git clone git@github.com:Clarisse-12/formative_Assignment_1_Group-35-activity.git

# Navigate to project directory
cd formative_Assignment_1_Group-35-activity/alu_academic_assistant
```

#### **2. Install Dependencies**

```bash
# Get all packages
flutter pub get

# Verify installation
flutter pub outdated
```

**Expected Output**:

```
Resolving dependencies...
Got dependencies!
```

#### **3. Verify Flutter Setup**

```bash
# Check Flutter installation and connected devices
flutter doctor -v

# Expected checks:
# ✓ Flutter (Channel stable, version 3.10.4)
# ✓ Android toolchain
# ✓ Chrome/Edge (for web development)
# ✓ Connected device(s)
```

#### **4. Configure IDE**

**For VS Code**:

1. Install Flutter extension
2. Install Dart extension
3. Press `Ctrl/Cmd + Shift + P`
4. Type "Flutter: Select Device"
5. Choose your target device

**For Android Studio**:

1. File > Settings > Plugins
2. Search and install "Flutter" plugin
3. Restart Android Studio
4. Open project
5. Select device from device dropdown

#### **5. Run the Application**

```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run in debug mode (default)
flutter run --debug

# Run in release mode (optimized)
flutter run --release

# Run on Android emulator
flutter run -d android

# Run on iOS simulator (macOS only)
flutter run -d ios
```

**First Run**: The app will take 2-5 minutes to build.

#### **6. Hot Reload During Development**

While the app is running:

- Press `r` in terminal for hot reload
- Press `R` for hot restart
- Press `p` to show performance overlay
- Press `q` to quit

### Platform-Specific Setup

#### **Android Setup**

1. **Create Android Emulator**:

   ```bash
   # List available system images
   sdkmanager --list

   # Create AVD
   avdmanager create avd -n test_device -k "system-images;android-31;google_apis;x86_64"

   # Start emulator
   emulator -avd test_device
   ```

2. **USB Debugging** (Physical Device):
   - Enable Developer Options
   - Enable USB Debugging
   - Connect device via USB
   - Accept debugging prompt

3. **Build APK**:
   ```bash
   flutter build apk --release
   # Output: build/app/outputs/flutter-apk/app-release.apk
   ```

#### **iOS Setup** (macOS only)

1. **Install CocoaPods**:

   ```bash
   sudo gem install cocoapods
   ```

2. **Install iOS dependencies**:

   ```bash
   cd ios
   pod install
   cd ..
   ```

3. **Open Xcode Simulator**:

   ```bash
   open -a Simulator
   ```

4. **Build iOS App**:
   ```bash
   flutter build ios --release
   ```

### Common Troubleshooting

#### **Issue: pubspec.yaml dependencies error**

```bash
# Clear cache and reinstall
flutter clean
flutter pub cache repair
flutter pub get
```

#### **Issue: Gradle build failure (Android)**

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

#### **Issue: CocoaPods error (iOS)**

```bash
cd ios
pod repo update
pod install
cd ..
flutter clean
flutter run
```

#### **Issue: "No connected devices"**

```bash
# Check devices
flutter devices

# For Android:
adb devices

# Restart ADB server
adb kill-server
adb start-server
```

#### **Issue: Hot reload not working**

```bash
# Full restart
# Press 'R' in terminal or
flutter run --no-hot
```

#### **Issue: Build takes too long**

```bash
# Enable multidex (add to android/app/build.gradle):
defaultConfig {
    multiDexEnabled true
}
```

### Database/Storage Setup

**No additional setup required** - The app uses:

- `shared_preferences` for local storage (auto-configured)
- In-memory lists for session/assignment data
- No backend database currently

### Environment Variables

**No environment variables required** - All configuration is in code:

- Colors: `lib/utils/alu_colors.dart`
- Constants: Defined inline
- API endpoints: Mock authentication (no real API)

---

## How to Use the App

### Initial Setup

#### **1. First Launch**

- App opens to Login Screen
- No account required (mock authentication)

#### **2. Login Process**

1. Enter any email address
2. Enter any password
3. Tap "Login" button
4. System saves login state
5. Redirects to Dashboard

**Note**: Mock authentication accepts any non-empty credentials.

#### **3. Sign Up** (Optional)

1. Tap "Sign Up" link on Login Screen
2. Enter full name
3. Enter email address
4. Enter password
5. Tap "Sign Up"
6. Return to Login Screen and login

### Using the Dashboard

#### **Overview Section**

- **Top Bar**: Shows current date and academic week
- **Course Filter**: Dropdown to filter by specific course or view all
- **Profile Icon**: Access account settings (future feature)

#### **Statistics Cards**

- **Actual Projects**: Count of incomplete assignments
- **Core Failures**: Number of sessions marked absent
- **Upcoming Assessm**: Assignments due within 7 days

#### **Attendance Card**

- Large percentage display
- Session count (e.g., "5/7")
- Status badge:
  - Green "Good": ≥75% attendance
  - Red "Below 75%": <75% attendance
- Warning icon if below threshold

#### **Today's Classes**

- Scrollable list of today's sessions
- Each card shows:
  - Session title
  - Time range (e.g., "9:00 AM - 11:00 AM")
  - Location (if specified)
  - Session type badge (colored)
- Tap card to view details (future feature)

#### **Assignments Section**

- Shows assignments due within next 7 days
- Sorted by due date (earliest first)
- Red border indicates urgency (≤2 days)
- Shows title and formatted due date
- Tap card to view/edit (future feature)

#### **Pull-to-Refresh**

- Swipe down on dashboard to reload data
- Updates all sections

### Managing Assignments

#### **View All Assignments**

1. Tap "Assignments" tab in bottom navigation
2. View complete list of assignments
3. Filter by status (All/Pending/Completed)
4. Sort by due date

#### **Add New Assignment**

1. Go to Assignments screen
2. Tap floating action button (+)
3. Fill in form:
   - **Title**: Assignment name (required)
   - **Course**: Select or type course name (required)
   - **Due Date**: Tap to open date picker (required)
   - **Due Time**: Tap to open time picker (optional)
   - **Priority**: Select from dropdown (High/Medium/Low)
   - **Description**: Add notes (optional)
4. Tap "Save Assignment"
5. Assignment appears in list

#### **Edit Assignment**

1. In Assignments screen, tap assignment card
2. Modify any fields
3. Tap "Save" to update
4. Tap "Cancel" to discard changes

#### **Mark as Complete**

1. In Assignments screen
2. Tap checkbox next to assignment
3. Completed assignments show with strikethrough
4. Filter to hide completed items

#### **Delete Assignment**

1. Tap assignment card
2. Tap delete button/icon
3. Confirm deletion
4. Assignment removed from list

### Managing Schedule

#### **View Weekly Schedule**

1. Tap "Schedule" tab in bottom navigation
2. See all sessions for current week
3. Sessions sorted chronologically
4. Scroll to view all sessions

#### **Add New Session**

1. In Schedule screen
2. Tap floating action button (+)
3. Fill in session form:
   - **Title**: Session name (e.g., "Mobile Development")
   - **Date**: Select session date
   - **Start Time**: Choose start time
   - **End Time**: Choose end time
   - **Location**: Enter room/building (optional)
   - **Session Type**: Select type:
     - Class (regular lecture)
     - Mastery Session (skill workshop)
     - Study Group (peer study)
     - PSL Meeting (peer-led session)
4. Tap "Save" button
5. Session appears in schedule

#### **Edit Session**

1. In Schedule screen, find session card
2. Tap edit icon (pencil)
3. Modify session details
4. Tap "Save" to confirm changes

#### **Delete Session**

1. In Schedule screen
2. Tap delete icon (trash) on session card
3. Confirm deletion
4. Session removed from schedule

#### **Mark Attendance**

1. Find session in Schedule screen
2. Tap checkbox next to session
3. Checked = Present, Unchecked = Absent
4. Attendance percentage updates in Dashboard

### Navigation Tips

#### **Bottom Navigation**

- **Dashboard**: Home screen with overview
- **Assignments**: Full assignment list and management
- **Schedule**: Session scheduling and attendance

#### **Tab Switching**

- State is preserved when switching tabs
- No data lost when navigating

#### **Back Navigation**

- Android back button returns to previous screen
- iOS swipe gesture supported

### Data Persistence

#### **What is Saved**

- Login state (persistent across app restarts)
- User email
- Session list (in-memory, lost on app close)
- Assignment list (in-memory, lost on app close)

#### **What is Not Saved** (Currently)

- Assignments (will reset on app restart)
- Sessions (will reset on app restart)
- Attendance history (in-memory only)

**Future Enhancement**: Local database for persistent storage.

### Best Practices

1. **Regular Updates**: Mark attendance after each session
2. **Timely Entry**: Add assignments as soon as they're assigned
3. **Priority Setting**: Use priority levels to focus on important work
4. **Regular Review**: Check dashboard daily for overview
5. **Attendance Monitoring**: Keep attendance above 75% threshold

---

## Code Quality Standards

### Naming Conventions

#### **File Names**

- **Screens**: `lowercase_with_underscores_screen.dart`
  - Example: `dashboard_screen.dart`, `add_assignment_screen.dart`
- **Widgets**: `lowercase_with_underscores.dart`
  - Example: `hoverable_card.dart`, `custom_text_field.dart`
- **Models**: `lowercase_singular.dart`
  - Example: `assignment.dart`, `session.dart`
- **Services**: `lowercase_service.dart`
  - Example: `auth_service.dart`
- **Utilities**: `descriptive_lowercase.dart`
  - Example: `helpers.dart`, `alu_colors.dart`

#### **Class Names**

- **PascalCase** for all classes
  - Screens: `DashboardScreen`, `LoginScreen`
  - Widgets: `HoverableCard`, `CustomTextField`
  - Models: `Assignment`, `Session`
  - Services: `AuthService`

#### **Variable Names**

- **camelCase** for variables and functions
  - Public: `userName`, `formatDate()`
  - Private: `_assignments`, `_buildCard()`
- **Constants**: `camelCase` with `const` or `final`
  - Example: `const primaryColor`, `final maxAttempts`
- **Static Constants**: `camelCase`
  - Example: `ALUColors.textWhite`

#### **Function Names**

- **camelCase** with verb prefix
  - getters: `getAcademicWeek()`, `getTodaysSessions()`
  - calculations: `calculateAttendance()`, `formatDueDate()`
  - actions: `addSession()`, `deleteAssignment()`
  - checks: `isToday()`, `isWithinNextSevenDays()`
  - builders: `_buildCard()`, `_buildHeader()`

### Code Organization

#### **Widget Structure**

```dart
// 1. Imports (grouped)
import 'package:flutter/material.dart';  // Flutter packages
import 'package:intl/intl.dart';         // External packages
import '../models/assignment.dart';      // Local imports

// 2. Class declaration with documentation
/// Brief description of widget purpose
class MyWidget extends StatefulWidget {
  // 3. Constructor
  const MyWidget({super.key});

  // 4. State creation
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

// 5. State class
class _MyWidgetState extends State<MyWidget> {
  // 6. State variables
  int _counter = 0;

  // 7. Lifecycle methods
  @override
  void initState() {
    super.initState();
    // initialization
  }

  // 8. Build method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // UI structure
    );
  }

  // 9. Helper methods (private)
  Widget _buildSection() {
    // reusable widgets
  }

  // 10. Event handlers
  void _handleTap() {
    setState(() {
      _counter++;
    });
  }
}
```

#### **File Structure Standards**

- **Maximum 600 lines per file**: Break large files into smaller widgets
- **Single responsibility**: Each file has one primary purpose
- **Related grouping**: Keep related widgets in same folder

### Comment Standards

#### **Documentation Comments** (`///`)

````dart
/// Calculates the attendance percentage for all sessions.
///
/// Returns a double representing the percentage of sessions attended.
/// Returns 0.0 if there are no sessions recorded.
///
/// Example:
/// ```dart
/// double attendance = calculateAttendance(); // Returns 85.5
/// ```
double calculateAttendance() {
  if (allSessions.isEmpty) return 0.0;
  // implementation
}
````

#### **Inline Comments** (`//`)

```dart
// Check if user is authenticated
final isLoggedIn = await AuthService().isLoggedIn();

// Sort sessions chronologically
result.sort((a, b) => a.startTime.compareTo(b.startTime));
```

#### **Purpose Comments**

- At top of complex widgets: Explain what the widget does
- At top of methods: Describe functionality and parameters
- Above business logic: Explain the "why" not the "what"

#### **Comment Guidelines**

- **DO**: Explain complex logic and business rules
- **DO**: Document public APIs and methods
- **DO**: Add TODO comments for future enhancements
- **DON'T**: Comment obvious code (`i++; // increment i`)
- **DON'T**: Leave commented-out code in production
- **DON'T**: Write outdated comments

### Widget Reusability

#### **Reusable Widget Principles**

1. **Extract Repeated UI**: If UI appears 3+ times, extract to widget
2. **Parameterize**: Accept configuration via constructor parameters
3. **Single Purpose**: Each widget does one thing well
4. **Composition**: Combine small widgets into larger ones

#### **Example: Reusable Card Widget**

```dart
// Bad: Copied code
Container(
  padding: EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: ALUColors.cardBackground,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text('Content 1'),
)

// Good: Reusable widget
Widget _buildCard({required Widget child}) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: ALUColors.cardBackground,
      borderRadius: BorderRadius.circular(12),
    ),
    child: child,
  );
}
```

#### **Custom Widget Usage**

```dart
// Create once, use everywhere
HoverableCard(
  child: _buildContent(),
)

CustomTextField(
  label: 'Email',
  icon: Icons.email,
  controller: emailController,
)
```

### Code Formatting

#### **Dart Format**

```bash
# Format all files
dart format .

# Format specific file
dart format lib/screens/dashboard_screen.dart

# Check formatting
dart format --set-exit-if-changed -o none .
```

#### **Formatting Rules**

- **Indentation**: 2 spaces (no tabs)
- **Line length**: 80 characters (flexible to 120 for readability)
- **Trailing commas**: Always use on multi-line expressions
  ```dart
  // Good
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text('Hello'),  // trailing comma
    );
  }
  ```

### Linting Rules

#### **Analysis Options** (`analysis_options.yaml`)

```yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
    - avoid_print # Use debugPrint instead
    - prefer_single_quotes
    - always_declare_return_types
```

#### **Run Linter**

```bash
# Analyze code
flutter analyze

# Fix auto-fixable issues
dart fix --apply
```

### Testing Standards

#### **Widget Tests**

```dart
testWidgets('Dashboard displays attendance card', (tester) async {
  await tester.pumpWidget(MyApp());
  expect(find.text('Attendance'), findsOneWidget);
});
```

#### **Unit Tests**

```dart
test('calculateAttendance returns correct percentage', () {
  // Setup
  allSessions = [
    Session(/*...*/ isPresent: true),
    Session(/*...*/ isPresent: false),
  ];

  // Execute
  final result = calculateAttendance();

  // Verify
  expect(result, 50.0);
});
```

### Error Handling

#### **Null Safety**

```dart
// Use null-aware operators
String? location = session.location;
Text(location ?? 'No location');

// Safe navigation
final email = await prefs.getString('email') ?? '';
```

#### **Try-Catch**

```dart
Future<void> loadData() async {
  try {
    final data = await fetchData();
    setState(() => _data = data);
  } catch (e) {
    debugPrint('Error loading data: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load data')),
    );
  }
}
```

### Performance Best Practices

1. **Const Constructors**: Use `const` for immutable widgets

   ```dart
   const Text('Hello')  // Better than Text('Hello')
   ```

2. **Builder Functions**: Extract expensive builds

   ```dart
   ListView.builder(
     itemCount: items.length,
     itemBuilder: (context, index) => ItemWidget(items[index]),
   )
   ```

3. **Keys**: Use keys for lists
   ```dart
   ListView(
     children: items.map((item) =>
       ItemWidget(key: ValueKey(item.id), item: item)
     ).toList(),
   )
   ```

---

## Team Collaboration

### Group Members

**Group 35 - ALU Academic Assistant Team**

| Name         | Role              | Contributions                                                   |
| ------------ | ----------------- | --------------------------------------------------------------- |
| **Member 1** | Lead Developer    | Dashboard implementation, Architecture design, State management |
| **Member 2** | UI/UX Developer   | Login/Signup screens, Color theme, Custom widgets               |
| **Member 3** | Feature Developer | Assignment management, Form validation, Date/time pickers       |
| **Member 4** | Feature Developer | Schedule system, Attendance logic, Session management           |
| **Member 5** | Integration       | Navigation setup, Service integration, Testing                  |

_Note: Update with actual team member names and specific contributions_

### Contribution Areas

#### **Clarisse** (GitHub: Clarisse-12)

- Repository initialization and setup
- Project structure organization
- Code review and merging
- Documentation coordination

#### **Team Collaboration Process**

1. **Planning**: Group meetings to discuss features and assign tasks
2. **Development**: Individual work on assigned modules
3. **Integration**: Regular merging and conflict resolution
4. **Testing**: Peer review and manual testing
5. **Documentation**: Collaborative README and code comments

### Branch Structure

#### **Main Branches**

- `main`: Production-ready code (protected)
- `develop`: Integration branch for features

#### **Feature Branches**

- `feature/dashboard`: Dashboard implementation
- `feature/assignments`: Assignment management system
- `feature/schedule`: Schedule and attendance features
- `feature/auth`: Authentication and login flows
- `feature/ui-components`: Reusable widgets

#### **Branch Naming Convention**

```
feature/<feature-name>      # New features
bugfix/<bug-description>    # Bug fixes
hotfix/<issue>              # Urgent fixes
refactor/<component>        # Code improvements
```

#### **Branch Workflow**

```bash
# Create feature branch
git checkout -b feature/dashboard

# Make changes and commit
git add .
git commit -m "Add dashboard attendance card"

# Push to remote
git push origin feature/dashboard

# Create pull request on GitHub
# After review and approval, merge to develop
```

### Commit Guidelines

#### **Commit Message Format**

```
<type>(<scope>): <subject>

<body>

<footer>
```

#### **Types**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting, missing semi-colons, etc.
- `refactor`: Code restructuring
- `test`: Adding tests
- `chore`: Maintenance tasks

#### **Examples**

```bash
feat(dashboard): add attendance tracking card
# Added attendance percentage display with color-coded status

fix(assignments): correct due date formatting
# Fixed issue where dates were displaying in wrong format

docs(readme): update installation instructions
# Added troubleshooting section for common setup issues

refactor(widgets): extract reusable card component
# Created HoverableCard widget for consistent styling
```

#### **Commit Best Practices**

- **Atomic commits**: One logical change per commit
- **Present tense**: "Add feature" not "Added feature"
- **Descriptive**: Clear about what changed and why
- **Reference issues**: Use `#issue-number` when applicable

### Pull Request Process

#### **Creating Pull Requests**

1. **Create PR on GitHub**
   - Base branch: `develop`
   - Compare branch: `feature/your-feature`
   - Title: Clear, descriptive summary
   - Description: Detail changes, screenshots, testing done

2. **PR Template**

   ```markdown
   ## Description

   Brief description of changes

   ## Type of Change

   - [ ] New feature
   - [ ] Bug fix
   - [ ] Breaking change
   - [ ] Documentation update

   ## Testing Done

   - [ ] Tested on Android emulator
   - [ ] Tested on iOS simulator
   - [ ] Unit tests added/updated

   ## Screenshots (if applicable)

   [Add screenshots]

   ## Checklist

   - [ ] Code follows project style guidelines
   - [ ] Self-reviewed the code
   - [ ] Commented complex logic
   - [ ] Documentation updated
   ```

3. **Code Review**
   - Assign reviewers (minimum 1)
   - Address feedback and comments
   - Make requested changes
   - Re-request review after updates

4. **Merging**
   - Wait for approval from reviewer(s)
   - Ensure CI/CD passes (if configured)
   - Merge using "Squash and merge" option
   - Delete feature branch after merge

### Code Review Guidelines

#### **For Reviewers**

- **Check functionality**: Does it work as described?
- **Check code quality**: Follows style guidelines?
- **Check edge cases**: Handles errors gracefully?
- **Check performance**: Any performance concerns?
- **Suggest improvements**: Constructive feedback
- **Approve when ready**: Don't block unnecessarily

#### **For Authors**

- **Respond to feedback**: Address all comments
- **Explain decisions**: Justify implementation choices
- **Update as needed**: Make requested changes
- **Thank reviewers**: Acknowledge feedback

### Communication Channels

#### **Team Communication**

- **WhatsApp Group**: Daily updates and quick questions
- **Weekly Meetings**: Sprint planning and progress reviews
- **GitHub Issues**: Track bugs and feature requests
- **GitHub Discussions**: Technical decisions and architecture

#### **Meeting Schedule**

- **Sprint Planning**: Monday morning (every 2 weeks)
- **Daily Standup**: Brief check-ins (async via WhatsApp)
- **Code Review Sessions**: Wednesday and Friday
- **Retrospective**: End of sprint (every 2 weeks)

---

## Development Guidelines

### Contributing to the Project

#### **Getting Started**

1. **Fork the repository** on GitHub
2. **Clone your fork** locally
   ```bash
   git clone https://github.com/your-username/formative_Assignment_1_Group-35-activity.git
   ```
3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/Clarisse-12/formative_Assignment_1_Group-35-activity.git
   ```
4. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

#### **Development Workflow**

1. **Keep your fork updated**

   ```bash
   git fetch upstream
   git checkout develop
   git merge upstream/develop
   ```

2. **Make your changes**
   - Follow code style guidelines
   - Write meaningful commit messages
   - Add comments for complex logic
   - Update documentation if needed

3. **Test your changes**

   ```bash
   flutter test
   flutter analyze
   dart format lib/ --set-exit-if-changed
   ```

4. **Commit and push**

   ```bash
   git add .
   git commit -m "feat(scope): description"
   git push origin feature/your-feature-name
   ```

5. **Create Pull Request**
   - Go to GitHub repository
   - Click "New Pull Request"
   - Fill in PR template
   - Request reviews

#### **Contribution Areas**

- 🐛 **Bug Fixes**: Fix reported issues
- ✨ **New Features**: Add functionality from roadmap
- 📝 **Documentation**: Improve README, add code comments
- 🎨 **UI/UX**: Enhance user interface and experience
- ⚡ **Performance**: Optimize code and reduce load times
- 🧪 **Testing**: Add unit and widget tests

### Code Review Process

#### **Submitting Code for Review**

1. **Self-Review First**
   - Read through your own changes
   - Check for commented-out code
   - Verify all todos are addressed
   - Test edge cases

2. **PR Checklist**
   - [ ] Code compiles without errors
   - [ ] No Flutter analyzer warnings
   - [ ] Follows project style guide
   - [ ] Includes tests (if applicable)
   - [ ] Documentation updated
   - [ ] Screenshots added (for UI changes)

3. **Request Specific Reviewers**
   - Assign team member with expertise in that area
   - Tag secondary reviewer for complex changes

#### **Reviewing Code**

1. **Check for Issues**
   - Logic errors
   - Performance problems
   - Security vulnerabilities
   - Code style violations

2. **Provide Constructive Feedback**
   - Be specific and actionable
   - Suggest improvements, don't just criticize
   - Praise good implementations
   - Ask questions to understand decisions

3. **Review Etiquette**
   - Be respectful and professional
   - Focus on the code, not the person
   - Explain the "why" behind suggestions
   - Respond promptly to PR requests

#### **Approval Criteria**

- ✅ Code functions as intended
- ✅ Follows style guidelines
- ✅ No major performance concerns
- ✅ Adequate test coverage
- ✅ Documentation is clear

### Testing Approach

#### **Testing Strategy**

Currently using manual testing. Future plans include:

1. **Unit Tests** (`test/models/`)
   - Test model serialization
   - Test helper functions
   - Test business logic

2. **Widget Tests** (`test/widgets/`)
   - Test individual widgets in isolation
   - Verify UI rendering
   - Test user interactions

3. **Integration Tests** (`integration_test/`)
   - Test complete user flows
   - Test navigation
   - Test data persistence

#### **Running Tests**

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/models/assignment_test.dart

# Run tests with coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Run integration tests
flutter drive --target=integration_test/app_test.dart
```

#### **Writing Tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:alu_academic_assistant/models/assignment.dart';

void main() {
  group('Assignment Model', () {
    test('creates assignment with required fields', () {
      final assignment = Assignment(
        id: '1',
        title: 'Test Assignment',
        dueDate: DateTime(2026, 3, 15),
        courseName: 'Mobile Dev',
        priority: 'High',
      );

      expect(assignment.id, '1');
      expect(assignment.title, 'Test Assignment');
      expect(assignment.isCompleted, false);
    });

    test('converts to map correctly', () {
      final assignment = Assignment(/*...*/);
      final map = assignment.toMap();

      expect(map['id'], assignment.id);
      expect(map['title'], assignment.title);
    });
  });
}
```

### Debugging Tips

#### **Debug Mode**

```bash
# Run in debug mode
flutter run --debug

# Enable verbose logging
flutter run --verbose
```

#### **Flutter DevTools**

```bash
# Launch DevTools
flutter pub global activate devtools
flutter pub global run devtools
```

**DevTools Features**:

- Widget Inspector: Inspect widget tree
- Timeline: Performance profiling
- Memory: Track memory usage
- Network: Monitor API calls

#### **Common Debugging Tools**

```dart
// Print to console
debugPrint('Value: $value');

// Breakpoint in IDE
// Set breakpoint and run debugger

// Inspect widget tree
debugDumpApp();

// Print render tree
debugDumpRenderTree();

// Performance overlay
// Press 'P' while app is running
```

### Git Workflow Best Practices

#### **Keeping Branches Clean**

```bash
# Rebase on develop frequently
git checkout feature/my-feature
git fetch upstream
git rebase upstream/develop

# Interactive rebase to clean commits
git rebase -i HEAD~5
```

#### **Resolving Conflicts**

```bash
# Update your branch
git fetch upstream
git checkout feature/my-feature
git merge upstream/develop

# Resolve conflicts in files
# After resolving:
git add .
git commit -m "Merge develop and resolve conflicts"
git push origin feature/my-feature --force-with-lease
```

#### **Commit Hygiene**

```bash
# Amend last commit (before pushing)
git commit --amend -m "Updated commit message"

# Squash commits before merging
git rebase -i HEAD~3
# Change 'pick' to 'squash' for commits to combine
```

### Documentation Standards

#### **Code Documentation**

- **Every public class**: Add class-level documentation
- **Every public method**: Document parameters and return values
- **Complex logic**: Inline comments explaining the "why"
- **TODOs**: Mark future improvements

#### **README Updates**

- Update when adding new features
- Keep installation instructions current
- Add screenshots for UI changes
- Document breaking changes

#### **Inline Documentation**

````dart
/// Represents an academic assignment with all tracking information.
///
/// This class provides functionality for creating, updating, and
/// serializing assignment data. It includes methods for JSON
/// conversion to support local storage.
///
/// Example:
/// ```dart
/// final assignment = Assignment(
///   id: '1',
///   title: 'Flutter Project',
///   dueDate: DateTime.now().add(Duration(days: 7)),
///   courseName: 'Mobile Development',
///   priority: 'High',
/// );
/// ```
class Assignment {
  // Implementation
}
````

### Roadmap and Future Enhancements

#### **Short Term (Current Sprint)**

- [ ] Add persistent storage for assignments (SQLite)
- [ ] Add persistent storage for sessions
- [ ] Implement actual backend API
- [ ] Add notification system for deadlines
- [ ] Improve error handling

#### **Medium Term (Next 2 Sprints)**

- [ ] Add user profile management
- [ ] Implement assignment reminders
- [ ] Add calendar view for schedule
- [ ] Export attendance reports (PDF/CSV)
- [ ] Dark/Light theme toggle
- [ ] Offline mode support

#### **Long Term (Future)**

- [ ] Integration with ALU learning management system
- [ ] Push notifications
- [ ] Widget for home screen (Android)
- [ ] Apple Watch companion app
- [ ] Study timer and pomodoro feature
- [ ] Grade tracking and GPA calculator
- [ ] Course material storage
- [ ] Collaboration features (study groups)

---

## License

This project is licensed under the MIT License. See `LICENSE` file for details.

---

## Acknowledgments

- **African Leadership University** for inspiration and support
- **Flutter Team** for the amazing framework
- **Dart Team** for the powerful language
- **Open Source Community** for packages and resources

---

## Contact & Support

- **Repository**: https://github.com/Clarisse-12/formative_Assignment_1_Group-35-activity
- **Issues**: https://github.com/Clarisse-12/formative_Assignment_1_Group-35-activity/issues
- **Email**: [Add team email]

---

<div align="center">

**Built with love by Group 35 for ALU Students**

Star this repository if you find it helpful!

</div>
flutter test

# Run app

flutter run

````

## Future Enhancements

- SQLite implementation for advanced persistence
- Push notifications for assignment reminders
- Cloud synchronization across devices
- Replace mock `AuthService` with real backend integration

## License

This project is created for educational purposes at African Leadership University.

---
If you'd like, I can further:
- Run `flutter analyze` and fix warnings.
- Refactor navigation to named routes and add unit/widget tests.
# ALU Academic Assistant
<<<<<<< HEAD

This repository contains the ALU Academic Assistant — a Flutter demo app that
provides basic student-facing features such as authentication, a dashboard,
assignments and schedule screens. The project is structured for collaboration
and maintainability.
=======

A comprehensive Flutter mobile application designed to help African Leadership University (ALU) students manage their academic responsibilities. The app assists students in tracking assignments, scheduling academic sessions, monitoring attendance, and maintaining overall academic engagement throughout the semester.

## Project Overview

The ALU Academic Assistant is a personal academic management tool that integrates three core functionalities:
- **Dashboard**: Real-time overview of academic status and commitments
- **Assignment Management**: Create, track, and manage coursework
- **Schedule Management**: Plan academic sessions and track attendance


>>>>>>> 0a9c706323e33767eb98faefbafff6f7ee0d901a

## Features

<<<<<<< HEAD
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
````

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
- # Run `flutter analyze` and fix warnings.

### Prerequisites

- Flutter SDK (version 3.0 or higher)
- Dart (included with Flutter)
- An IDE (VS Code, Android Studio, or Xcode)
- Android Emulator or iOS Simulator (or a physical device)

### Installation & Setup

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd alu_academic_assistant
   ```

2. **Install dependencies**

   flutter pub get

3. **Run the application**

   flutter run

## Component Documentation

### Assignment Creation Module (Phillip's Component)

The assignment creation module provides a comprehensive interface for students to add and edit assignments with full form validation and intuitive date/priority selection.

#### Files Included

- **`lib/models/assignment.dart`** - Assignment data model
- **`lib/screens/add_assignment_screen.dart`** - Add/Edit assignment interface

#### Assignment Model Architecture

The `Assignment` class is the core data structure that represents a single academic assignment.

**Key Properties:**

```dart
- id (String): Unique identifier for persistence and updates
- title (String): Assignment name/description [REQUIRED]
- dueDate (DateTime): When the assignment is due [REQUIRED]
- courseName (String): Associated course identifier [REQUIRED]
- priority (String): Assignment importance level {High, Medium, Low}
- isCompleted (bool): Completion status tracking
- createdAt (DateTime): Timestamp of assignment creation
```

**Key Methods:**

- `copyWith()`: Creates modified copies following immutability patterns
- `toJson()`: Serializes assignment data for storage
- `fromJson()`: Deserializes assignment data from storage
- `toString()`, `==`, `hashCode`: Standard Dart object methods

#### Add/Edit Assignment Form Features

**Form Fields:**

1. **Assignment Title** (Required)
   - Text input field with 3-100 character validation
   - Real-time validation feedback
   - Placeholder: "e.g., Essay on Climate Change"

2. **Course Name** (Required)
   - Text input field for course identification
   - Minimum 2 characters validation
   - Placeholder: "e.g., Environmental Science 201"

3. **Due Date** (Required)
   - Interactive date picker
   - Prevents selection of past dates
   - 365-day forward planning window
   - Displays selected date in readable format (MMM dd, yyyy)

4. **Priority Level** (Optional)
   - Dropdown selection: High, Medium, Low
   - Color-coded indicators:
     - **High**: Red (#DC3545) - Critical urgency
     - **Medium**: Gold/Yellow (#FDB827) - Standard priority
     - **Low**: Green (#28A745) - Lower urgency
   - Default: Medium

**Validation Logic:**

```
✓ Title: Not empty, 3-100 characters
✓ Course: Not empty, minimum 2 characters
✓ Due Date: Selected, not in the past
✓ Priority: Auto-validated dropdown
```

**User Experience Features:**

- Consistent ALU color branding throughout
- Material Design compliance
- Intuitive icon indicators for each field
- Responsive design with proper spacing
- Submit button shows contextual label ("Create Assignment" or "Update Assignment")
- Back navigation support with unsaved data handling

#### Integration Example

To use the assignment creation screen in the Assignments page:

```dart
// Navigate to add assignment screen
final newAssignment = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const AddAssignmentScreen(),
  ),
);

// Handle returned assignment
if (newAssignment != null) {
  setState(() {
    assignments.add(newAssignment);
  });
}
```

To edit an existing assignment:

```dart
final updatedAssignment = await Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => AddAssignmentScreen(
      assignmentToEdit: existingAssignment,
    ),
  ),
);

if (updatedAssignment != null) {
  setState(() {
    // Update assignments list
  });
}
```

#### Data Persistence Ready

The Assignment model is designed to integrate with local storage solutions:

**JSON Storage Example:**

```dart
// Save to SharedPreferences
final jsonString = jsonEncode(assignment.toJson());
await prefs.setString('assignment_${assignment.id}', jsonString);

// Load from SharedPreferences
final storedJson = prefs.getString('assignment_${assignment.id}');
final assignment = Assignment.fromJson(jsonDecode(storedJson));
```

**SQLite Integration Ready:**
The model's JSON serialization methods enable seamless SQLite integration for advanced data persistence.

## Schedule & Attendance Logic (Veronicah)

**Files:**

- `lib/models/session.dart` - Session data model
- `lib/logic/schedule_logic.dart` - All schedule and attendance logic

**Session Model:**
Created a Session class to store session details (title, date, times,
location, type) and attendance status. Added helper methods isToday()
and isThisWeek() for filtering.

**Attendance System:**

- Calculates attendance percentage by counting present sessions
- Triggers warning when attendance drops below 75%
- Maintains complete attendance history

**Schedule Management Functions:**

- Add, edit, and delete sessions
- Filter sessions by day or week
- Sort sessions chronologically
- Validate form inputs before creating sessions

**Integration:**
The getDashboardData() function packages all schedule and attendance
data for the dashboard screen.

#### Code Quality & Best Practices

**Comprehensive Documentation:**

- Class-level documentation explaining purpose and usage
- Method documentation with parameter descriptions and examples
- Inline comments explaining validation logic and UI decisions
- Clear variable naming following Dart conventions

**Design Patterns Used:**

- Factory pattern (fromJson constructor)
- Copy-on-write pattern (copyWith method)
- Immutable design principles
- Consistent error handling in validators

**Responsive Design:**

- Uses % Formative_Assignment_1_Group-35 workspace-relative sizing
- Proper padding and spacing conventions
- ScrollView for form overflow prevention
- Touch-friendly button sizes (minimum 48x48 dp)

## Color Scheme & Branding

The application uses ALU's official color palette:

```dart
// Primary Colors
- Primary Dark: #001F3F (Navy Blue)
- Accent Yellow: #FDB827 (Gold)
- Warning Red: #DC3545 (Danger/Alerts)

// Text Colors
- White: #FFFFFF
- Gray: #B0B0B0

// Status Colors
- Success Green: #28A745
- Info Blue: #17A2B8
```

## Development Guidelines

### Adding New Features

1. Maintain folder structure separation (models, screens, constants)
2. Use ALU color constants for consistency
3. Add comprehensive inline comments
4. Follow Dart style guide conventions
5. Implement proper error handling and validation

### Form Field Development

1. Use consistent `_buildFormSection()` helper method
2. Implement input decoration via `_buildInputDecoration()`
3. Add validators for required fields
4. Provide meaningful error messages
5. Clear input focus and validate on submit

### Testing

When implementing local storage:

```bash
# Run Flutter tests
flutter test

# Run app on emulator
flutter run

# Build release version
flutter build apk  # Android
flutter build ios  # iOS
```

## Future Enhancements

- SQLite implementation for advanced persistence
- Push notifications for assignment reminders
- Cloud synchronization across devices
- User authentication system
- Sharing assignments with classmates
- Integration with ALU calendar system

## Resources & Documentation

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)
- [intl Package (Date Formatting)](https://pub.dev/packages/intl)

## License

This project is created for educational purposes at African Leadership University.

## Contributing

Each team member should work on their assigned component:

- **Phillip**: Assignment Creation (Model & Form)
- **[Team Member 2]**: [Component]
- **[Team Member 3]**: [Component]

All contributions must follow the code quality standards outlined in the rubric.

> > > > > > > 0a9c706323e33767eb98faefbafff6f7ee0d901a
