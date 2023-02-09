import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../models/exceptions.dart';
import '../configuration.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<http.Response> _auth(String email, String password, String action) async {
    try {
      final response = await http.post(Config.getFirebaseAuthUri(action), body: json.encode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }));
      final jsonResp = json.decode(response.body);
      if (jsonResp['error'] != null) {
        throw HttpException(message: jsonResp['error']['message']);
      }
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signUp(String email, String password) async {
    final response = await _auth(email, password, 'accounts:signUp');
    final jsonResp = json.decode(response.body);
    _setAuthData(jsonResp);
    print('Sign In successful for ${jsonResp['email']}');
    notifyListeners();
  }

  Future<void> logIn(String email, String password) async {
    final response = await _auth(email, password, 'accounts:signInWithPassword');
    final jsonResp = json.decode(response.body);
    _setAuthData(jsonResp);
    print('Sign Up successful for ${jsonResp['email']}');
    notifyListeners();
  }

  void _setAuthData(dynamic jsonResp) {
    _token = jsonResp['idToken'];
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(jsonResp['expiresIn'])));
    _userId = jsonResp['localId'];
  }

  bool get isAuthenticated {
    return token != null;
  }

  String? get token {
    if (_token != null && _expiryDate != null && DateTime.now().isBefore(_expiryDate!)) {
      return _token;
    } else {
      return null;
    }
  }

  String? get userId {
    return _userId;
  }
}