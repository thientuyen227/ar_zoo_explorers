import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/scoreboard_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/src/widgets/framework.dart';

class ScoreboardRepositoryImplement implements ScoreboardRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();
  @override
  Future<Either<Failure, Success<ScoreboardEntity?>>>
      createOrGetScoreboardByUser(
          BuildContext context, ScoreboardEntity scoreboardEntity) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.createOrGetScoreboard(
              context,
              ScoreboardEntity(
                  id: '',
                  userId: scoreboardEntity.userId,
                  learningId: scoreboardEntity.learningId,
                  isAudio: scoreboardEntity.isAudio,
                  isQuestion: scoreboardEntity.isQuestion,
                  vocabularyId: scoreboardEntity.vocabularyId)));
    });
  }

  @override
  Future<Either<Failure, Success<List<ScoreboardEntity>?>>>
      getAllScoreboardByUser(
          BuildContext context, String userId, String learningId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getAllScoreboard(
              context, userId, learningId));
    });
  }

  @override
  Future<Either<Failure, Success<ScoreboardEntity?>>> getScoreboardByUser(
      BuildContext context, String userId, String writingPracticeId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getScoreboard(
              context, userId, writingPracticeId));
    });
  }

  @override
  Future<Either<Failure, Success<ScoreboardEntity?>>> updateScoreboardUser(
      BuildContext context, ScoreboardEntity scoreboardEntity) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateScoreboard(
              context, scoreboardEntity));
    });
  }
}
