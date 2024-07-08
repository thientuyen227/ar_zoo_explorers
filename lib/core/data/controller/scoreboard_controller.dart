import 'package:ar_zoo_explorers/core/data/controller/auth_controller.dart';
import 'package:ar_zoo_explorers/core/helpers/controller_helper.dart';
import 'package:ar_zoo_explorers/core/repositories/scoreboard_repository_implement.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/scoreboard_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ScoreboardController extends ControllerHelper {
  final ScoreboardRepository _scoreboardRepository =
      ScoreboardRepositoryImplement();
  AuthController? authController;

  Rx<ScoreboardEntity> currentScoreboardUser = Rx(ScoreboardEntity(
      id: '',
      userId: '',
      isAudio: false,
      isQuestion: false,
      learningId: '',
      vocabularyId: ''));

  Future<ScoreboardEntity?> getScoreboardByUser(
      BuildContext context, String userId, String vocabularyId) {
    return processRequest<ScoreboardEntity?>(
        request: () => _scoreboardRepository.getScoreboardByUser(
            context, userId, vocabularyId),
        onSuccess: (success) => success.data,
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<List<ScoreboardEntity>?> getAllScoreboardByUser(
      BuildContext context, String userId, String learningId) {
    return processRequest<List<ScoreboardEntity>?>(
      request: () => _scoreboardRepository.getAllScoreboardByUser(
          context, userId, learningId),
      onSuccess: (success) => success.data,
      onFailure: (failure) =>
          Fluttertoast.showToast(msg: "Access information failed!"),
    );
  }

  Future<ScoreboardEntity?> createOrGetScoreboardByUserByUser(
      BuildContext context, ScoreboardEntity scoreboardEntity) {
    return processRequest<ScoreboardEntity?>(
        request: () => _scoreboardRepository.createOrGetScoreboardByUser(
            context, scoreboardEntity),
        onSuccess: (success) => {_setCurrentScoreboardUser(success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  Future<ScoreboardEntity?> updateScoreboardByUser(
      BuildContext context, ScoreboardEntity scoreboardEntity) async {
    return processRequest<ScoreboardEntity?>(
        request: () => _scoreboardRepository.updateScoreboardUser(
            context, scoreboardEntity),
        onSuccess: (success) => {_setCurrentScoreboardUser(success.data!)},
        onFailure: (failure) =>
            Fluttertoast.showToast(msg: "Access information failed!"));
  }

  _setCurrentScoreboardUser(ScoreboardEntity entity) {
    currentScoreboardUser.value = entity;
    update();
  }

  static ScoreboardController get findOrInitialize {
    try {
      return Get.find<ScoreboardController>();
    } catch (e) {
      return Get.put(ScoreboardController(), permanent: true);
    }
  }
}

class ScoreboardBinding implements Bindings {
  @override
  void dependencies() {
    ScoreboardController.findOrInitialize;
  }
}
