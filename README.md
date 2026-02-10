# ALU Academic Assistant

A mobile app for ALU students to manage assignments, track class schedules, and monitor attendance.
Demo Video = https://www.youtube.com/watch?v=pXrKnm4xWY8
---

## Quick Start

### What You Need
- Flutter SDK 3.10+
- Android Studio or VS Code
- Android Emulator or physical device

### Installation

1. **Clone the repo**
```bash
git clone https://github.com/Clarisse-12/formative_Assignment_1_Group-35-activity.git
cd formative_Assignment_1_Group-35-activity/alu_academic_assistant
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

---

## How to Use

### Login
- Enter any email and password (mock authentication)
- App saves your login state

### Dashboard (Home Screen)
- **Quick Stats**: See pending assignments, missed sessions, upcoming deadlines
- **Attendance Card**: Shows your attendance percentage with color warnings:
  - Green (≥75%): Good standing
  - Red (<75%): Below threshold
- **Today's Classes**: Lists all sessions scheduled for today
- **Upcoming Assignments**: Shows assignments due in the next 7 days

### Managing Assignments
1. Tap **Assignments** tab in bottom navigation
2. Click **+** button to add new assignment
3. Fill in:
   - Title (required)
   - Course name (required)
   - Due date (required)
   - Priority (High/Medium/Low)
4. Save to add to your list
5. Tap checkbox to mark complete
6. Tap assignment card to edit

### Managing Schedule
1. Tap **Schedule** tab in bottom navigation
2. Click **+** button to add session
3. Fill in:
   - Session title (required)
   - Date (required)
   - Start time (required)
   - End time (required)
   - Location (optional)
   - Session type: Class, Mastery Session, Study Group, or PSL Meeting
4. Save to add to schedule
5. Check the box to mark attendance (Present/Absent)
6. Attendance percentage updates automatically on Dashboard

---

## Project Structure

```
lib/
├── logic/
│   └── schedule_logic.dart          # Attendance calculations and session management
├── models/
│   ├── assignment.dart               # Assignment data structure
│   └── session.dart                  # Session data structure
├── navigations/
│   └── bottom-navigation.dart        # Bottom nav bar (3 tabs)
├── screens/
│   ├── add_assignment_screen.dart    # Form to create/edit assignments
│   ├── assignment-screen.dart        # Assignment list view
│   ├── auth_wrapper.dart             # Checks if user is logged in
│   ├── dashboard-screen.dart         # Main dashboard with stats
│   ├── login_screen.dart             # Login form
│   ├── schedule-screen.dart          # Weekly schedule view
│   ├── session_form_screen.dart      # Form to create/edit sessions
│   └── signup_screen.dart            # Sign-up form
├── services/
│   └── auth_service.dart             # Handles login/logout with SharedPreferences
├── utils/
│   ├── alu_colors.dart               # ALU color constants
│   └── helpers.dart                  # Date formatting and calculations
├── widget/
│   ├── assignments_tile.dart         # Assignment list item widget
│   └── hoverable_card.dart           # Animated card with hover effect
├── widgets/
│   └── custom_text_field.dart        # Reusable styled text input
└── main.dart                         # App entry point
```

---

## File Explanations

### Core Files

**`main.dart`**
- Starts the app
- Sets up the theme with ALU colors (navy blue #003366, gold #FDB827)
- Routes to AuthWrapper to check login status

**`auth_wrapper.dart`**
- Checks if user is logged in using SharedPreferences
- Shows Dashboard if logged in, otherwise shows Login screen

### Screens

**`login_screen.dart`** & **`signup_screen.dart`**
- Login and registration forms
- Mock authentication (accepts any credentials)
- Saves login state using SharedPreferences

**`dashboard-screen.dart`**
- Main home screen
- Shows 4 stat cards: pending assignments, missed sessions, upcoming deadlines, attendance
- Displays today's classes and assignments due in 7 days
- Pull-to-refresh to reload data
- Course filter dropdown

**`assignment-screen.dart`**
- Lists all assignments sorted by due date
- Shows completion status
- Tap to edit, swipe to delete
- Filter by status (all/pending/completed)

**`add_assignment_screen.dart`**
- Form to create or edit assignments
- Fields: title, course, due date, priority, description
- Date picker for selecting due date
- Validates required fields before saving

**`schedule-screen.dart`**
- Shows all scheduled sessions for the week
- Sessions sorted by date and time
- Each card shows: title, time, location, session type
- Checkbox to mark attendance (present/absent)
- Edit and delete buttons on each card

**`session_form_screen.dart`**
- Form to create or edit sessions
- Fields: title, date, start time, end time, location, session type
- Validates times (end must be after start)
- Session types: Class, Mastery Session, Study Group, PSL Meeting

### Models

**`assignment.dart`**
- Defines Assignment structure with:
  - id, title, dueDate, courseName, priority, isCompleted, createdAt
- Methods: `toJson()`, `fromJson()`, `copyWith()` for data persistence

**`session.dart`**
- Defines Session structure with:
  - title, date, startTime, endTime, location, sessionType, isPresent
- Helper methods: `isToday()`, `isThisWeek()`

### Logic

**`schedule_logic.dart`**
- Global list: `allSessions` stores all sessions
- Functions:
  - `addSession()` - Add new session
  - `editSession()` - Update existing session
  - `deleteSession()` - Remove session
  - `getTodaysSessions()` - Get sessions for today
  - `getWeeklySessions()` - Get this week's sessions
  - `calculateAttendance()` - Compute attendance % (present sessions / total sessions)
  - `isBelowThreshold()` - Check if attendance < 75%

### Services

**`auth_service.dart`**
- Handles login/logout using SharedPreferences
- Methods:
  - `isLoggedIn()` - Check if user is authenticated
  - `login()` - Mock login (saves state)
  - `signUp()` - Mock registration
  - `logout()` - Clear session

### Utils

**`alu_colors.dart`**
- Color constants used throughout app:
  - `primary` - Navy blue #003366
  - `accent` - Gold #FDB827
  - `backgroundDark` - Dark navy #0A1A3A
  - `textWhite` - White #FFFFFF
  - `warningRed` - Red #EF4444
  - `successGreen` - Green #10B981

**`helpers.dart`**
- Date/time formatting functions:
  - `formatDateLong()` - "February 10, 2026"
  - `formatDateShort()` - "Feb 10"
  - `formatTime()` - Converts 24h to 12h format
  - `getAcademicWeek()` - Calculates week number (1-15) from term start
  - `getAttendanceStatus()` - Returns color and message based on %

### Widgets

**`hoverable_card.dart`**
- Card that lifts up on hover (desktop)
- Used for stat cards on dashboard

**`custom_text_field.dart`**
- Styled text input with ALU colors
- Supports icons, labels, password mode
- Consistent styling across all forms

**`assignments_tile.dart`**
- List item for displaying single assignment
- Shows title, course, due date, priority
- Checkbox for completion

### Navigation

**`bottom-navigation.dart`**
- Bottom nav bar with 3 tabs
- Uses IndexedStack to preserve state when switching tabs
- Tabs: Dashboard (index 0), Assignments (1), Schedule (2)

---

## Key Features Explained

### Attendance Tracking
- Automatically calculates: (sessions marked present / total sessions) × 100
- Updates in real-time when you mark attendance
- Dashboard shows warning if below 75%
- Color-coded status:
  - Green: ≥75%
  - Red: <75%

### Assignment Urgency
- Assignments due in ≤2 days show with red border
- Dashboard shows only assignments due in next 7 days
- Sorted by due date (earliest first)

### Session Types
Each session type has a different color:
- **Class**: Blue
- **Mastery Session**: Purple
- **Study Group**: Green
- **PSL Meeting**: Orange

### Academic Week Calculation
- Term starts: January 5, 2026
- Calculates current week (1-15) based on today's date
- Displayed on dashboard

---

## Dependencies (from pubspec.yaml)

- **`intl: ^0.18.0`** - Date/time formatting
- **`shared_preferences: ^2.1.1`** - Local storage for login state
- **`cupertino_icons: ^1.0.8`** - iOS-style icons

---

## Code Quality Standards

### Naming Conventions
- **Files**: lowercase_with_underscores.dart
- **Classes**: PascalCase (DashboardScreen, Assignment)
- **Variables**: camelCase (userName, isCompleted)
- **Private variables**: _underscorePrefix (_assignments)
- **Functions**: camelCase verbs (calculateAttendance, formatDate)

### Code Organization
- Each screen is in `screens/` folder
- Reusable widgets in `widgets/` or `widget/`
- Data models in `models/`
- Business logic in `logic/`
- Constants in `utils/`

### Comments
- Class-level comments explain what the class does
- Method comments explain parameters and return values
- Inline comments explain WHY, not WHAT
- Complex logic has explanatory comments

---


### Contribution Guidelines

**How to contribute:**

1. **Create your branch**
   ```bash
   git checkout -b your-name-branch
   ```

2. **Make your changes**
   - Write clean code with comments
   - Follow naming conventions
   - Test your features

3. **Commit with clear messages**
   ```bash
   git add .
   git commit -m "Add attendance warning feature"
   git push origin your-name-branch
   ```

4. **Code style rules:**
   - Use ALU colors from `alu_colors.dart`
   - Add comments explaining your logic
   - Name variables clearly (e.g., `attendancePercentage`, not `ap`)
   - Keep functions small and focused

---

## Known Limitations

- **No data persistence**: Assignments and sessions are lost when app closes
  - Future: Add SQLite database
- **Mock authentication**: Accepts any login credentials
  - Future: Connect to real backend API
- **No notifications**: Can't remind about deadlines
  - Future: Add push notifications

---

## Testing

### Manual Testing Checklist

**Login:**
- [ ] Can login with any credentials
- [ ] Login state persists after closing app

**Dashboard:**
- [ ] Shows correct date and week number
- [ ] Displays today's sessions
- [ ] Shows assignments due in 7 days
- [ ] Attendance percentage updates when marking sessions
- [ ] Warning appears when attendance < 75%

**Assignments:**
- [ ] Can create new assignment
- [ ] Can edit existing assignment
- [ ] Can delete assignment
- [ ] Can mark as complete
- [ ] List sorts by due date

**Schedule:**
- [ ] Can create new session
- [ ] Can edit existing session
- [ ] Can delete session
- [ ] Can mark attendance (present/absent)
- [ ] Sessions sorted chronologically

**Navigation:**
- [ ] Bottom nav switches between 3 screens
- [ ] State preserved when switching tabs
- [ ] No crashes

---

## Troubleshooting

**App won't run:**
```bash
flutter clean
flutter pub get
flutter run
```

**Gradle error (Android):**
```bash
cd android
./gradlew clean
cd ..
flutter run
```

**Dependencies error:**
```bash
flutter pub cache repair
flutter pub get
```

**No connected devices:**
```bash
flutter devices
# Start emulator from Android Studio
```

---

## Contact

- **Repository**: https://github.com/Clarisse-12/formative_Assignment_1_Group-35-activity
- **Issues**: Report bugs in GitHub Issues tab

---

Built by Group 35 for ALU students 🎓
