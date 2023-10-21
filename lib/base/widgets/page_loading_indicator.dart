import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PageLoadingIndicator extends StatelessWidget {
  const PageLoadingIndicator({
    super.key,
    required this.future,
    required this.scaffold,
  });

  final Future? future;
  final Scaffold scaffold;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        scaffold,
        FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            return Visibility(
              visible: snapshot.connectionState == ConnectionState.waiting,
              child: Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
