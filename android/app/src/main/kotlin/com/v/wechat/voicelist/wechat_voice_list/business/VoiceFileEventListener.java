package com.v.wechat.voicelist.wechat_voice_list.business;

import android.content.Context;
import android.os.FileObserver;
import android.util.Log;
import android.widget.Toast;

import java.io.File;
import java.time.Duration;

public class VoiceFileEventListener implements RecursiveFileObserver.EventListener {

    private static final String TAG = "VoiceFileObserver";


    public VoiceFileEventListener() {
    }

    @Override
    public void onEvent(int event, File file) {
//        Log.d(TAG,"event:"+event+", path:"+file.getAbsolutePath());
        switch (event){
            // 文件被访问
            case FileObserver.ACCESS:
                Log.d("FileListener", "ACCESS");
                break;
            // 文件被修改
            case FileObserver.MODIFY:
                Log.d("FileListener", "MODIFY");
                break;
            // 文件属性被修改
            case FileObserver.ATTRIB:
                Log.d("FileListener", "ATTRIB");
                break;
            // 可写文件被close
            case FileObserver.CLOSE_WRITE:
                Log.d("FileListener", "CLOSE_WRITE");
                break;
            // 不可写文件被close
            case FileObserver.CLOSE_NOWRITE:
                Log.d("FileListener", "CLOSE_NOWRITE");
                break;
            // 文件被打开
            case FileObserver.OPEN:
                Log.d("FileListener", "OPEN");
                break;
            // 文件被移走
            case FileObserver.MOVED_FROM:
                Log.d("FileListener", "MOVED_FROM");
                break;
            // 文件被移进来
            case FileObserver.MOVED_TO:
                Log.d("FileListener", "MOVED_TO");
                break;
            // 文件被删除
            case FileObserver.DELETE:
                Log.d("FileListener", "DELETE,path:"+file.getAbsolutePath());
//                Toast.makeText(context,"delete:"+file.getAbsolutePath(), Toast.LENGTH_SHORT);
                break;
            // 创建新文件
            case FileObserver.CREATE:
                Log.d("FileListener", "CREATE，path:"+file.getAbsolutePath());
//                Toast.makeText(context,"create:"+file.getAbsolutePath(), Toast.LENGTH_SHORT);
                break;
            // 自删除
            case FileObserver.DELETE_SELF:
                Log.d("FileListener", "DELETE_SELF");
                break;
            // 自移动
            case FileObserver.MOVE_SELF:
                Log.d("FileListener", "MOVE_SELF");
                break;
            default:
//                Log.d("FileListener","event:"+event+", path:"+file.getAbsolutePath());
        }
    }
}
