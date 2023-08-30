
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'app_bar_widget.dart';

class LinkViewWidget extends StatelessWidget {
  final String title;
  final String url;

  const LinkViewWidget({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
        title: title,
        addCloseBtn: true,
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.tryParse(url)),
      ),
    );
  }
}
