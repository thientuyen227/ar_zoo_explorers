import 'package:flutter/material.dart';

class PermissionGuardWidget extends StatefulWidget {
  const PermissionGuardWidget({
    Key? key,
    required this.child,
    required this.permissionGrantedCheck,
  }) : super(key: key);

  final Widget child;

  /// Ex: Permission.storage.isGranted
  final Future<bool> permissionGrantedCheck;

  @override
  State<PermissionGuardWidget> createState() => _PermissionGuardWidgetState();
}

class _PermissionGuardWidgetState extends State<PermissionGuardWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: widget.permissionGrantedCheck,
        builder: (context, snap) {
          if (snap.hasData && snap.connectionState == ConnectionState.done) {
            if (snap.data == true) {
              return widget.child;
            }
            return const _GoToPermissionWidget();
          }
          return const SizedBox();
        });
  }
}

class _GoToPermissionWidget extends StatelessWidget {
  const _GoToPermissionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
