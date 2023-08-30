import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'model/choice.dart';
import 'model/completion_param.dart';
import 'model/gpt_client.dart';

class ApiKey {
  String key;
  bool isValid;
  ApiKey({
    required this.key,
    this.isValid = true,
  });
}

class AuthInterceptor extends InterceptorsWrapper {
  final Dio dio;
  final List<ApiKey> apiKeys;
  AuthInterceptor({required this.dio, required this.apiKeys});

  List<ApiKey> get validApiKeys => apiKeys.where((element) => element.isValid).toList();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (validApiKeys.isEmpty) {
      handler.reject(DioError(
          requestOptions: options, response: Response(requestOptions: options, statusCode: HttpStatus.unauthorized)));
      return;
    }
    final key = validApiKeys.randomItem().key;
    handler.next(options.copyWith(headers: {"Authorization": "Bearer $key"}));
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    int code = err.response?.statusCode ?? HttpStatus.badRequest;
    if (code >= HttpStatus.badRequest && code <= HttpStatus.clientClosedRequest) {
      bool isValid = isValidKey(err);
      if (isValid) {
        await onRetry(err, handler).then((value) => handler.resolve(value), onError: (e) {
          handler.reject(e);
        });
        return;
      }
    }
    super.onError(err, handler);
  }

  bool isValidKey(DioError err) {
    apiKeys.forEachIndexed((index, element) {
      if (err.requestOptions.headers["Authorization"]?.toString().contains(element.key) == true) {
        apiKeys[index].isValid = false;
      }
    });
    return validApiKeys.isNotEmpty;
  }

  Future<Response<Map<String, dynamic>>> onRetry(DioError err, ErrorInterceptorHandler handler) async {
    return dio.fetch<Map<String, dynamic>>(err.requestOptions
        .copyWith(headers: err.requestOptions.headers..["Authorization"] = validApiKeys.randomItem().key));
  }
}

@singleton
class GptService {
  late final GptClient _client;

  void init({required List<String> apiKeys}) {
    final dio = Dio();
    dio.interceptors.add(AuthInterceptor(apiKeys: apiKeys.map((e) => ApiKey(key: e.toString())).toList(), dio: dio));
    _client = GptClient(dio);
  }

  Future<List<Choice>> talk(String message, {required CompletionParam param}) async {
    try {
      final completion = await _client.completions(param.copyWith(prompt: [message], stop: ["\n\n\n"]));
      return completion.choices;
    } catch (e, s) {
      log("talk()", error: e, stackTrace: s);
      if (e is DioError) {
        int code = e.response?.statusCode ?? HttpStatus.badRequest;
        if (code >= HttpStatus.badRequest && code <= HttpStatus.clientClosedRequest) {
          // return await getIt<ThirdPartyService>().talk(message);
        }
      }
      rethrow;
    }
  }

  
}

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[math.Random().nextInt(length)];
  }
}
