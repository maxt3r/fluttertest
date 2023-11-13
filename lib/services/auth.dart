import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:support_ticket_app/services/api.dart';

class AuthManager {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final StreamController<bool> _authStateController =
      StreamController<bool>.broadcast();

  Stream<bool> get authState => _authStateController.stream;

  Future<void> saveAuth(String token, String url) async {
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'url', value: url);
    API.initialize(url, token);
    _authStateController.add(true);
  }

  Future<Map<String, String?>> getAuth() async {
    String? token = await _storage.read(key: 'token');
    String? url = await _storage.read(key: 'url');
    return {'token': token, 'url': url};
  }

  Future<bool> checkAuth() async {
    var auth = await getAuth();
    if (auth["token"] == null) {
      _authStateController.add(false);
      return false;
    }
    var url = Uri.parse('${auth["url"]}/api/Authorization');
    String basicAuth = 'Bearer ${auth["token"]}';

    try {
      var response = await http.get(url, headers: <String, String>{
        'authorization': basicAuth,
      });

      if (response.statusCode == 200) {
        API.initialize(auth["url"]!, auth["token"]!);
        _authStateController.add(true);
        return true;
      } else {
        if (kDebugMode) {
          print('Failed to load tickets');
        }
        _authStateController.add(false);
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Caught error: $e');
      }
      _authStateController.add(false);
      return false;
    }
  }

  Future<void> deleteCredentials() async {
    await _storage.deleteAll();
    _authStateController.add(false);
  }

  void dispose() {
    _authStateController.close();
  }
}
