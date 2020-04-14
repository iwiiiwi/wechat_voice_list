package com.v.wechat.voicelist.wechat_voice_list.business;

import android.annotation.TargetApi;
import android.os.FileObserver;
import android.util.Log;

import java.io.File;
import java.util.List;

public class VoiceFileObserver extends FileObserver {

    private static final String TAG = "VoiceFileObserver";

    @TargetApi(29)
    public VoiceFileObserver(File file) {
        super(file, FileObserver.CREATE | FileObserver.DELETE);
    }

    @TargetApi(29)
    public VoiceFileObserver(List<File> files) {
        super(files,  FileObserver.CREATE | FileObserver.DELETE);
    }

    public VoiceFileObserver(String path) {
        super(path, FileObserver.CREATE | FileObserver.DELETE);
    }

    @Override
    public void onEvent(int event, String path) {
        Log.d(TAG,"event:"+event+", path:"+path);
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
                    Log.d("FileListener", "DELETE");
                    break;
                // 创建新文件
                case FileObserver.CREATE:
                    Log.d("FileListener", "CREATE");
                    break;
                // 自删除
                case FileObserver.DELETE_SELF:
                    Log.d("FileListener", "DELETE_SELF");
                    break;
                // 自移动
                case FileObserver.MOVE_SELF:
                    Log.d("FileListener", "MOVE_SELF");
                    break;

        }
    }
}
