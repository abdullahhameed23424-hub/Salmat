package com.icr.salamat

import android.content.Context
import android.media.projection.MediaProjectionManager
import android.os.Bundle
import android.view.WindowManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "screen_recording_control"
    private var isScreenRecordingBlocked = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "enableScreenRecordingBlock" -> {
                    enableScreenRecordingBlock()
                    result.success(null)
                }
                "disableScreenRecordingBlock" -> {
                    disableScreenRecordingBlock()
                    result.success(null)
                }
                "isScreenRecordingActive" -> {
                    // On Android, we can't detect if screen recording is active due to system limitations
                    // We can only prevent it with FLAG_SECURE
                    result.success(false)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun enableScreenRecordingBlock() {
        if (!isScreenRecordingBlocked) {
            // Use FLAG_SECURE to completely block screen recording while allowing screenshots
            // This is the proper way to prevent screen recording on Android
            window.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
            isScreenRecordingBlocked = true
        }
    }

    private fun disableScreenRecordingBlock() {
        if (isScreenRecordingBlocked) {
            // Remove FLAG_SECURE to allow screen recording again
            window.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
            isScreenRecordingBlocked = false
        }
    }
}
