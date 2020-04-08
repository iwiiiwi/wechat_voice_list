import 'package:flutter/cupertino.dart';
import 'package:wechat_voice_list/config/storage_manager.dart';

/// 使用原生WebView
const String kUseWebViewPlugin = 'kUseWebViewPlugin';

class UseWebViewPluginModel extends ChangeNotifier {
  get value =>
      StorageManager.sharedPreferences.getBool(kUseWebViewPlugin) ?? false;

  switchValue(){
    StorageManager.sharedPreferences
        .setBool(kUseWebViewPlugin, !value);
    notifyListeners();
  }

}
