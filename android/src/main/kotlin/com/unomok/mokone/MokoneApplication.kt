package com.unomok.mokone

import com.unotag.mokone.MokSDK
import com.unotag.mokone.utils.MokLogger
import io.flutter.app.FlutterApplication

open class MokoneApplication : FlutterApplication() {

    override fun onCreate() {
        super.onCreate()
        val mokSDK = MokSDK.getInstance(applicationContext)
        mokSDK.initMokSDK(isProductionEvn = false)
        MokLogger.setLogLevel(MokLogger.LogLevel.DEBUG)
    }
}
