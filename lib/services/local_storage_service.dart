import 'package:get_storage/get_storage.dart';

class LocalStorageService {
  static const String onboardKey = 'hasSeenOnboarding';
  static const String rememberMeKey = 'rememberMe';
  static const String selectedRoleKey = 'selectedRole';
  static const String userEmailKey = 'userEmail';

  final GetStorage _storage = GetStorage();

  bool get hasSeenOnboarding => _storage.read<bool>(onboardKey) ?? false;
  bool get rememberMe => _storage.read<bool>(rememberMeKey) ?? false;
  String get userEmail => _storage.read<String>(userEmailKey) ?? '';
  String get selectedRole => _storage.read<String>(selectedRoleKey) ?? 'reseller';

  Future<void> saveOnboarding() async {
    await _storage.write(onboardKey, true);
  }

  Future<void> saveRememberMe(bool value) async {
    await _storage.write(rememberMeKey, value);
  }

  Future<void> saveSelectedRole(String role) async {
    await _storage.write(selectedRoleKey, role);
  }

  Future<void> saveUserEmail(String email) async {
    await _storage.write(userEmailKey, email);
  }

  Future<void> clearSession() async {
    await _storage.remove(userEmailKey);
    await _storage.remove(rememberMeKey);
    await _storage.remove(selectedRoleKey);
  }
}
