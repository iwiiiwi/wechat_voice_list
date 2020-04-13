package com.v.wechat.voicelist.wechat_voice_list.business;

import android.os.FileObserver;
import android.util.Log;

public class VoiceFileObserver extends FileObserver {

    private static final String TAG = "VoiceFileObserver";

    public VoiceFileObserver(String path) {
        super(path);
    }

    @Override
    public void onEvent(int event, String path) {
        Log.d(TAG,"event:"+event+", path:"+path);
    }
}
