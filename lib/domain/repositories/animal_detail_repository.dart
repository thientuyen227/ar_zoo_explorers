import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/success.dart';
import '../entities/animal_detail_entity.dart';

abstract class AnimalDetailRepository {
  Future<Either<Failure, Success<AnimalDetailEntity>>> getAnimalDetailModel(
      String id);

  Future<Either<Failure, Success<AnimalDetailEntity>>>
      getAnimalDetailModelByModelId(String modelId);

  Future<Either<Failure, Success<List<AnimalDetailEntity>>>>
      getAllAnimalDetails();

  Future<Either<Failure, Success<AnimalDetailEntity>>> updateViewAnimalDetail(
      {required String id, required int views});
}
