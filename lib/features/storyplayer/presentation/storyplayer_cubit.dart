import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/domain/entities/story_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/user_story_entity.dart';
import 'package:ar_zoo_explorers/features/storyplayer/presentation/storyplayer_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryPlayerCubit extends BaseCubit<StoryPlayerState> {
  StoryPlayerCubit() : super(StoryPlayerState());

  double HEIGHT = 0;
  double WIDTH = 0;
  String name = "Rùa và thỏ";
  String avatar =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/stories%2Fimg_default_book.jpg?alt=media&token=8dec4ea0-7fb6-436b-9b09-0efddf866fb6";
  String audioUrl =
      "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/stories%2Fruavatho.mp3?alt=media&token=9667ebc0-a003-4b5e-985a-c5bce386a52e";
  String content =
      "Một buổi sáng mùa thu, Rùa đang chăm chỉ tập chạy, Thỏ trông thấy, bèn chế giễu: \n- Bạn chậm rì rì mà cũng đòi tập chạy à?\nNghe Thỏ nói xong, Rùa trả lời:\n- Bạn với mình thử so tài xem ai hơn ai?\nThỏ vên mặt lên đáp:\n - Bạn dám thi chạy với mình à? Được thôi... Mình chấp bạn nữa đường!\nRùa biết mình chậm, nên khi bác Gấu vừa hô: \"Ch...ạ...y!\" thì nó cố sức nhích từng bước một.\nThỏ tủm tìm cười, nó nghĩ: \"Chẳng phải vội, đợi Rùa gần về đích, ta chỉ phóng vèo một hơi là tới.\"\nRồi nó vừa đi vừa đuổi bướm, hái hoa, quên cả việc chạy thi. Khi tiếng cổ vũ: \"Rùa ơi, cố lên! Rùa ơi, cố lên!\", Thỏ ngẩng đầu nhìn thì thấy Rùa sắp về đích. Nó vội lao đi như tên bắn. Nhưng muồn rồi, Rùa đã về đích trước. Tuy xấu hổi vì thua, nhưng Thỏ vẫn cùng các bạn chúc mừng Rùa đã thắng cuộc.";

  Duration duration = const Duration(seconds: 20, minutes: 1);
  Duration position = const Duration(seconds: 5, minutes: 0);
  bool isPlaying = false;

  PlayerState audioState = PlayerState.stopped;
  double volumeValue = 0.5;
  bool isLoop = false;

  void getInformations(StoryEntity storyEntity, UserStoryEntity usEntity) {
    name = storyEntity.title;
    avatar = storyEntity.avatar;
    audioUrl = storyEntity.sourceUrl;
    // audioUrl =
    // "https://firebasestorage.googleapis.com/v0/b/ar-zoo-explorers.appspot.com/o/stories%2Fchuvoitotbung%2Fchuvoitotbung.mp3?alt=media&token=994d2ede-c91f-4c8f-8f30-ed4f54242ee9";
    content = storyEntity.content;
    duration = Duration(seconds: storyEntity.duration);
    position = Duration(seconds: usEntity.pausedTime);
  }
}
