package com.unomok.mokone

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull
import com.unotag.mokone.MokSDK
import com.unotag.mokone.utils.MokLogger
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject


/** MokonePlugin */
class MokonePlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    /// xz
    // / This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var mContext: Context
    private lateinit var mActivity: Activity
    private lateinit var mMokSDK: MokSDK

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mokone")
        channel.setMethodCallHandler(this)
        mContext = flutterPluginBinding.applicationContext
        mMokSDK = MokSDK.getInstance(mContext)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        //TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        //TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        // TODO("Not yet implemented")
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

        when (call.method) {
            "getFcmToken" -> requestFcmToken(result)
            "updateUser" -> requestUpdateUser(call, result)
            "logEvent" -> requestLogEvent(call, result)
            "getNotificationPermission" -> requestNotificationPermission()
            "openNotificationSettings" -> openNotificationSettings()
            "isNotificationPermissionGranted" -> isNotificationPermissionGranted(result)
            "getUserId" -> requestUserId(result)
            "logoutUser" -> requestLogoutUser()
            "getIAMFromServerAndShow" -> requestIAMFromServerAndShow()
            else -> result.notImplemented()
        }
    }

    private fun requestFcmToken(result: Result) {
        mMokSDK.getFCMToken { token, error ->
            if (token != null) {
                result.success(token)
            } else {
                if (error.isNullOrBlank()) {
                    MokLogger.log(MokLogger.LogLevel.ERROR, "Unable to get fcm token")
                } else {
                    MokLogger.log(
                        MokLogger.LogLevel.ERROR,
                        "Unable to get fcm token, error: $error"
                    )
                }
                result.error("0", error?:"Unable to fetch token", error)
            }
        }
    }

    private fun requestNotificationPermission() {
        mMokSDK.requestNotificationPermission(mActivity)
    }

    private fun openNotificationSettings() {
        mMokSDK.openNotificationSettings(mActivity)
    }

    private fun isNotificationPermissionGranted(result: Result) {
       val value:Boolean = mMokSDK.isNotificationPermissionGranted(mActivity)
        result.success(value)
    }

    private fun requestUpdateUser(call: MethodCall, result: Result) {
        val userId = call.argument<String>("userId")
        val userData = call.argument<HashMap<String, Any>?>("userData")
        val userDataJsonObject = JSONObject()
        if (userData != null) {
            for ((key, value) in userData) {
                userDataJsonObject.put(key, value)
            }
        }
        if (userId != null) {
            mMokSDK.updateUser(userId, userDataJsonObject) { success, error ->
                if (success != null) {
                    result.success(success.toString())
                } else {
                    result.error("ERROR", error ?: "", "Failed to update user")
                }
            }
        }
    }

    private fun requestUserId(result: Result){
        val value:String = mMokSDK.getUserId()
        result.success(value)
    }

    private fun requestLogoutUser() {
        mMokSDK.logoutUser()
    }

    private fun requestLogEvent(call: MethodCall, result: Result) {
        val userId = call.argument<String>("userId")
        val eventName = call.argument<String>("eventName")
        val params = call.argument<HashMap<String, Any>?>("params")
        val paramsJsonObject = JSONObject()
        if (params != null) {
            for ((key, value) in params) {
                paramsJsonObject.put(key, value)
            }
        }
        if (userId != null && eventName != null) {
            mMokSDK.logEvent(eventName, userId, paramsJsonObject) { success, error ->
                if (success != null) {
                    result.success(success.toString())
                } else {
                    result.error("ERROR", error ?: "", "Failed to update user")
                }
            }
        }
    }
    private fun requestIAMFromServerAndShow(){
        mMokSDK.requestIAMFromServerAndShow();
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
