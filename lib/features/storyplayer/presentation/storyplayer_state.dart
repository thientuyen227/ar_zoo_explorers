import 'package:audioplayers/audioplayers.dart';

import '../../../app/app/app_state.dart';

class StoryPlayerState {
  final PageStatus pageStatus;

  double width;
  double height;

  String name;
  String avatar;
  String audioUrl;
  String content;

  Duration duration;
  Duration position;
  bool isPlaying;

  PlayerState audioState;
  double volumeValue;
  bool isLoop;

  StoryPlayerState({
    this.pageStatus = PageStatus.loading,
    this.width = 0,
    this.height = 0,
    this.name = _defaultName,
    this.avatar = _defaultAvatar,
    this.audioUrl = _defaultAudioLink,
    this.content = _defaultContent,
    this.duration = const Duration(seconds: 0, minutes: 0),
    this.position = const Duration(seconds: 0, minutes: 0),
    this.isPlaying = false,
    this.audioState = PlayerState.stopped,
    this.volumeValue = 1.0,
    this.isLoop = false,
  });

  StoryPlayerState copyWith({
    PageStatus? pageStatus,
    double? height,
    double? width,
    String? name,
    String? avatar,
    String? audioUrl,
    String? content,
    Duration? duration,
    Duration? position,
    bool? isPlaying,
    PlayerState? audioState,
    double? volumeValue,
    bool? isLoop,
  }) {
    return StoryPlayerState(
      pageStatus: pageStatus ?? this.pageStatus,
      height: height ?? this.height,
      width: width ?? this.width,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      audioUrl: audioUrl ?? this.audioUrl,
      content: content ?? this.content,
      duration: duration ?? this.duration,
      position: position ?? this.position,
      isPlaying: isPlaying ?? this.isPlaying,
      audioState: audioState ?? this.audioState,
      volumeValue: volumeValue ?? this.volumeValue,
      isLoop: isLoop ?? this.isLoop,
    );
  }

  setAttributes({
    PageStatus? pageStatus,
    double? height,
    double? width,
    String? name,
    String? avatar,
    String? audioUrl,
    String? content,
    Duration? duration,
    Duration? position,
    bool? isPlaying,
    PlayerState? audioState,
    double? volumeValue,
    bool? isLoop,
  }) async {
    this.pageStatus ?? this.pageStatus;
    this.height = height ?? this.height;
    this.width = width ?? this.width;
    this.name = name ?? this.name;
    this.avatar = avatar ?? this.avatar;
    this.audioUrl = audioUrl ?? this.audioUrl;
    this.content = content ?? this.content;
    this.duration = duration ?? this.duration;
    this.position = position ?? this.position;
    this.isPlaying = isPlaying ?? this.isPlaying;
    this.audioState = audioState ?? this.audioState;
    this.volumeValue = volumeValue ?? this.volumeValue;
    this.isLoop = isLoop ?? this.isLoop;
  }

  static const String _defaultName = "Rùa và thỏ";
  static const String _defaultAvatar =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/stories%2Fimg_default_book.jpg?alt=media&token=8dec4ea0-7fb6-436b-9b09-0efddf866fb6";
  static const String _defaultAudioLink =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/stories%2Fruavatho.mp3?alt=media&token=9667ebc0-a003-4b5e-985a-c5bce386a52e";
  static const String _defaultContent =
      "Một buổi sáng mùa thu, Rùa đang chăm chỉ tập chạy, Thỏ trông thấy, bèn chế giễu: \n- Bạn chậm rì rì mà cũng đòi tập chạy à?\nNghe Thỏ nói xong, Rùa trả lời:\n- Bạn với mình thử so tài xem ai hơn ai?\nThỏ vên mặt lên đáp:\n - Bạn dám thi chạy với mình à? Được thôi... Mình chấp bạn nữa đường!\nRùa biết mình chậm, nên khi bác Gấu vừa hô: \"Ch...ạ...y!\" thì nó cố sức nhích từng bước một.\nThỏ tủm tìm cười, nó nghĩ: \"Chẳng phải vội, đợi Rùa gần về đích, ta chỉ phóng vèo một hơi là tới.\"\nRồi nó vừa đi vừa đuổi bướm, hái hoa, quên cả việc chạy thi. Khi tiếng cổ vũ: \"Rùa ơi, cố lên! Rùa ơi, cố lên!\", Thỏ ngẩng đầu nhìn thì thấy Rùa sắp về đích. Nó vội lao đi như tên bắn. Nhưng muồn rồi, Rùa đã về đích trước. Tuy xấu hổi vì thua, nhưng Thỏ vẫn cùng các bạn chúc mừng Rùa đã thắng cuộc.";
}
