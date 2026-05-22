enum UserRole { reseller, admin }

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String avatar;
  final UserRole role;
  bool approved;
  bool blocked;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.role,
    this.approved = true,
    this.blocked = false,
  });
}
