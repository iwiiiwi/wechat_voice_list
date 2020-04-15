package com.v.wechat.voicelist.wechat_voice_list.service;

import android.app.Service;
import android.content.Intent;
import android.os.Environment;
import android.os.IBinder;
import android.util.Log;

import com.v.wechat.voicelist.wechat_voice_list.business.RecursiveFileObserver;
import com.v.wechat.voicelist.wechat_voice_list.business.VoiceFileEventListener;

import java.io.File;
import java.util.Arrays;
import java.util.Comparator;
import java.util.regex.Pattern;

public class VoiceFileMonitorService extends Service {

    private RecursiveFileObserver voiceFileObserver;

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
        initPath(absolutePath+"/tencent/MicroMsg/");


    }

    private boolean isTargetVoiceFolder(File pathname){
        String name=pathname.getName();
        if(pathname.isDirectory()){
            if(name.length()>25){
                boolean matches = Pattern.matches("^[\\da-f]+$", pathname.getName());
                if(matches && new File(pathname.getAbsolutePath()+"/voice2").exists()){
                    return true;
                }
            }
        }
        return false;
    }

    public void initPath(String basePath){
        File file=new File(basePath);
        File[] files = file.listFiles();
        Arrays.sort(files, new Comparator<File>() {
            @Override
            public int compare(File o1, File o2) {
                return (int) (o2.lastModified()-o1.lastModified());
            }
        });
        for(File temp:files){
            if(isTargetVoiceFolder(temp)){
                path=temp.getAbsolutePath()+"/voice2";
                break;
            }
        }

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
            voiceFileObserver=new RecursiveFileObserver(path,new VoiceFileEventListener());
            voiceFileObserver.startWatching();
        }
        Log.d(TAG, "onStartCommand() called");
        //START_STICKY  to order the system to restart your service as soon as possible when it was killed.
        return START_STICKY;
    }
}
