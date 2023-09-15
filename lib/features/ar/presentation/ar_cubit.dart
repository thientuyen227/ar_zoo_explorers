import 'package:ar_zoo_explorers/base/base_cubit.dart';
import 'package:ar_zoo_explorers/features/ar/presentation/ar_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ARCubit extends BaseCubit<ARState> {
  ARCubit() : super(ARState());
}
