import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String home = "/";
  static const String settings = "/settings";
  static const String splash = "/splash";
  static const String ar = "/ar";
  static const String login = "/login";
  static const String register = "/register";
  static const String welcome = "/welcome";
  static const String userprofile = "/userprofile";
  static const String termofservice = "/termofservice";
  static const String accountmanager = "/accountmanager";
  static const String userinformation = "/userinformation";
  static const String forgotpassword = "/forgotpassword";
  static const String resetpassword = "/resetpassword";
  static const String changepassword = "/changepassword";
  static const String animalmodels = "/animalmodels";
  static const String modeldetail = "/modeldetail";
  static const String searchmodel = "/searchmodel";
  static const String learning = "/learning";
  static const String story = "/story";
  static const String help = "/help";
  static const String languageselection = "/languageselection";
  static const String changelanguage = "/changelanguage";

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}
