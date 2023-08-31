package com.unomok.mokone

import MokLogger
import android.content.Context
import androidx.annotation.NonNull
import com.unotag.mokone.MokSDK

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import java.lang.reflect.Method

/** MokonePlugin */
class MokonePlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var mContext: Context
    private lateinit var mMokSDK: MokSDK

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mokone")
        channel.setMethodCallHandler(this)
        mContext = flutterPluginBinding.applicationContext
        mMokSDK = MokSDK.getInstance(mContext)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
//      if (call.method == "getPlatformVersion") {
//          result.success("Android ${android.os.Build.VERSION.RELEASE}")
//      } else {
//          result.notImplemented()
//      }


        when (call.method) {
            "getPlatformVersion" -> result.success(getAndroidVersion())
            "getFcmToken" -> requestFcmToken(result)
            "updateUser" -> requestUpdateUser(call, result)
            else -> result.notImplemented()
        }
    }

    private fun getAndroidVersion(): String {
        return "Android version is 10"
    }

    private fun requestFcmToken(result: Result) {
        mMokSDK.getFCMToken { token ->
            if (token != null) {
                result.success(token)
            }
        }
    }

    private fun requestUpdateUser(call: MethodCall, result: Result) {
        val userId = call.argument<String>("userId")
        val userData = call.argument<HashMap<String, String>?>("userData")
        val userDataJsonObject = JSONObject()
        if (userData != null) {
            for ((key, value) in userData) {
                userDataJsonObject.put(key, value)
            }
        }
        if (userId != null) {
            mMokSDK.updateUser(userId, userDataJsonObject) { success, error ->
                if (success != null) {
                    result.success(success)
                } else {
                    MokLogger.log(MokLogger.LogLevel.ERROR, "update user result : $error")
                    result.error("ERROR", error ?: "", "Failed to update user")
                }
            }
        }
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
