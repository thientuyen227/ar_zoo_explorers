import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/topic_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TopicRepository {
  Future<Either<Failure, Success<TopicEntity>>> getTopic(String id);

  Future<Either<Failure, Success<List<TopicEntity>>>> getAllTopics();
}
