
package vn.tuoitre.app

import android.util.Log
import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.netcore.android.smartechpush.SmartPush
import com.netcore.smartech_push.SmartechPushPlugin.Companion.context
import org.json.JSONObject
import java.lang.ref.WeakReference

class MyFirebaseMessagingService : FirebaseMessagingService() {

   		override fun onNewToken(token: String) {
 				super.onNewToken(token)
 				SmartPush.getInstance(WeakReference(this)).setDevicePushToken(token)
 		}

 		override fun onMessageReceived(message: RemoteMessage) {
 				super.onMessageReceived(message)
 				val isPushFromSmartech:Boolean = SmartPush.getInstance(WeakReference(context)).isNotificationFromSmartech(JSONObject(message.data.toString()))
 				
                if(isPushFromSmartech){
       			    SmartPush.getInstance(WeakReference(applicationContext)).handlePushNotification(message.data.toString())
 				} else {
       			    // Notification received from other sources
 				}
 		}
}