import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../../core/success.dart';
import '../entities/model_category_entity.dart';

abstract class ModelCategoryRepository {
  Future<Either<Failure, Success<ModelCategoryEntity>>> getModelCategory(
      String id);

  Future<Either<Failure, Success<List<ModelCategoryEntity>>>>
      getAllModelCategories();
}
