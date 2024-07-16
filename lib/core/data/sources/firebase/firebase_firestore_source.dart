import 'package:ar_zoo_explorers/core/data/models/animal_category_model.dart';
import 'package:ar_zoo_explorers/core/data/models/story_model.dart';
import 'package:ar_zoo_explorers/core/data/models/story_topic_model.dart';
import 'package:ar_zoo_explorers/core/data/models/user_model.dart';
import 'package:ar_zoo_explorers/core/data/models/user_story_model.dart';
import 'package:ar_zoo_explorers/domain/entities/chars_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/learning_category_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/question_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/scoreboard_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/user_question_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/vocabulary_entity.dart';
import 'package:ar_zoo_explorers/domain/entities/writing_practice_user_entity.dart';
import 'package:ar_zoo_explorers/utils/connectivity_utils.dart';
import 'package:ar_zoo_explorers/utils/widget/internet_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/animal_detail_model.dart';
import '../../models/animal_model.dart';
import '../../models/user_animal_model.dart';

class FirebaseFirestoreSource {
  final CollectionReference<Map<String, dynamic>> _userModelCollectionRef =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference<Map<String, dynamic>> _animalModelCollectionRef =
      FirebaseFirestore.instance.collection('3D_models');

  final CollectionReference<Map<String, dynamic>> _animalCategoryCollectionRef =
      FirebaseFirestore.instance.collection('model_categories');

  final CollectionReference<Map<String, dynamic>> _animalDetailCollectionRef =
      FirebaseFirestore.instance.collection('model_details');

  final CollectionReference<Map<String, dynamic>> _userAnimalCollectionRef =
      FirebaseFirestore.instance.collection('user_models');

  final CollectionReference<Map<String, dynamic>> _storyTopicCollectionRef =
      FirebaseFirestore.instance.collection('story_topics');

  final CollectionReference<Map<String, dynamic>> _storyCollectionRef =
      FirebaseFirestore.instance.collection('stories');

  final CollectionReference<Map<String, dynamic>> _userStoryCollectionRef =
      FirebaseFirestore.instance.collection('user_story');
  final CollectionReference<Map<String, dynamic>> _charsColectionRef =
      FirebaseFirestore.instance.collection('chars');
  final CollectionReference<Map<String, dynamic>> _vocabularyColectionRef =
      FirebaseFirestore.instance.collection('vocabulary');
  final CollectionReference<Map<String, dynamic>> _learningColectionRef =
      FirebaseFirestore.instance.collection('learningcategory');
  final CollectionReference<Map<String, dynamic>> _questionColectionRef =
      FirebaseFirestore.instance.collection('question');
  final CollectionReference<Map<String, dynamic>>
      _writingPracticeUserColectionRef =
      FirebaseFirestore.instance.collection('writing_practice_user');
  final CollectionReference<Map<String, dynamic>> _scoreboardColectionRef =
      FirebaseFirestore.instance.collection('scoreboard');
  final CollectionReference<Map<String, dynamic>> _userQuestionColectionRef =
      FirebaseFirestore.instance.collection('user_question');

  Future<String> get generateUniqueAnimalModelId async =>
      _animalModelCollectionRef.add({}).then((value) => value.id);
  Future<String> get generateUniqueWritingPracticeUserEntityId async =>
      _writingPracticeUserColectionRef.add({}).then((value) => value.id);
  Future<String> get generateUniqueScoreboardEntityId async =>
      _scoreboardColectionRef.add({}).then((value) => value.id);
  Future<String> get generateUniqueUserQuestionId async =>
      _userQuestionColectionRef.add({}).then((value) => value.id);

  //User
  Future<UserModel?> getUser(String id) async {
    var document = await _userModelCollectionRef.doc(id).get();
    if (document.exists && document.data() != null) {
      return UserModel.fromMap(document.data()!);
    } else {
      return null;
    }
  }

  Future<UserModel> createUser(UserModel user) async {
    await _userModelCollectionRef.doc(user.id).set(user.toMap());
    return user;
  }

