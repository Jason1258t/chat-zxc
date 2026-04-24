import 'package:chat_zxc/entities/user/profile.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileStreamData {
  final BehaviorSubject<UserProfile> stream;
  DateTime _lastWatch;

  static const lifetime = Duration(minutes: 2);

  bool get isExpired => DateTime.now().difference(_lastWatch) > lifetime;

  void watch() => _lastWatch = DateTime.now();

  UserProfileStreamData(this.stream) : _lastWatch = DateTime.now();
}

abstract class UsersRepository {
  Future<BehaviorSubject<UserProfile>> watchUser(String uid);

  Future<UserProfile> getUser(String uid);

  Future<List<UserProfile>> getUsersList(List<String> uids);

  Future<UserProfile> _loadUser(String uid);

  Future<List<UserProfile>> _loadUsersList(List<String> uids);

  Future<void> _loadCachedUsersData(List<String> uids);

  Future<void> _clearCache(String uid);

  Future<void> _clearOldCache();

  Future<void> _saveUsersData();
}
