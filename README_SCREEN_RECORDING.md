# Screen Recording Blocking Implementation

This implementation provides screen recording blocking functionality specifically for the lesson screen while allowing screenshots throughout the app.

## Features

- **Android**: Completely blocks screen recording using `FLAG_SECURE`
- **iOS**: Detects screen recording and shows warnings to users
- **Screenshots**: Always allowed on both platforms
- **Scope**: Only affects the lesson screen, other screens remain unaffected

## How It Works

### Android Implementation
- Uses `WindowManager.LayoutParams.FLAG_SECURE` to prevent screen recording
- Applied only when the lesson screen is active
- Automatically removed when leaving the lesson screen
- Screenshots are still allowed

### iOS Implementation
- Due to iOS system limitations, complete blocking is not possible
- Detects when screen recording starts using `UIScreen.capturedDidChangeNotification`
- Shows a warning dialog to users when screen recording is detected
- Screenshots remain unaffected

## Implementation Details

### Flutter Side
- `ScreenRecordingUtils` class provides the interface
- Method channel communication with native code
- Automatic enabling/disabling in `LessonDetailsScreen`

### Native Code
- **Android**: `MainActivity.kt` handles the method channel
- **iOS**: `AppDelegate.swift` handles the method channel and notifications

## Usage

The screen recording blocking is automatically enabled when entering the lesson screen and disabled when leaving. No manual intervention is required.

## Platform Limitations

### Android
- ✅ Complete screen recording blocking
- ✅ Screenshots allowed
- ❌ Cannot detect if recording is active

### iOS
- ⚠️ Cannot completely block screen recording
- ✅ Can detect when recording starts
- ✅ Shows warnings to users
- ✅ Screenshots allowed

## Security Notes

- This implementation provides reasonable protection against casual screen recording
- Determined users may still find ways to record (especially on iOS)
- The primary goal is to discourage unauthorized recording of educational content
- Screenshots are intentionally allowed for legitimate educational purposes 