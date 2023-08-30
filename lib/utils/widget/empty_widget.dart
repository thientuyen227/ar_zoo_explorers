import 'package:ar_zoo_explorers/utils/extension/context_ext.dart';
import 'package:flutter/cupertino.dart';

class AppEmptyData extends StatelessWidget {
  const AppEmptyData({Key? key, this.message}) : super(key: key);

  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message ?? 'No Content', style: context.myTheme.textThemeT4.body));
  }
}
