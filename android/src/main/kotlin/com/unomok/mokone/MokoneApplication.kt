package com.unomok.mokone

import MokLogger
import com.unotag.mokone.MokSDK
import io.flutter.app.FlutterApplication

class MokoneApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        val mokSDK = MokSDK.getInstance(applicationContext)
        mokSDK.initMokSDK()
        MokLogger.setLogLevel(MokLogger.LogLevel.DEBUG)
    }
}
