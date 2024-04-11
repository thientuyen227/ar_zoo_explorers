import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/story/storyoverview/presentation/storyoverview_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryOverviewCubit extends BaseCubit<StoryOverviewState> {
  StoryOverviewCubit() : super(StoryOverviewState());

  double HEIGHT = 0;
  double WIDTH = 0;
  String name = "Rùa và thỏ";
  String avatar =
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFKGwd9XsayxfZ2m8XD3PQegpGYz4Dzwy6hR85H7bgIg&s";
  String author = "Đang cập nhật";
  String reader = "Đang cập nhật";
  int listencount = 100;
  Duration duration = const Duration(seconds: 0, minutes: 0, hours: 0);
  String topic = "Ngụ ngôn";

  String overview =
      "Một cuộc đua đầy kịch tính giữa hai nhân vật đã tạo ra sự chú ý đặc biệt. Sự đối lập giữa tốc độ của thỏ và kiên nhẫn của rùa làm cho câu chuyện trở nên hấp dẫn và gợi lên những bài học sâu sắc về sự quyết tâm và kiên định trong cuộc sống.";
}
