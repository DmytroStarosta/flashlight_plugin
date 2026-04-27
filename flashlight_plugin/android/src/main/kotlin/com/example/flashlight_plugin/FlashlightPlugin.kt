package com.example.flashlight_plugin

import android.content.Context
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class FlashlightPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flashlight_plugin/methods")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "toggleFlash") {
      val isOn = call.argument<Boolean>("isOn") ?: false
      toggleFlashlight(isOn, result)
    } else {
      result.notImplemented()
    }
  }

  private fun toggleFlashlight(isOn: Boolean, result: Result) {
    try {
      val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
      val cameraIds = cameraManager.cameraIdList
      
      if (cameraIds.isEmpty()) {
        result.error("NO_CAMERA", "No cameras found on device", null)
        return
      }

      var targetCameraId: String? = null
      
      for (id in cameraIds) {
        val characteristics = cameraManager.getCameraCharacteristics(id)
        val hasFlash = characteristics.get(CameraCharacteristics.FLASH_INFO_AVAILABLE)
        if (hasFlash == true) {
          targetCameraId = id
          break
        }
      }

      if (targetCameraId != null) {
        cameraManager.setTorchMode(targetCameraId, isOn)
        result.success(null)
      } else {
        result.error("NO_FLASH", "Available cameras do not have a flash unit", null)
      }
    } catch (e: Exception) {
      result.error("HARDWARE_ERROR", "Flashlight hardware is unavailable: ${e.message}", null)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}