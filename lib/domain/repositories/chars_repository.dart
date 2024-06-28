import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class CharsRepository {
  Future<Either<Failure, Success<CharsEntity?>>> getChars(
      BuildContext context, String charsId);
  Future<Either<Failure, Success<List<CharsEntity>?>>> getAllChars(
    BuildContext context,
  );
}
