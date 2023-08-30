import 'dart:convert';

class CompletionParam {
  final String model;
  final List<String> prompt;
  final String? suffix;
  final int maxTokens;
  final double temperature;
  final int topP;
  final int n;
  final bool stream;
  final int? logprobs;
  final bool echo;
  final List<String>? stop;
  final double presencePenalty;
  final double frequencyPenalty;
  final int bestOf;
  final Map<dynamic, dynamic>? logitBias;
  CompletionParam({
    this.model = "text-davinci-003",
    required this.prompt,
    this.suffix,
    this.maxTokens = 100,
    this.temperature = 1,
    this.topP = 1,
    this.n = 1,
    this.stream = false,
    this.logprobs,
    this.echo = false,
    this.stop,
    this.presencePenalty = 0.0,
    this.frequencyPenalty = 0.0,
    this.bestOf = 1,
    this.logitBias,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'model': model});
    result.addAll({'prompt': prompt});
    if (suffix != null) {
      result.addAll({'suffix': suffix});
    }
    result.addAll({'max_tokens': maxTokens});
    result.addAll({'temperature': temperature});
    result.addAll({'top_p': topP});
    result.addAll({'n': n});
    result.addAll({'stream': stream});
    if (logprobs != null) {
      result.addAll({'logprobs': logprobs});
    }
    result.addAll({'echo': echo});
    if (stop != null) {
      result.addAll({'stop': stop});
    }
    result.addAll({'presence_penalty': presencePenalty});
    result.addAll({'frequency_penalty': frequencyPenalty});
    result.addAll({'best_of': bestOf});
    if (logitBias != null) {
      result.addAll({'logit_bias': logitBias});
    }

    return result;
  }

  factory CompletionParam.fromMap(Map<String, dynamic> map) {
    return CompletionParam(
      model: map['model'] ?? "text-davinci-003",
      prompt: List<String>.from(map['prompt'] ?? []),
      suffix: map['suffix'],
      maxTokens: map['max_tokens']?.toInt() ?? 100,
      temperature: map['temperature']?.toDouble() ?? 1.0,
      topP: map['top_p']?.toInt() ?? 1,
      n: map['n']?.toInt() ?? 1,
      stream: map['stream'] ?? false,
      logprobs: map['logprobs']?.toInt(),
      echo: map['echo'] ?? false,
      stop: map['stop'] != null ? List<String>.from(map['stop']) : null,
      presencePenalty: map['presence_penalty']?.toDouble() ?? 0.0,
      frequencyPenalty: map['frequency_penalty']?.toDouble() ?? 0.0,
      bestOf: map['best_of']?.toInt() ?? 1,
      logitBias: map['logit_bias'] != null ? Map<dynamic, dynamic>.from(map['logit_bias']) : null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory CompletionParam.fromJson(String source) => CompletionParam.fromMap(json.decode(source));

  CompletionParam copyWith({
    String? model,
    List<String>? prompt,
    String? suffix,
    int? maxTokens,
    double? temperature,
    int? topP,
    int? n,
    bool? stream,
    int? logprobs,
    bool? echo,
    List<String>? stop,
    double? presencePenalty,
    double? frequencyPenalty,
    int? bestOf,
    Map<dynamic, dynamic>? logitBias,
  }) {
    return CompletionParam(
      model: model ?? this.model,
      prompt: prompt ?? this.prompt,
      suffix: suffix ?? this.suffix,
      maxTokens: maxTokens ?? this.maxTokens,
      temperature: temperature ?? this.temperature,
      topP: topP ?? this.topP,
      n: n ?? this.n,
      stream: stream ?? this.stream,
      logprobs: logprobs ?? this.logprobs,
      echo: echo ?? this.echo,
      stop: stop ?? this.stop,
      presencePenalty: presencePenalty ?? this.presencePenalty,
      frequencyPenalty: frequencyPenalty ?? this.frequencyPenalty,
      bestOf: bestOf ?? this.bestOf,
      logitBias: logitBias ?? this.logitBias,
    );
  }
}
