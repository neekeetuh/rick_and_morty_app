import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  static const String darkModeKey = 'dark_mode';

  RemoteConfigService({FirebaseRemoteConfig? remoteConfig})
      : _remoteConfig = remoteConfig ?? FirebaseRemoteConfig.instance;

  bool get isDarkModeEnabled => _remoteConfig.getBool(darkModeKey);

  Future<void> initialize() async {
    await _remoteConfig.setDefaults({
      darkModeKey: false,
    });

    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    await _remoteConfig.fetchAndActivate();
  }
}
