import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/animal_model.dart';

class FirebaseFirestoreSource {
  final CollectionReference<Map<String, dynamic>> _animalModelCollectionRef =
      FirebaseFirestore.instance.collection('animal_models');
  Future<String> get generateUniqueAnimalModelId async =>
      _animalModelCollectionRef.add({}).then((value) => value.id);

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
    required String link,
    required String name,
  }) async {
    await _animalModelCollectionRef
        .doc(id)
        .update({"title": title, "icon": icon, "link": link, "name": name});
    return getAnimal(id);
  }
}

class FirebaseFirestoreLanguageKeys {
  static const String userDocumentNotExists = "userDocumentNotExists";
}
