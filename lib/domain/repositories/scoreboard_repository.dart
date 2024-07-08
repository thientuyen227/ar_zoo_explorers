import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class ScoreboardRepository {
  Future<Either<Failure, Success<ScoreboardEntity?>>> getScoreboardByUser(
      BuildContext context, String userId, String vocabularyId);
  Future<Either<Failure, Success<List<ScoreboardEntity>?>>>
      getAllScoreboardByUser(
          BuildContext context, String userId, String learningId);
  Future<Either<Failure, Success<ScoreboardEntity?>>> updateScoreboardUser(
      BuildContext context, ScoreboardEntity scoreboardEntity);
  Future<Either<Failure, Success<ScoreboardEntity?>>>
      createOrGetScoreboardByUser(
          BuildContext context, ScoreboardEntity scoreboardEntity);
}
