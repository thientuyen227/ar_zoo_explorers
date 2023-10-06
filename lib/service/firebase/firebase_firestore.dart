import 'package:cloud_firestore/cloud_firestore.dart';

class ModelAnimalCollection {
  CollectionReference<Map<String, dynamic>> animalModels =
      FirebaseFirestore.instance.collection('animal_models');
  Future<List<Map<String, dynamic>>> list() async {
    try {
      return animalModels.get().then((value) {
        return List<Map<String, dynamic>>.from(value.docs.map((e) => e.data()));
      });
    } catch (e) {
      rethrow;
    }
  }
}
