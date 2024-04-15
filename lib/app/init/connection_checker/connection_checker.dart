import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final internetConnectionProvider =
    NotifierProvider<InternetConnectionProvider, bool>(
        InternetConnectionProvider.new);

class InternetConnectionProvider extends Notifier<bool> {
  late final InternetConnection _internetConnection;

  @override
  bool build() {
    _internetConnection = InternetConnection();
    final stream = _internetConnection.onStatusChange.listen(_statusListener);

    ref.onDispose(() {
      stream.cancel();
    });
    return false;
  }

  void _statusListener(InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        state = true;
      case InternetStatus.disconnected:
        state = false;
    }
  }
}
