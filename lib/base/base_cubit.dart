
import 'package:ar_zoo_explorers/app/config/app_config.dart';
import 'package:ar_zoo_explorers/core/data/local_storage/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';

import '../app/app/app_cubit.dart';
import '../app/app/app_msg.dart';
import '../di/injector.dart';
import 'base_event.dart';

abstract class BaseCubit<T> extends Cubit<T> {
  //Core
  final eventSubject = PublishSubject<BaseEvent>();
  Stream<BaseEvent> get eventStream => eventSubject.stream;
  //From App Cubit
  AppCubit get appCubit => getIt<AppCubit>();
  // App Config
  AppConfig get appConfig => getIt<AppConfig>();
  // Local Storage
  LocalStorage get localStorage => getIt<LocalStorage>();

  BaseCubit(T initialState) : super(initialState);

  showLoading({bool hasBlurBackground = true, AppMsg? message}) {
    _addToEvent(LoadingEvent(isLoading: true, hasBlurBackground: hasBlurBackground, message: message));
  }

  hideLoading({bool hasBlurBackground = true}) {
    _addToEvent(LoadingEvent(isLoading: false, hasBlurBackground: hasBlurBackground));
  }

  showMessage(dynamic msg) {
    _addToEvent(MessageEvent(msg: msg));
  }

  showToast(String msg) {
    _addToEvent(ToastEvent(msg: msg));
  }

  handleError(dynamic error) {
    _addToEvent(ErrorEvent(error: error));
  }

  showSubcription() {
    _addToEvent(SubcriptionEvent());
  }

  _addToEvent(BaseEvent event) {
    if (!eventSubject.isClosed) {
      eventSubject.add(event);
    }
  }

  @override
  Future<void> close() {
    eventSubject.close();
    return super.close();
  }
}
