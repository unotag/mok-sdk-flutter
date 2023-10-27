package com.unomok.mokone_example

import com.unomok.mokone.MokoneApplication
//import com.unotag.mokone.utils.MokLogger
import  MokLogger

class SampleApplication : MokoneApplication() {

    override fun onCreate() {
        super.onCreate()
        MokLogger.setLogLevel(MokLogger.LogLevel.DEBUG)
    }
}