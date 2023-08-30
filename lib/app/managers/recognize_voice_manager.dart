import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class RecognizeVoiceManager {
  final _channel = const MethodChannel("co.newbapps.chatgpt/voice");

  Future<List<String>> recognizeVoice() async {
    try {
      final results = await _channel.invokeMethod<List<dynamic>>("recognizeVoice") ?? [];
      return results.map((e) => e.toString()).toList();
    } catch (e, s) {
      log("recognizeVoice", error: e, stackTrace: s);
    }
    return [];
  }
}
