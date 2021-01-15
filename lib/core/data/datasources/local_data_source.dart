import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future get initialization;

  String get email;
  set email(String email);

  String get name;

  String get token;
  set token(String token);
  Future<bool> deleteToken();
}

class LocalDataSourceImpl implements LocalDataSource {
  SharedPreferences _storage; // = await SharedPreferences.getInstance();
  @override
  Future get initialization => this._init();

  Future _init() async {
    this._storage = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> deleteToken() {
    return _storage.remove("token");
  }

  @override
  String get email => _storage.getString("email") ?? "";

  @override
  set email(String email) {
    _storage.setString("email", email);
  }

  @override
  String get token => _storage.getString("token") ?? "";

  @override
  set token(String token) {
    _storage.setString("token", token);
  }

  @override
  String get name => _storage.getString("name") ?? "";
}
