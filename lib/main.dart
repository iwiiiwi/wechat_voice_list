import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wechat_voice_list/config/router_manger.dart';
import 'package:wechat_voice_list/view_mode/locale_model.dart';
import 'package:wechat_voice_list/view_mode/theme_model.dart';

import 'config/provider_manager.dart';
import 'config/storage_manager.dart';
import 'generated/l10n.dart';

main() async {
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  await StorageManager.init();
  runApp(App());
  // Android状态栏透明 splash为白色,所以调整状态栏文字为黑色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MultiProvider(
            providers: providers,
            child: Consumer2<ThemeModel, LocaleModel>(
                builder: (context, themeModel, localeModel, child) {
                  return RefreshConfiguration(
                    hideFooterWhenNotFull: true, //列表数据不满一页,不触发加载更多
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      theme: themeModel.themeData(),
                      darkTheme: themeModel.themeData(platformDarkMode: true),
                      locale: localeModel.locale,
                      localizationsDelegates: const [
                        S.delegate,
                        RefreshLocalizations.delegate, //下拉刷新
                        GlobalCupertinoLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate
                      ],
                      supportedLocales: S.delegate.supportedLocales,
                      onGenerateRoute: Router.generateRoute,
                      initialRoute: RouteName.splash,
                    ),
                  );
                })));
  }
}
