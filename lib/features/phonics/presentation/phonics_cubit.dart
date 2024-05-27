import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/phonics/presentation/phonics_state.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:injectable/injectable.dart';

@injectable
class PhonicsCubit extends BaseCubit<PhonicsState> {
  PhonicsCubit() : super(PhonicsState());
  String audioUrl = "audio/vietnamesealphabet.mp3";

  Duration duration = const Duration(seconds: 20, minutes: 1);
  Duration position = const Duration(seconds: 5, minutes: 0);
  bool isPlaying = false;

  PlayerState audioState = PlayerState.stopped;
  double volumeValue = 0.5;
  bool isLoop = false;
}
