import 'package:ar_zoo_explorers/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel extends UserEntity {
  UserModel(
      {required super.id,
      required super.fullname,
      required super.email,
      required super.phone,
      required super.address,
      required super.birth,
      required super.avatarUrl,
      required super.provider});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'address': address,
      'birth': birth,
      'avatarUrl': avatarUrl,
      'provider': provider
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'] ?? '',
        fullname: map['fullname'] ?? '',
        email: map['email'] ?? '',
        phone: map['phone'] ?? '',
        address: map['address'] ?? '',
        birth: map['birth'] ?? '',
        avatarUrl: map['avatarUrl'] ?? '',
        provider: map['provider'] ?? '');
  }
  factory UserModel.fromUserCredential(UserCredential userCredential,
      {String? fullname, String? phone, String? address, String? birth}) {
    return UserModel(
        id: userCredential.user!.uid,
        fullname: fullname ??
            userCredential.user!.displayName ??
            userCredential.user!.email ??
            "",
        email: userCredential.user!.email ?? "",
        phone: phone ?? "",
        address: address ?? "",
        birth: birth ?? "",
        avatarUrl: userCredential.user!.photoURL ?? "",
        provider: userCredential.credential?.providerId);
  }
}
