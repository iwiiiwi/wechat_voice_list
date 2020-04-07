
import 'package:provider/single_child_widget.dart';
import 'package:wechat_voice_list/view_mode/locale_model.dart';
import 'package:wechat_voice_list/view_mode/theme_model.dart';
import 'package:provider/provider.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

/// 独立的model
List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider<ThemeModel>(
    create: (context) => ThemeModel(),
  ),
  ChangeNotifierProvider<LocaleModel>(
    create: (context) => LocaleModel(),
  ),
//  ChangeNotifierProvider<GlobalFavouriteStateModel>(
//    create: (context) => GlobalFavouriteStateModel(),
//  )
];

/// 需要依赖的model
///
/// UserModel依赖globalFavouriteStateModel
List<SingleChildWidget> dependentServices = [
//  ChangeNotifierProxyProvider<GlobalFavouriteStateModel, UserModel>(
//    create: null,
//    update: (context, globalFavouriteStateModel, userModel) =>
//    userModel ??
//        UserModel(globalFavouriteStateModel: globalFavouriteStateModel),
//  )
];

List<SingleChildWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
//  )
];
