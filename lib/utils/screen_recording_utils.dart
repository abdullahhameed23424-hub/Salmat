import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Utility class for handling screen recording detection and blocking
///
/// Android: Uses FLAG_SECURE to completely block screen recording while allowing screenshots.
/// This is the proper way to prevent screen recording on Android.
///
/// iOS: Detects when screen recording is active and shows a warning to the user.
/// Due to iOS system limitations, complete blocking is not possible.
class ScreenRecordingUtils {
  static const MethodChannel _channel =
      MethodChannel('screen_recording_control');

  /// Enables screen recording blocking
  ///
  /// Android: Uses FLAG_SECURE to completely block screen recording
  /// while still allowing screenshots to be taken.
  ///
  /// iOS: Adds a notification observer to detect when screen recording starts
  /// and shows a warning to the user.
  static Future<void> enableScreenRecordingBlock() async {
    try {
      await _channel.invokeMethod('enableScreenRecordingBlock');
    } catch (e) {
      // Handle error silently - screen recording blocking is not critical
      debugPrint('Failed to enable screen recording block: $e');
    }
  }

  /// Disables screen recording blocking
  /// This will allow screen recording again and remove any restrictions
  static Future<void> disableScreenRecordingBlock() async {
    try {
      await _channel.invokeMethod('disableScreenRecordingBlock');
    } catch (e) {
      // Handle error silently - screen recording blocking is not critical
      debugPrint('Failed to disable screen recording block: $e');
    }
  }

  /// Checks if screen recording is currently active (iOS only)
  ///
  /// Note: This is not available on Android due to system limitations.
  /// Android can only prevent screen recording with FLAG_SECURE, not detect it.
  static Future<bool> isScreenRecordingActive() async {
    try {
      final bool? isActive =
          await _channel.invokeMethod('isScreenRecordingActive');
      return isActive ?? false;
    } catch (e) {
      debugPrint('Failed to check screen recording status: $e');
      return false;
    }
  }
}
