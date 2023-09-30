import 'package:cloud_firestore/cloud_firestore.dart';

class ModelAnimalCollection {
  CollectionReference<Map<String, dynamic>> modelAnimal =
      FirebaseFirestore.instance.collection('models');
  Future<List<Map<String, dynamic>>> list() async {
    try {
      return modelAnimal.get().then((value) {
        return List<Map<String, dynamic>>.from(value.docs.map((e) => e.data()));
      });
    } catch (e) {
      rethrow;
    }
  }
}
