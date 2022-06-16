import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quotes_app/core/network/network_info.dart';

class NetworkInfoImp implements NetworkInfo {
  final InternetConnectionChecker _internetConnectionChecker;
  NetworkInfoImp(this._internetConnectionChecker);
  @override
  Future<bool> get isConnected async =>
      await _internetConnectionChecker.hasConnection;
}
