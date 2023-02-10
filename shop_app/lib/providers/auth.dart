import 'dart:convert';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/exceptions.dart';
import '../configuration.dart';

class Auth with ChangeNotifier {
  static const USER_DATA_KEY = 'userData';
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _logoutTimer;

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
    await _setAuthData(jsonResp);
    print('Sign In successful for ${jsonResp['email']}');
    notifyListeners();
  }

  Future<void> logIn(String email, String password) async {
    final response = await _auth(email, password, 'accounts:signInWithPassword');
    final jsonResp = json.decode(response.body);
    await _setAuthData(jsonResp);
    print('Sign Up successful for ${jsonResp['email']}');
    notifyListeners();
  }

  Future<void> _setAuthData(dynamic jsonResp) async {
    _token = jsonResp['idToken'];
    _expiryDate = DateTime.now().add(Duration(seconds: int.parse(jsonResp['expiresIn'])));
    _userId = jsonResp['localId'];
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'userId': userId,
      'token': _token,
      'expiryDate': _expiryDate!.toIso8601String(),
    });
    await prefs.setString(USER_DATA_KEY, userData);
    _setupAutoLogout();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey(USER_DATA_KEY)) {
      return false;
    } else {
      final userData = prefs.getString(USER_DATA_KEY);
      try {
        final jsonData = json.decode(userData!);
        final expiryDate = DateTime.parse(jsonData['expiryDate']);
        if (expiryDate.isBefore(DateTime.now())) {
          // invalid token
          return false;
        } else {
          _token = jsonData['token'];
          _expiryDate = expiryDate;
          _userId = jsonData['userId'];
          _setupAutoLogout();
          notifyListeners();
          return true;
        }
      } catch(error) {
        print('Unable to load local user data: ${error}');
        print('clearing local storage...');
        await prefs.remove(USER_DATA_KEY);
        return false;
      }
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    _logoutTimer!.cancel();
    _logoutTimer = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(USER_DATA_KEY);
    notifyListeners();
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

  void _setupAutoLogout() {
    if (_logoutTimer != null) {
      _logoutTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}