  Future<UserModel?> updateUser(
      {required String id,
      required String fullname,
      required String phone,
      required String avatarUrl,
      required String address,
      required String birth,
      required String provider,
      required String gender,
      required String role,
      required bool status}) async {
    await _userModelCollectionRef.doc(id).update({
      'fullname': fullname,
      'phone': phone,
      'address': address,
      'birth': birth,
      'avatarUrl': avatarUrl,
      'provider': provider,
      'gender': gender,
      'role': role,
      'status': status
    });
    return getUser(id);
  }

  Future<UserModel?> updateAvatar(
      {required String id, required String avatarUrl}) async {
    await _userModelCollectionRef.doc(id).update({'avatarUrl': avatarUrl});
    return getUser(id);
  }

  //đưa danh sách các đối tượng vào firebase
  Future<bool> importAnimalModelList(List<AnimalModel> list) async {
    for (var model in list) {
      _animalModelCollectionRef.doc(model.id).set(model.toMap());
    }
    return true;
  }

  //lấy thông tin về một động vật
  Future<AnimalModel?> getAnimal(String animalId) async {
    try {
      var document = await _animalModelCollectionRef.doc(animalId).get();
      if (document.exists && document.data() != null) {
        return AnimalModel.fromMap(document.data()!);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Get Story Model By Id = "$animalId" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  // tạo một tài liệu mới trong Firestore
  Future<AnimalModel> createAnimal(AnimalModel animalModel) async {
    await _animalModelCollectionRef
        .doc(animalModel.id)
        .set(animalModel.toMap());
    return animalModel;
  }

  Future<List<AnimalModel>?> getAllAnimals() async {
    var querySnapshot = await _animalModelCollectionRef.get();
    List<AnimalModel> animals = querySnapshot.docs
        .map((doc) => AnimalModel.fromMap(doc.data()))
        .toList();
    return animals;
  }

  //MODEL CATEGORY
  Future<AnimalCategoryModel?> getAnimalCategoryModel(String id) async {
    try {
      var document = await _animalCategoryCollectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return AnimalCategoryModel.fromMap(document.data()!);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Get Animal Category By Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<AnimalCategoryModel>?> getAllAnimalCategories() async {
    try {
      var querySnapshot = await _animalCategoryCollectionRef.get();
      List<AnimalCategoryModel> categories = querySnapshot.docs
          .map((doc) => AnimalCategoryModel.fromMap(doc.data()))
          .toList();
      return categories;
    } catch (e, stackTrace) {
      print('Get All Animal Categories Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  // ANIMAL DETAILS
  Future<AnimalDetailModel?> getAnimalDetailModel(String id) async {
    try {
      var document = await _animalDetailCollectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return AnimalDetailModel.fromMap(document.data()!);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Get Animal Detail By Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<AnimalDetailModel>?> getAllAnimalDetails() async {
    try {
      var querySnapshot = await _animalDetailCollectionRef.get();
      List<AnimalDetailModel> modelDetails = querySnapshot.docs
          .map((doc) => AnimalDetailModel.fromMap(doc.data()))
          .toList();
      return modelDetails;
    } catch (e, stackTrace) {
      print('Get Animal Details Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<AnimalDetailModel?> getAnimalDetailModelByModelId(
      String modelId) async {
    try {
      var querySnapshot = await _animalDetailCollectionRef
          .where('modelId', isEqualTo: modelId)
          .get();
      List<AnimalDetailModel> modelDetails = querySnapshot.docs
          .map((doc) => AnimalDetailModel.fromMap(doc.data()))
          .toList();
      return modelDetails.first;
    } catch (e, stackTrace) {
      print('Get Animal Detail By And Model Id = "$modelId" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<AnimalDetailModel?> updateViewsAnimalDetail({
    required String id,
    required int views,
  }) async {
    try {
      await _animalDetailCollectionRef.doc(id).update({
        "views": views,
      });
      return getAnimalDetailModel(id);
    } catch (e, stackTrace) {
      print('Update Views Of Animal Detail Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  // USER_ANIMAL
  Future<UserAnimalModel?> createUserAnimal(UserAnimalModel userAnimal) async {
    try {
      DocumentReference documentReference = await _userAnimalCollectionRef.add({
        'userId': userAnimal.userId,
        'modelId': userAnimal.modelId,
        'isLoved': userAnimal.isLoved,
        'id': ''
      });
      String newDocumentId = documentReference.id;
      userAnimal.id = newDocumentId;
      //print("New ID $newDocumentId");
      await updateUserAnimal(
          id: userAnimal.id,
          userId: userAnimal.userId,
          modelId: userAnimal.modelId,
          isLoved: userAnimal.isLoved);
      return userAnimal;
    } catch (e, stackTrace) {
      print('Create User Animal Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserAnimalModel?> getUserAnimal(String id) async {
    try {
      var document = await _userModelCollectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return UserAnimalModel.fromMap(document.data()!);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Get User Animal Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserAnimalModel?> updateUserAnimal(
      {required String id,
      required String userId,
      required String modelId,
      required bool isLoved}) async {
    try {
      await _userAnimalCollectionRef.doc(id).update(
          {'id': id, 'userId': userId, 'modelId': modelId, 'isLoved': isLoved});
      return getUserAnimal(id);
    } catch (e, stackTrace) {
      print('Update User Animal Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserAnimalModel?> getUserAnimalByUserIdAndModelId(
      String userId, String modelId) async {
    try {
      var querySnapshot = await _userAnimalCollectionRef
          .where('userId', isEqualTo: userId)
          .where('modelId', isEqualTo: modelId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        UserAnimalModel userAnimal =
            UserAnimalModel.fromMap(querySnapshot.docs.first.data());
        return userAnimal;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print(
          'Get User Animal By User Id = "$userId" And Model Id = "$modelId" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<bool?> getUserAnimalIsLoved(String userId, String modelId) async {
    try {
      var userAnimal = await getUserAnimalByUserIdAndModelId(userId, modelId);
      if (userAnimal != null) {
        return userAnimal.isLoved;
      } else {
        Future<UserAnimalModel?> tmpUserAnimal = createUserAnimal(
            UserAnimalModel(
                id: '', userId: userId, modelId: modelId, isLoved: false));
        return false;
      }
    } catch (e, stackTrace) {
      print(
          'Get User Animal Is Loved By User Id = "$userId" And Model Id = "$modelId" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  //Story Topics
  Future<StoryTopicModel?> getStoryTopicModel(String id) async {
    try {
      var document = await _storyTopicCollectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return StoryTopicModel.fromMap(document.data()!);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Get Story Topic By Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<StoryTopicModel>?> getAllStoryTopicModels() async {
    try {
      var querySnapshot = await _storyTopicCollectionRef.get();
      List<StoryTopicModel> topics = querySnapshot.docs
          .map((doc) => StoryTopicModel.fromMap(doc.data()))
          .toList();
      return topics;
    } catch (e, stackTrace) {
      print('Get All Story Topics Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  //Story
  Future<StoryModel?> getStoryModel(String id) async {
    try {
      var document = await _storyCollectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return StoryModel.fromMap(document.data()!);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Get Story Model By Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<StoryModel>?> getAllStoryModels() async {
    try {
      var querySnapshot = await _storyCollectionRef.get();
      List<StoryModel> stories = querySnapshot.docs
          .map((doc) => StoryModel.fromMap(doc.data()))
          .toList();
      if (querySnapshot.docs.isNotEmpty) {
        return stories;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      print('Get All Story Models: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<StoryModel>?> getAllStoryModelsByReleaseDate(bool isDec) async {
    try {
      var querySnapshot = await _storyCollectionRef
          .orderBy('releaseDate', descending: isDec)
          .get();
      List<StoryModel> stories = querySnapshot.docs
          .map((doc) => StoryModel.fromMap(doc.data()))
          .toList();
      // print(stories.length);
      if (querySnapshot.docs.isNotEmpty) {
        return stories;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      print('Get All Story Models By Release Date Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<StoryModel>?> getStoryModelsByAnimalModelId(
      String modelId) async {
    try {
      var querySnapshot = await _storyCollectionRef
          .where('modelId', arrayContains: modelId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        List<StoryModel> stories = querySnapshot.docs
            .map((doc) => StoryModel.fromMap(doc.data()))
            .toList();
        return stories;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      print('Get Story Models By Animal ModelId Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<StoryModel>?> getStoryModelsByStoryTopicId(String topicId) async {
    try {
      var querySnapshot = await _storyCollectionRef
          .where('topicId', arrayContains: topicId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        List<StoryModel> stories = querySnapshot.docs
            .map((doc) => StoryModel.fromMap(doc.data()))
            .toList();

        return stories;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      print('Get Story Models By Story TopicId Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<StoryModel?> createStory(StoryModel storyModel) async {
    try {
      DocumentReference documentReference = await _storyCollectionRef.add({
        'id': '',
        'author': storyModel.author,
        'avatar': storyModel.avatar,
        'content': storyModel.content,
        'duration': storyModel.duration,
        'listenCount': storyModel.listenCount,
        'modelId': storyModel.modelId,
        'name': storyModel.name,
        'overView': storyModel.overView,
        'reader': storyModel.reader,
        'releaseDate': storyModel.releaseDate,
        'sourceUrl': storyModel.sourceUrl,
        'status': storyModel.status,
        'title': storyModel.title,
        'topicId': storyModel.topicId
      });
      String newDocumentId = documentReference.id;
      storyModel.id = newDocumentId;
      //print("New ID $newDocumentId");
      await updateStory(
          id: storyModel.id,
          author: storyModel.author,
          avatar: storyModel.avatar,
          content: storyModel.content,
          duration: storyModel.duration,
          listenCount: storyModel.listenCount,
          modelId: storyModel.modelId,
          name: storyModel.name,
          overView: storyModel.overView,
          reader: storyModel.reader,
          releaseDate: storyModel.releaseDate,
          sourceUrl: storyModel.sourceUrl,
          status: storyModel.status,
          title: storyModel.title,
          topicId: storyModel.topicId);
      return storyModel;
    } catch (e, stackTrace) {
      print('Create Story Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<StoryModel?> updateStory(
      {required String id,
      required String author,
      required String avatar,
      required String content,
      required int duration,
      required int listenCount,
      required List<String> modelId,
      required String name,
      required String overView,
      required String reader,
      required Timestamp releaseDate,
      required String sourceUrl,
      required bool status,
      required String title,
      required List<String> topicId}) async {
    try {
      await _storyCollectionRef.doc(id).update({
        'author': author,
        'avatar': avatar,
        'content': content,
        'duration': duration,
        'listenCount': listenCount,
        'modelId': modelId,
        'name': name,
        'overView': overView,
        'reader': reader,
        'releaseDate': releaseDate,
        'sourceUrl': sourceUrl,
        'status': status,
        'title': title,
        'topicId': topicId
      });
      return getStoryModel(id);
    } catch (e, stackTrace) {
      print('Update Story Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<StoryModel?> updateListenCountStory(
      {required String id, required int listenCount}) async {
    try {
      await _storyCollectionRef
          .doc(id)
          .update({'listenCount': listenCount + 1});
      return getStoryModel(id);
    } catch (e, stackTrace) {
      print('Update Listen Count Story Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  // USER_STORY
  Future<UserStoryModel?> createOrGetUserStory(UserStoryModel userStory) async {
    try {
      UserStoryModel? checker = await getUserStoryByUserIdAndStoryId(
          userStory.userId, userStory.storyId);
      if (checker == null) {
        DocumentReference documentReference =
            await _userStoryCollectionRef.add({
          'id': '',
          'storyId': userStory.storyId,
          'userId': userStory.userId,
          'pausedTime': userStory.pausedTime,
          'isCompleted': userStory.isCompleted,
          'isFavorited': userStory.isFavorited,
          'createdAt': userStory.createdAt,
          'updatedAt': userStory.updatedAt,
          'status': userStory.status,
        });
        String newDocumentId = documentReference.id;
        userStory.id = newDocumentId;
        //print("New ID $newDocumentId");
        await updateUserStory(
          id: userStory.id,
          userId: userStory.userId,
          storyId: userStory.storyId,
          pausedTime: userStory.pausedTime,
          isCompleted: userStory.isCompleted,
          isFavorited: userStory.isFavorited,
          createdAt: userStory.createdAt,
          updatedAt: userStory.updatedAt,
          status: userStory.status,
        );
        return userStory;
      } else {
        return checker;
      }
    } catch (e, stackTrace) {
      print('Create User Story Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserStoryModel?> updateUserStory(
      {required String id,
      required String storyId,
      required String userId,
      required int pausedTime,
      required bool isCompleted,
      required bool isFavorited,
      required Timestamp createdAt,
      required Timestamp updatedAt,
      required bool status}) async {
    try {
      await _userStoryCollectionRef.doc(id).update({
        'id': id,
        'storyId': storyId,
        'userId': userId,
        'pausedTime': pausedTime,
        'isCompleted': isCompleted,
        'isFavorited': isFavorited,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'status': status,
      });
      return getUserStory(id);
    } catch (e, stackTrace) {
      print('Update User Story Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserStoryModel?> updateUserStoryWithIsFavorited({
    required String id,
    required bool isFavorited,
  }) async {
    try {
      await _userStoryCollectionRef.doc(id).update({
        'id': id,
        'isFavorited': isFavorited,
      });
      return getUserStory(id);
    } catch (e, stackTrace) {
      print('Update Is Favorited Of User Story Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserStoryModel?> updateUserStoryWithIsCompleted({
    required String id,
    required bool isCompleted,
    required Timestamp updatedAt,
  }) async {
    try {
      await _userStoryCollectionRef.doc(id).update({
        'id': id,
        'isCompleted': isCompleted,
        'updatedAt': updatedAt,
      });
      return getUserStory(id);
    } catch (e, stackTrace) {
      print('Update Is Completed Of User Story Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserStoryModel?> updateUserStoryWithPausedTime(
      {required String id,
      required int pausedTime,
      required Timestamp updatedAt}) async {
    try {
      await _userStoryCollectionRef.doc(id).update({
        'id': id,
        'pausedTime': pausedTime,
        'updatedAt': updatedAt,
      });
      return getUserStory(id);
    } catch (e, stackTrace) {
      print('Update Paused Time Of User Story Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserStoryModel?> getUserStory(String id) async {
    try {
      var document = await _userStoryCollectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return UserStoryModel.fromMap(document.data()!);
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print('Get User Story Id = "$id" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<UserStoryModel>?> getUserStoryByUserIdAndIsFavorited(
      String userId, bool isFavorited) async {
    try {
      var querySnapshot = await _userStoryCollectionRef
          .where('userId', isEqualTo: userId)
          .where('isFavorited', isEqualTo: isFavorited)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        List<UserStoryModel> userStory = querySnapshot.docs
            .map((doc) => UserStoryModel.fromMap(doc.data()))
            .toList();
        return userStory;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      print(
          'Get User Animal By User Id = "$userId" And isFavorited = "$isFavorited" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserStoryModel?> getUserStoryByUserIdAndStoryId(
      String userId, String storyId) async {
    try {
      var querySnapshot = await _userStoryCollectionRef
          .where('userId', isEqualTo: userId)
          .where('storyId', isEqualTo: storyId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        UserStoryModel userStory = querySnapshot.docs
            .map((doc) => UserStoryModel.fromMap(doc.data()))
            .toList()
            .first;
        return userStory;
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      print(
          'Get User Animal By User Id = "$userId" And Story Id = "$storyId" Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<List<UserStoryModel>?> getUserStoryByUserId(String userId) async {
    try {
      var querySnapshot = await _userStoryCollectionRef
          .where('userId', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<UserStoryModel> userStory = querySnapshot.docs
            .map((doc) => UserStoryModel.fromMap(doc.data()))
            .toList();

        userStory.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

        return userStory;
      } else {
        return [];
      }
    } catch (e, stackTrace) {
      print('Get User Story By User Id = "$userId": $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  //Chars
  Future<CharsEntity?> getChars(BuildContext context, String id) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var document = await _charsColectionRef.doc(id).get();
        if (document.exists && document.data() != null) {
          return CharsEntity.fromMap(document.data()!);
        }
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
    return null;
  }

  Future<List<CharsEntity>?> getAllChars(
    BuildContext context,
  ) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var querySnapshot = await _charsColectionRef.get();
        List<CharsEntity> userAnimals = querySnapshot.docs
            .map((doc) => CharsEntity.fromMap(doc.data()))
            .toList();
        return userAnimals;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
    return null;
  }

  //Vocabulary
  Future<VocabularyEntity?> getVocabulary(
      BuildContext context, String id) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      var document = await _vocabularyColectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return VocabularyEntity.fromMap(document.data()!);
      } else {
        return null;
      }
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  Future<List<VocabularyEntity>?> getAllVocabulary(
    BuildContext context,
  ) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var querySnapshot = await _vocabularyColectionRef.get();
        List<VocabularyEntity> vocabularies = querySnapshot.docs
            .map((doc) => VocabularyEntity.fromMap(doc.data()))
            .toList();
        return vocabularies;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //LearningCategory
  Future<LearningCategoryEntity?> getLearningCategory(
      BuildContext context, String id) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      var document = await _learningColectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return LearningCategoryEntity.fromMap(document.data()!);
      } else {
        return null;
      }
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  Future<List<LearningCategoryEntity>?> getAllLearningCategory(
    BuildContext context,
  ) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var querySnapshot = await _learningColectionRef.get();
        List<LearningCategoryEntity> learning = querySnapshot.docs
            .map((doc) => LearningCategoryEntity.fromMap(doc.data()))
            .toList();
        return learning;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //Question
  Future<QuestionEntity?> getQuestion(BuildContext context, String id) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      var document = await _questionColectionRef.doc(id).get();
      if (document.exists && document.data() != null) {
        return QuestionEntity.fromMap(document.data()!);
      } else {
        return null;
      }
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  Future<List<QuestionEntity>?> getAllQuestion(
    BuildContext context,
  ) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var querySnapshot = await _questionColectionRef.get();
        List<QuestionEntity> questions = querySnapshot.docs
            .map((doc) => QuestionEntity.fromMap(doc.data()))
            .toList();
        return questions;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  //WritingPracticeUser
  Future<WritingPracticeUserEntity?> getWritingPracticeUser(
      BuildContext context, String userId, String writingPracticeId) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      var querySnapshot = await _writingPracticeUserColectionRef
          .where('userId', isEqualTo: userId)
          .where('writingPracticeId', isEqualTo: writingPracticeId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        WritingPracticeUserEntity writingPracticeUserEntity = querySnapshot.docs
            .map((doc) => WritingPracticeUserEntity.fromMap(doc.data()))
            .toList()
            .first;
        return writingPracticeUserEntity;
      } else {
        return null;
      }
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  Future<List<WritingPracticeUserEntity>?> getAllWritingPracticeUser(
      BuildContext context) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var querySnapshot = await _writingPracticeUserColectionRef.get();
        List<WritingPracticeUserEntity> writingPracticeUser = querySnapshot.docs
            .map((doc) => WritingPracticeUserEntity.fromMap(doc.data()))
            .toList();
        return writingPracticeUser;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<WritingPracticeUserEntity?> createOrGetWritingPracticeUser(
      BuildContext context,
      WritingPracticeUserEntity practiceWriteUserEntity) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        WritingPracticeUserEntity? checker = await getWritingPracticeUser(
            context,
            practiceWriteUserEntity.userId,
            practiceWriteUserEntity.writingPracticeId);
        if (checker == null) {
          DocumentReference documentReference =
              await _writingPracticeUserColectionRef.add({
            'id': '',
            'writingPracticeId': practiceWriteUserEntity.writingPracticeId,
            'userId': practiceWriteUserEntity.userId,
            'practicedImagePaths': practiceWriteUserEntity.practicedImagePaths
          });
          practiceWriteUserEntity.id = documentReference.id;
          await updateWritingPracticeUser(context, practiceWriteUserEntity);
          return practiceWriteUserEntity;
        } else {
          checker.practicedImagePaths =
              practiceWriteUserEntity.practicedImagePaths;
          return checker;
        }
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e, stackTrace) {
      print('Create User Story Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<WritingPracticeUserEntity?> updateWritingPracticeUser(
      BuildContext context,
      WritingPracticeUserEntity practiceWriteUserEntity) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      await _writingPracticeUserColectionRef
          .doc(practiceWriteUserEntity.id)
          .update({
        'id': practiceWriteUserEntity.id,
        'userId': practiceWriteUserEntity.userId,
        'writingPracticeId': practiceWriteUserEntity.writingPracticeId,
        'practicedImagePaths': practiceWriteUserEntity.practicedImagePaths
      });
      return getWritingPracticeUser(context, practiceWriteUserEntity.userId,
          practiceWriteUserEntity.writingPracticeId);
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  //Scoreboard
  Future<ScoreboardEntity?> getScoreboard(
      BuildContext context, String userId, String vocabularyId) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      var querySnapshot = await _scoreboardColectionRef
          .where('userId', isEqualTo: userId)
          .where('vocabularyId', isEqualTo: vocabularyId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        ScoreboardEntity scoreboardEntity = querySnapshot.docs
            .map((doc) => ScoreboardEntity.fromMap(doc.data()))
            .toList()
            .first;
        return scoreboardEntity;
      } else {
        return null;
      }
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  Future<List<ScoreboardEntity>?> getAllScoreboard(
      BuildContext context, String userId, String learningId) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var querySnapshot = await _scoreboardColectionRef
            .where('userId', isEqualTo: userId)
            .where('learningId', isEqualTo: learningId)
            .get();
        List<ScoreboardEntity> scoreboardEntity = querySnapshot.docs
            .map((doc) => ScoreboardEntity.fromMap(doc.data()))
            .toList();
        return scoreboardEntity;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ScoreboardEntity?> createOrGetScoreboard(
      BuildContext context, ScoreboardEntity scoreboardEntity) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        ScoreboardEntity? checker = await getScoreboard(
            context, scoreboardEntity.userId, scoreboardEntity.vocabularyId);
        if (checker == null) {
          DocumentReference documentReference =
              await _scoreboardColectionRef.add({
            'id': '',
            'userId': scoreboardEntity.userId,
            'learningId': scoreboardEntity.learningId,
            'vocabularyId': scoreboardEntity.vocabularyId,
            'isAudio': scoreboardEntity.isAudio,
            'isQuestion': scoreboardEntity.isQuestion,
          });
          ScoreboardEntity updatedScoreboardEntity = scoreboardEntity.copyWith(
            id: documentReference.id,
          );
          await updateScoreboard(context, updatedScoreboardEntity);
          return scoreboardEntity;
        } else {
          bool needsUpdate = false;
          if (scoreboardEntity.isAudio == true &&
              checker.isAudio != scoreboardEntity.isAudio) {
            checker = checker.copyWith(isAudio: scoreboardEntity.isAudio);
            needsUpdate = true;
          }
          if (scoreboardEntity.isQuestion == true &&
              checker.isQuestion != scoreboardEntity.isQuestion) {
            checker = checker.copyWith(isQuestion: scoreboardEntity.isQuestion);
            needsUpdate = true;
          }
          if (needsUpdate) {
            await updateScoreboard(context, checker);
          }
          return checker;
        }
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e, stackTrace) {
      print('Create User Story Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<ScoreboardEntity?> updateScoreboard(
      BuildContext context, ScoreboardEntity scoreboardEntity) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      await _scoreboardColectionRef.doc(scoreboardEntity.id).update({
        'id': scoreboardEntity.id,
        'userId': scoreboardEntity.userId,
        'learningId': scoreboardEntity.learningId,
        'vocabularyId': scoreboardEntity.vocabularyId,
        'isAudio': scoreboardEntity.isAudio,
        'isQuestion': scoreboardEntity.isQuestion,
      });
      return getScoreboard(
          context, scoreboardEntity.userId, scoreboardEntity.id);
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  //UserQuestion
  Future<UserQuestionEntity?> getQuestionByUser(
      BuildContext context, String userId, String learningId) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      var querySnapshot = await _userQuestionColectionRef
          .where('userId', isEqualTo: userId)
          .where('learningId', isEqualTo: learningId)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        UserQuestionEntity userQuestionEntity = querySnapshot.docs
            .map((doc) => UserQuestionEntity.fromMap(doc.data()))
            .toList()
            .first;
        return userQuestionEntity;
      } else {
        return null;
      }
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }

  Future<List<UserQuestionEntity>?> getAllQuestionByUser(
      BuildContext context) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        var querySnapshot = await _userQuestionColectionRef.get();
        List<UserQuestionEntity> userQuestionEntity = querySnapshot.docs
            .map((doc) => UserQuestionEntity.fromMap(doc.data()))
            .toList();
        return userQuestionEntity;
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserQuestionEntity?> createOrGetQuestionByUser(
      BuildContext context, UserQuestionEntity userQuestionEntity) async {
    try {
      bool isConnected = await ConnectivityUtils.checkInternetConnection();
      if (isConnected) {
        UserQuestionEntity? checker = await getQuestionByUser(
            context, userQuestionEntity.userId, userQuestionEntity.learningId);
        if (checker == null) {
          DocumentReference documentReference =
              await _userQuestionColectionRef.add({
            'id': '',
            'userId': userQuestionEntity.userId,
            'learningId': userQuestionEntity.learningId,
            'indexQuestion': userQuestionEntity.indexQuestion
          });
          UserQuestionEntity updatedUserQuestionEntity =
              userQuestionEntity.copyWith(
            id: documentReference.id,
          );
          await updateQuestionByUser(context, updatedUserQuestionEntity);
          return userQuestionEntity;
        } else {
          if (checker.indexQuestion != userQuestionEntity.indexQuestion) {
            checker = checker.copyWith(
                indexQuestion: userQuestionEntity.indexQuestion);
          }
          return checker;
        }
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return const InternetDialog();
            });
      }
    } catch (e, stackTrace) {
      print('Create User Story Failed: $e');
      FirebaseCrashlytics.instance.recordError(e, stackTrace);
    }
    return null;
  }

  Future<UserQuestionEntity?> updateQuestionByUser(
      BuildContext context, UserQuestionEntity userQuestionEntity) async {
    bool isConnected = await ConnectivityUtils.checkInternetConnection();
    if (isConnected) {
      await _userQuestionColectionRef.doc(userQuestionEntity.id).update({
        'id': userQuestionEntity.id,
        'userId': userQuestionEntity.userId,
        'learningId': userQuestionEntity.learningId,
        'indexQuestion': userQuestionEntity.indexQuestion
      });
      return getQuestionByUser(
          context, userQuestionEntity.userId, userQuestionEntity.learningId);
    } else {
      return showDialog(
          context: context,
          builder: (context) {
            return const InternetDialog();
          });
    }
  }
}

class FirebaseFirestoreLanguageKeys {
  static const String userDocumentNotExists = "userDocumentNotExists";
}
