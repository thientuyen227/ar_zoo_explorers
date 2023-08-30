import 'package:ar_zoo_explorers/app/theme/dimens.dart';
import 'package:ar_zoo_explorers/app/theme/icons.dart';
import 'package:ar_zoo_explorers/base/base_state.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_cubit.dart';
import 'package:ar_zoo_explorers/features/home/presentation/home_state.dart';
import 'package:ar_zoo_explorers/utils/extension/context_ext.dart';
import 'package:ar_zoo_explorers/utils/widget/app_bar_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/button_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/image_widget.dart';
import 'package:ar_zoo_explorers/utils/widget/spacer_widget.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app/config/routes.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() => _State();
}

class _State extends BaseState<HomeState,HomeCubit,HomePage > {
  @override
  Widget buildByState(BuildContext context, HomeState state) {
    return Scaffold(
      appBar: AppAppBar(
        centerTitle: false,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIconButton(
              onPressed: () {
                context.router.pushNamed(Routes.settings);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
              borderRadius: AppDimens.radius200,
              padding: const EdgeInsets.all(AppDimens.spacing5),
              width: AppDimens.size30.width,
              height: AppDimens.size30.height,
              backgroundColor: context.myTheme.colorScheme.cardColor,
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          VSpacing(
            spacing: AppDimens.spacing20,
          ),
          Center(
            child: FractionallySizedBox(widthFactor: 0.8, child: AppImageWidget(assetString: AppImages.imgHome)),
          ),
        ],
      ),
    );
    
  }
  
}
