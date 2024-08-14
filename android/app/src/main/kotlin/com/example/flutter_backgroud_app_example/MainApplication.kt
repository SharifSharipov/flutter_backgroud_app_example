package com.example.flutter_backgroud_app_example

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setLocale("En_en")
        MapKitFactory.setApiKey(
            "51b892dd-19c3-4a1a-9247-9b3987d2d61c"
        )
    }
}
