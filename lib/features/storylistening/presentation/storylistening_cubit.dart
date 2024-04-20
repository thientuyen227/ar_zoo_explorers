import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/story/model/storybuttonobject.dart';
import 'package:ar_zoo_explorers/features/storylistening/presentation/storylistening_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class StoryListeningCubit extends BaseCubit<StoryListeningState> {
  StoryListeningCubit() : super(StoryListeningState());

  List<StoryButtonObject> listStory = [
    StoryButtonObject(
        avatar:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFKGwd9XsayxfZ2m8XD3PQegpGYz4Dzwy6hR85H7bgIg&s",
        name: 'Rùa Và Thỏ',
        topic: 'Ngụ Ngôn',
        duration: const Duration(minutes: 4, seconds: 34),
        timestamp: const Duration(minutes: 3, seconds: 34)),
    StoryButtonObject(
        avatar:
            "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEi657OFIAxdkCx6UKg-O3E8lyNvAnr_r8i4DeAMRJUD5JURpRnfnhl6HR78IYhIp2pFJ9Ad7pq8xQaV2_04HWbE_o-jweJ4injvlT2qg4AAUkEHz8grsEVLDeMxK9YtLlj-FS5XlKoMe2-k/s1600/bac_voi_tot_bung_4.jpg",
        name: 'Bác Voi Tốt Bụng',
        topic: 'Đạo Đức',
        duration: const Duration(minutes: 4, seconds: 34),
        timestamp: const Duration(minutes: 3, seconds: 3)),
    StoryButtonObject(
        avatar:
            "https://4.bp.blogspot.com/-cCt_3UncqGg/Ws225-kNSEI/AAAAAAAAYUg/45QproQK3c4YzLfalVeDe72FjkHkwt96ACLcBGAs/s1600/IMG_5779a.JPG?w=900",
        name: 'Chú Gà Trống Kiêu Căng',
        topic: 'Đạo Đức',
        duration: const Duration(minutes: 4, seconds: 34),
        timestamp: const Duration(minutes: 2, seconds: 50)),
    StoryButtonObject(
        avatar:
            "https://static.8cache.com/cover/o/eJzLyTDW1_VIzDROLfM3Noh31A8LM8zQLQlx8Uj11HeEgrw8V_0o5-Ck1IDyQEf3bP1iAwDLihCU/de-men-phieu-luu-ky.jpg",
        name: 'Dế Mèn Phiêu Lưu Ký',
        topic: 'Giả Tưởng',
        duration: const Duration(minutes: 4, seconds: 34),
        timestamp: const Duration(minutes: 1, seconds: 0)),
    StoryButtonObject(
        avatar:
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_UcA0g2_L59hUx_BS15EW-VSh4HQAVcrSP6Rc79-4uQ&s",
        name: 'Chú Chó Hachiko',
        topic: 'Đạo Đức',
        duration: const Duration(minutes: 4, seconds: 34),
        timestamp: const Duration(minutes: 0, seconds: 0)),
    StoryButtonObject(
        avatar:
            "https://cdn.eva.vn/upload/1-2022/images/2022-01-02/truyen-co-tich-vit-con-xau-xi-v---t-1-1641101885-38-width600height339.jpg",
        name: 'Vịt Con Xấu Xí',
        topic: 'Giả Tưởng',
        duration: const Duration(minutes: 4, seconds: 34),
        timestamp: const Duration(minutes: 3, seconds: 34))
  ];

  double WIDTH = 0;
  double HEIGHT = 0;
}
