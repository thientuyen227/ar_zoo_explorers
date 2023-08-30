import 'package:flutter/services.dart';
import 'package:flutter_js/flutter_js.dart';

enum JSGPTFunction { talk }

class JSGPTService {
  final _jsRuntime = getJavascriptRuntime(xhr: true);

  Future<bool> init() async {
    final source = await rootBundle.loadString("assets/lotties/js_gpt_service.js");
    final result = await _jsRuntime.evaluateAsync(source);
    return !result.isError;
  }

  Future<String?> talk(String message) async {
    final asyncResult = _jsRuntime.evaluate("${JSGPTFunction.talk.name}(${message.codeUnits})");
    _jsRuntime.executePendingJob();
    final promiseResolved = await _jsRuntime.handlePromise(asyncResult);
    return promiseResolved.stringResult;
  }
}
