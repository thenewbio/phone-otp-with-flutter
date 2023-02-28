import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
import "dart:async";

import '../model/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  DateTime _expiryDate = DateTime.now().subtract(Duration(days: 360));
  late String _userId = "";
  late Timer _authTimer;
  int luck = 0;

  bool get isAuth {
    return token != "";
  }

  String get token {
    // ignore: unnecessary_null_comparison
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != "") {
      return _token;
    }
    return "";
  }

  String apiKey = "AIzaSyB8q9sG8OLRk2AiQY9-R3pVYhiDxboj310";
  String email = "user@example.com";

  Future<void> sendOobCode(String email, String token) async {
    String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=AIzaSyB8q9sG8OLRk2AiQY9-R3pVYhiDxboj310';

    Map<String, String> body = {
      "requestType": "VERIFY_EMAIL",
      "email": email,
      "idToken": token
    };

    http.Response response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body));

    if (response.statusCode != 200) {
      print(response.statusCode);
      throw Exception('Failed to send OTP code');
    }
  }

  Future<void> _authenticate(
      String email, String password, String urlSegement) async {
    final url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegement?key=AIzaSyB8q9sG8OLRk2AiQY9-R3pVYhiDxboj310");

    try {
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));

      final responseData = json.decode(response.body);
      if (responseData["error"] != null) {
        throw HttpException(responseData['errors']["message"]);
      }

      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, "sendOobCode");
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, "signInWithPassword");
  }

  Future<void> logout() async {
    _token = "";
    _userId = "";
    _expiryDate.subtract(Duration(days: 360));
    notifyListeners();
  }
}
