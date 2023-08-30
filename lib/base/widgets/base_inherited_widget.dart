import 'package:flutter/material.dart';

import '../base_cubit.dart';

abstract class BaseInheritedStatelessWidget<C extends BaseCubit> extends StatelessWidget {
  const BaseInheritedStatelessWidget({Key? key, required this.rootCubit}) : super(key: key);
  final C rootCubit;
}

abstract class BaseInheritedStatefulWidget<C extends BaseCubit, P extends StatefulWidget> extends State<P> {
  final C rootCubit;
  BaseInheritedStatefulWidget(this.rootCubit);
}
