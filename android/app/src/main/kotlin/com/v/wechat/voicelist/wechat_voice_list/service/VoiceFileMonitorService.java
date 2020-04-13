package com.v.wechat.voicelist.wechat_voice_list.service;

import android.app.Service;
import android.content.Intent;
import android.os.Environment;
import android.os.IBinder;
import android.util.Log;

import com.v.wechat.voicelist.wechat_voice_list.business.VoiceFileObserver;

public class VoiceFileMonitorService extends Service {

    private VoiceFileObserver voiceFileObserver;

    private String path;


    private static final String TAG = "VoiceFileMonitorService";

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        String absolutePath = Environment.getExternalStorageDirectory().getAbsolutePath();

    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if(voiceFileObserver!=null){
            voiceFileObserver.stopWatching();
            voiceFileObserver=null;
        }
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        if(voiceFileObserver==null){
            voiceFileObserver=new VoiceFileObserver("");
            voiceFileObserver.startWatching();
        }
        Log.d(TAG, "onStartCommand() called");
        //START_STICKY  to order the system to restart your service as soon as possible when it was killed.
        return START_STICKY;
    }
}
