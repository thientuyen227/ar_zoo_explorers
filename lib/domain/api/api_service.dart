import 'dart:convert';
import 'dart:io';

import 'package:ar_zoo_explorers/domain/entities/chatbox_entity.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl =
      'https://imagechatv4.chooch.ai/predict?api_key=3f9d4e54-0194-4130-aa68-5e68852263bb';

  Future<ChatBoxEntity> getImageToTextResponse(
      File imageFile, String detectedLanguage) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['data'] = json.encode({
      'parameters': {'prompt': '', 'lang': detectedLanguage, 'stream': true},
      'model_id': 'chooch-image-chat-4'
    });
    request.files.add(http.MultipartFile(
        'file', imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
        filename: imageFile.path.split('/').last));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonStrings = responseData.split('}{').map((str) {
      if (!str.startsWith('{')) {
        str = '{$str';
      }
      if (!str.endsWith('}')) {
        str = '$str}';
      }
      return str;
    }).toList();
    String combinedPredictions = '';
    String sourceId = '';

    for (var jsonString in jsonStrings) {
      var parsedData = jsonDecode(jsonString);
      var entity = ChatBoxEntity.fromJson(parsedData);
      combinedPredictions += '${entity.prediction} ';
      if (sourceId.isEmpty) sourceId = entity.sourceId;
    }

    // Return a new ChatBoxEntity with combined predictions
    return ChatBoxEntity(
      sourceId: sourceId,
      prediction: combinedPredictions.trim(),
    );
  }

  Future<ChatBoxEntity> getTextToImageResponse(
      String text, String detectedLanguage) async {
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['data'] =
        '{"parameters":{"prompt":"$text","lang":"en","stream":true},"model_id":"chooch-image-chat-4"}';
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      try {
        var parsedData = jsonDecode(responseData);
        return ChatBoxEntity.fromJson(parsedData);
      } catch (e) {
        throw Exception('Failed to decode response JSON: $e');
      }
    } else {
      throw Exception('Failed to send request: ${response.statusCode}');
    }
  }
}
