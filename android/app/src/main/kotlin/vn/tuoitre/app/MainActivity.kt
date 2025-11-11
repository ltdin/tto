package vn.tuoitre.app


import android.os.Bundle
import com.netcore.smartech_base.SmartechDeeplinkReceivers
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        SmartechDeeplinkReceivers().onReceive(this, intent)

    }
}
