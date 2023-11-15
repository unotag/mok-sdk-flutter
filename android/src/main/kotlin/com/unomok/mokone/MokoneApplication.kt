package com.unomok.mokone

import android.app.Activity
import android.app.Application.ActivityLifecycleCallbacks
import android.os.Bundle
import com.unotag.mokone.MokSDK
import com.unotag.mokone.utils.MokLogger
import io.flutter.app.FlutterApplication

open class MokoneApplication : FlutterApplication(), ActivityLifecycleCallbacks {

    override fun onCreate() {
        registerActivityLifecycleCallbacks(this)
        super.onCreate()
    }


    override fun onActivityCreated(activity: Activity, savedInstanceState: Bundle?) {
        MokLogger.log(
            MokLogger.LogLevel.INFO,
            "onActivity Created: ${activity.javaClass.simpleName}"
        )

        val mokSDK = MokSDK.getInstance(applicationContext)
        val currentActivityName = "splash"

        if (activity.javaClass.simpleName == currentActivityName) {
            MokLogger.setLogLevel(MokLogger.LogLevel.DEBUG)
        }
    }

    override fun onActivityStarted(activity: Activity) {
        MokLogger.log(
            MokLogger.LogLevel.INFO,
            "onActivity Started: ${activity.javaClass.simpleName}"
        )
    }

    override fun onActivityResumed(activity: Activity) {
        MokLogger.log(
            MokLogger.LogLevel.INFO,
            "onActivity Resumed: ${activity.javaClass.simpleName}"
        )
    }

    override fun onActivityPaused(activity: Activity) {
        MokLogger.log(MokLogger.LogLevel.INFO, "onActivity Paused: ${activity.javaClass.simpleName}")
    }

    override fun onActivityStopped(activity: Activity) {
        MokLogger.log(
            MokLogger.LogLevel.INFO,
            "onActivity Stopped: ${activity.javaClass.simpleName}"
        )
    }

    override fun onActivitySaveInstanceState(activity: Activity, outState: Bundle) {
        MokLogger.log(
            MokLogger.LogLevel.INFO,
            "onActivity SaveInstanceState: ${activity.javaClass.simpleName}"
        )
    }

    override fun onActivityDestroyed(activity: Activity) {
        MokLogger.log(
            MokLogger.LogLevel.INFO,
            "onActivity Destroyed: ${activity.javaClass.simpleName}"
        )
    }

    override fun onTerminate() {
        super.onTerminate()
        unregisterActivityLifecycleCallbacks(this)
    }

}
