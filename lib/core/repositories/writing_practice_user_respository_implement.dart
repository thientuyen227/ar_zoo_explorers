import 'package:ar_zoo_explorers/core/data/sources/firebase/firebase_firestore_source.dart';
import 'package:ar_zoo_explorers/core/failures.dart';
import 'package:ar_zoo_explorers/core/helpers/exception_handler.dart';
import 'package:ar_zoo_explorers/core/success.dart';
import 'package:ar_zoo_explorers/domain/entities/writing_practice_user_entity.dart';
import 'package:ar_zoo_explorers/domain/repositories/writing_practice_user_respository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WritingPracticeUserRepositoryImplement
    implements WritingPracticeUserRepository {
  final FirebaseFirestoreSource _firestoreSource = FirebaseFirestoreSource();

  @override
  Future<Either<Failure, Success<WritingPracticeUserEntity?>>>
      getWritingPracticeUser(
          BuildContext context, String userId, String writingPracticeId) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getWritingPracticeUser(
              context, userId, writingPracticeId));
    });
  }

  @override
  Future<Either<Failure, Success<List<WritingPracticeUserEntity>?>>>
      getAllWritingPracticeUser(BuildContext context) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.getAllWritingPracticeUser(context));
    });
  }

  @override
  Future<Either<Failure, Success<WritingPracticeUserEntity?>>>
      updateWritingPracticeUser(BuildContext context,
          WritingPracticeUserEntity writingPracticeUserEntity) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.updateWritingPracticeUser(
              context, writingPracticeUserEntity));
    });
  }

  @override
  Future<Either<Failure, Success<WritingPracticeUserEntity?>>>
      createOrGetWritingPractice(BuildContext context, String userId,
          WritingPracticeUserEntity writingPracticeUserEntity) {
    return ResponseHandler.processResponse(() async {
      return Success(
          data: await _firestoreSource.createOrGetWritingPracticeUser(
              context,
              WritingPracticeUserEntity(
                  id: '',
                  userId: writingPracticeUserEntity.userId,
                  writingPracticeId:
                      writingPracticeUserEntity.writingPracticeId,
                  practicedImagePaths:
                      writingPracticeUserEntity.practicedImagePaths)));
    });
  }

  @override
  Future<Either<Failure, Success<String>>> uploadImageToFirebase(
      BuildContext context, Uint8List imageBytes, String imageName) async {
    return ResponseHandler.processResponse(() async {
      String storagePath = 'writing_practice_images_users/$imageName.png';
      Reference storageReference =
          FirebaseStorage.instance.ref().child(storagePath);
      try {
        final existingFile = await storageReference.getDownloadURL();
        if (existingFile.isNotEmpty) {
          await storageReference.delete();
        }
      } catch (e) {
        print('File does not exist at $storagePath');
      }
      UploadTask uploadTask = storageReference.putData(imageBytes);
      TaskSnapshot snapshot = await uploadTask;
      String downloadURL = await snapshot.ref.getDownloadURL();
      downloadURL ??= "";
      return Success(data: downloadURL);
    });
  }
}
