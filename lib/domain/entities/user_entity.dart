class UserEntity {
  final String id;
  final String avatarUrl;
  final String fullname;
  final String email;
  final String phone;
  final String address;
  final String birth;
  final String? provider;

  UserEntity({
    required this.id,
    required this.avatarUrl,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.address,
    required this.birth,
    required this.provider,
  });
}
