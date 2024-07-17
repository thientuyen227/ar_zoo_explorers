import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/success.dart';
import '../entities/model_detail_entity.dart';

abstract class ModelDetailRepository {
  Future<Either<Failure, Success<ModelDetailEntity>>> getModelDetail(String id);

  Future<Either<Failure, Success<ModelDetailEntity>>> getModelDetailByModelId(
      String modelId);

  Future<Either<Failure, Success<List<ModelDetailEntity>>>>
      getAllModelDetails();

  Future<Either<Failure, Success<ModelDetailEntity>>> updateViewModelDetail(
      {required String id, required int views});
}
