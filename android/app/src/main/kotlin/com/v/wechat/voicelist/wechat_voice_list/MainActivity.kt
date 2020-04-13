package com.v.wechat.voicelist.wechat_voice_list

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import androidx.annotation.NonNull;
import com.v.wechat.voicelist.wechat_voice_list.service.VoiceFileMonitorService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        startService(Intent(this, VoiceFileMonitorService::class.java))
    }

}
