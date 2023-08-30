import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'completion.dart';
import 'completion_param.dart';

part 'gpt_client.g.dart';

@RestApi(baseUrl: "https://api.openai.com/v1")
abstract class GptClient {
  factory GptClient(Dio dio, {String baseUrl}) = _GptClient;

  @POST("/completions")
  Future<Completion> completions(@Body() CompletionParam param, {@DioOptions() Options? options});
}
