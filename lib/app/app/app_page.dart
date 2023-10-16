import 'package:ar_zoo_explorers/features/splash/splash_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../base/base_state.dart';
import '../../features/home/presentation/home_page.dart';
import 'app_cubit.dart';
import 'app_state.dart';

@RoutePage()
class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends BaseState<AppState, AppCubit, AppPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    cubit.init();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget buildByState(BuildContext context, AppState state) {
    switch (state.status) {
      case PageStatus.loading:
        return const SplashPage();
      case PageStatus.idle:
        return const HomePage();
      case PageStatus.error:
        return Container();
    }
  }
}
