import 'package:chat_zxc/entities/user/profile.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data/profile_repository.dart';

part 'profile_controller_state.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  late final ProfileRepository _repo;
  late DateTime lastRefresh;

  static const Duration minIntervalBetweenRefresh = Duration(seconds: 15);

  @override
  Future<UserProfile> build() async {
    _repo = ref.watch(profileRepositoryProvider);
    lastRefresh = DateTime.now();
    ref.keepAlive();
    return _repo.getProfile();
  }

  void refresh() async {
    if (DateTime.now().difference(lastRefresh) < minIntervalBetweenRefresh) {
      return;
    }
    lastRefresh = DateTime.now();
    state = await AsyncValue.guard(() => _repo.getProfile(refresh: true));
  }
}
