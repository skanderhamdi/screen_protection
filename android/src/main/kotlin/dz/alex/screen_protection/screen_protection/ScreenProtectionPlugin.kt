package dz.alex.screen_protection.screen_protection

/** Needed Android libraries **/
import android.app.Activity
import android.util.Log
import androidx.annotation.NonNull
import android.view.WindowManager

/** Flutter related **/
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** ScreenProtectionPlugin */
class ScreenProtectionPlugin: FlutterPlugin, ActivityAware {

  private lateinit var channel : MethodChannel
  private var pluginBinding: FlutterPlugin.FlutterPluginBinding? = null
  private var activity: FlutterActivity? = null
  private var binaryMessenger: BinaryMessenger? = null

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity as FlutterActivity
    channel.setMethodCallHandler { call, result ->
      when(call.method) {
        "secureScreen" -> {
          secureScreen()
          result.success(true)
        }
        "unsecureScreen" -> {
          unsecureScreen()
          result.success(true)
        }
        "toggleScreenSecurity" -> {
          toggleScreenSecurity()
          result.success(true)
        }
        "isScreenSecured" -> {
          result.success(isScreenSecured())
        }
        else -> result.notImplemented()
      }
    }
  }

  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onDetachedFromActivity() {}

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "screen_protection")
    binaryMessenger = flutterPluginBinding.binaryMessenger
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun secureScreen() {
    activity?.window?.addFlags(WindowManager.LayoutParams.FLAG_SECURE)
  }

  fun unsecureScreen() {
    activity?.window?.clearFlags(WindowManager.LayoutParams.FLAG_SECURE)
  }

  fun toggleScreenSecurity() {
    val isFlagSecureSet = (activity?.window?.attributes?.flags ?: 0) and WindowManager.LayoutParams.FLAG_SECURE != 0
    if(isFlagSecureSet) unsecureScreen() else secureScreen()
  }

  fun isScreenSecured(): Boolean {
    return (activity?.window?.attributes?.flags ?: 0) and WindowManager.LayoutParams.FLAG_SECURE != 0
  }
}
