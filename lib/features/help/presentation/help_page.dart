import 'dart:convert';

import 'package:ar_zoo_explorers/utils/widget/custom_back_button.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final String url =
      'https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/help.html?alt=media';
  final content =
      '<h3 class="ql-align-center"><strong style="background-color: transparent; color: rgb(0, 0, 0);">Instructions for using the app:</strong></h3> <p><span style="background-color: transparent; color: rgb(0, 0, 0);">Step 1: Log in to the app. Once logged in, the app interface will appear as follows:</span></p> <p><span style="background-color: transparent; color: rgb(0, 0, 0);"><img style="display: block; margin: 0 auto;" src="https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/help%2F1.jpg?alt=media" height="689" width="326"></span></p> <p><span style="background-color: transparent; color: rgb(0, 0, 0);">Step 2: Choose a category that interests you:</span></p> <p><span style="background-color: transparent; color: rgb(0, 0, 0);"><img style="display: block; margin: 0 auto;" src="https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/help%2F2.jpg?alt=media" height="659" width="311"></span></p> <p><span style="background-color: transparent; color: rgb(0, 0, 0);">Step 3: Pick the animal you want to see in augmented reality:</span></p> <p><span style="background-color: transparent; color: rgb(0, 0, 0);"><img style="display: block; margin: 0 auto;" src="https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/help%2F3.jpg?alt=media" height="705" width="334"></span></p> <p><span style="background-color: transparent; color: rgb(0, 0, 0);">Step 4: If theres an option to download, select the download button. After that, click on the camera icon to experience augmented reality:</span></p> <p><span style="background-color: transparent; color: rgb(0, 0, 0);"><img style="display: block; margin: 0 auto;" src="https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/help%2F4.jpg?alt=media" height="720" width="342"></span></p> <p><br></p>';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          centerTitle: true,
          title: const Text("Instruction"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                  future: download(),
                  builder: (context, snapshot) {
                    return Html(
                      data: snapshot.data ?? content,
                      style: {
                        "body": Style(
                            padding: HtmlPaddings.all(0),
                            margin: Margins.zero,
                            fontSize: FontSize(16),
                            textAlign: TextAlign.justify),
                        "img": Style(
                            width: Width(245),
                            padding: HtmlPaddings.only(right: 30))
                      },
                    );
                  }),
            ],
          ),
        ));
  }

  Future<String> download() async {
    try {
      final response = await http.get(Uri.parse(url));
      return utf8.decode(response.bodyBytes);
    } catch (e) {
      return content;
    }
  }
}
