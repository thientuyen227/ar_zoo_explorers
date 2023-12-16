class UserEntity {
  final String id;
  final String avatarUrl;
  final String fullname;
  final String email;
  final String phone;
  final String address;
  final String birth;
  final String? provider;
  final String gender;
  final String role;
  final bool status;

  UserEntity(
      {required this.id,
      required this.avatarUrl,
      required this.fullname,
      required this.email,
      required this.phone,
      required this.address,
      required this.birth,
      required this.provider,
      required this.gender,
      required this.role,
      required this.status});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'address': address,
      'birth': birth,
      'avatarUrl': avatarUrl,
      'provider': provider,
      'gender': gender,
      'role': role,
      'status': status,
    };
  }
}
