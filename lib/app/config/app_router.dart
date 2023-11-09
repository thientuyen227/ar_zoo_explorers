import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/'),
        AutoRoute(page: SettingRoute.page, path: '/settings'),
        AutoRoute(page: AppRoute.page, initial: true),
        AutoRoute(page: SplashRoute.page, path: '/splash'),
        AutoRoute(page: ARRoute.page, path: '/ar'),
        AutoRoute(page: LoginRoute.page, path: '/login'),
        AutoRoute(page: RegisterRoute.page, path: '/register'),
        AutoRoute(page: WelcomeRoute.page, path: '/welcome'),
        AutoRoute(page: UserProfileRoute.page, path: '/userprofile'),
        AutoRoute(page: TermOfServiceRoute.page, path: '/termofservice'),
        AutoRoute(page: AccountManagerRoute.page, path: '/accountmanager'),
        AutoRoute(page: TestUnity.page, path: '/testunity')
      ];
}
