import 'package:ar_zoo_explorers/core/data/models/animal_category_model.dart';
import 'package:ar_zoo_explorers/core/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/animal_model.dart';

class FirebaseFirestoreSource {
  final CollectionReference<Map<String, dynamic>> _userModelCollectionRef =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference<Map<String, dynamic>> _animalModelCollectionRef =
      FirebaseFirestore.instance.collection('animal_models');

  final CollectionReference<Map<String, dynamic>> _animalCategoryCollectionRef =
      FirebaseFirestore.instance.collection('model_categories');

  Future<String> get generateUniqueAnimalModelId async =>
      _animalModelCollectionRef.add({}).then((value) => value.id);

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

  Future<UserModel?> updateUser({
    required String id,
    required String fullname,
    required String phone,
    required String avatarUrl,
    required String address,
    required String birth,
    required String provider,
  }) async {
    await _userModelCollectionRef.doc(id).update({
      'fullname': fullname,
      'phone': phone,
      'address': address,
      'birth': birth,
      'avatarUrl': avatarUrl,
      'provider': provider
    });
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
  Future<AnimalModel> getAnimal(String animalId) async {
    var document = await _animalModelCollectionRef.doc(animalId).get();
    return AnimalModel.fromMap(document.data()!);
  }

  // tạo một tài liệu mới trong Firestore
  Future<AnimalModel> createAnimal(AnimalModel animalModel) async {
    await _animalModelCollectionRef
        .doc(animalModel.id)
        .set(animalModel.toMap());
    return animalModel;
  }

  Future<AnimalModel> updateAnimal({
    required String id,
    required String title,
    required String icon,
    required String type,
    required String name,
    required String categoryId,
    required bool status,
  }) async {
    await _animalModelCollectionRef.doc(id).update({
      "title": title,
      "icon": icon,
      "type": type,
      "name": name,
      "categoryId": categoryId,
      "status": status
    });
    return getAnimal(id);
  }

  Future<List<AnimalModel>?> getAllAnimals() async {
    var querySnapshot = await _animalModelCollectionRef.get();
    if (querySnapshot != null) {
      List<AnimalModel> animals = querySnapshot.docs
          .map((doc) => AnimalModel.fromMap(doc.data()))
          .toList();
      return animals;
    } else {
      return null;
    }
  }

  //MODEL CATEGORY
  Future<AnimalCategoryModel?> getAnimalCategoryModel(String id) async {
    var document = await _animalCategoryCollectionRef.doc(id).get();
    if (document.exists && document.data() != null) {
      return AnimalCategoryModel.fromMap(document.data()!);
    } else {
      return null;
    }
  }

  Future<List<AnimalCategoryModel>?> getAllAnimalCategories() async {
    var querySnapshot = await _animalCategoryCollectionRef.get();
    if (querySnapshot != null) {
      List<AnimalCategoryModel> categories = querySnapshot.docs
          .map((doc) => AnimalCategoryModel.fromMap(doc.data()))
          .toList();
      return categories;
    } else {
      return null;
    }
  }
}

class FirebaseFirestoreLanguageKeys {
  static const String userDocumentNotExists = "userDocumentNotExists";
}
