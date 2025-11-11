package vn.tuoitre.app


import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.util.Log
import com.netcore.android.Smartech
//import com.netcore.android.logger.SMTDebugLevel
//import com.netcore.android.logger.SMTDebugLevel.Level.VERBOSE
import com.netcore.android.smartechpush.SmartPush
import com.netcore.android.smartechpush.notification.SMTNotificationListener
import com.netcore.smartech_base.SmartechBasePlugin
import com.netcore.smartech_base.SmartechDeeplinkReceivers
import com.netcore.smartech_push.SmartechPushPlugin
import com.netcore.smartech_push.SmartechPushPlugin.Companion.context
import io.flutter.app.FlutterApplication
import java.lang.ref.WeakReference

class MyApplication: FlutterApplication(), SMTNotificationListener {

    var intent: Intent = Intent(Intent.ACTION_MAIN) 

    override fun onCreate() {
        super.onCreate()

        // Initialize Smartech Sdk
        Smartech.getInstance(WeakReference(applicationContext)).initializeSdk(this)
        //Smartech.getInstance(WeakReference(applicationContext)).setDebugLevel(VERBOSE)
        Smartech.getInstance(WeakReference(applicationContext)).trackAppInstallUpdateBySmartech()

        // Initialize Flutter Smartech Base Plugin
        SmartechBasePlugin.initializePlugin(this)

        // Initialize Flutter Smartech Push Plugin
        SmartechPushPlugin.initializePlugin(this)

        // Add SmartPush Notification Listener
        SmartPush.getInstance(WeakReference(SmartechPushPlugin.context)).setSMTNotificationListener(this)
      
        // Deep link
        val deeplinkReceiver = SmartechDeeplinkReceivers()
        val filter = IntentFilter("com.smartech.EVENT_PN_INBOX_CLICK")
          
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            context.registerReceiver(deeplinkReceiver, filter, RECEIVER_EXPORTED)
        } else {
            context.registerReceiver(deeplinkReceiver, filter)
        }


  
    }


    override fun onTerminate() {
        super.onTerminate()
        Log.d("onTerminate","onTerminate")
    }

    // Implement override Smartech Notification method
    override fun getSmartechNotifications(payload: String, source: Int) {
        SmartPush.getInstance(WeakReference(SmartechPushPlugin.context)).renderNotification(payload, source)
    }
  



   
}