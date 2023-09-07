import 'package:ar_zoo_explorers/app/config/routes.dart';
import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState());

  void navigateToCameraPage(BuildContext context) {
    context.router.pushNamed(Routes.camera);
  }
}
