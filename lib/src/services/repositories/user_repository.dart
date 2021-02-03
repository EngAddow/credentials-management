import 'package:flutter/foundation.dart';

class UserRepository {

  Future<String> signIn({
    @required String email,
    @required String password,
  }) async {
    return Future.delayed(
      Duration(seconds: 1),
      ()=>email+password,
    );

  }


  Future<String> signUp({
    @required String name,
    @required String email,
    @required String password,
  }) async {
  }

  Future<void> forgotPassword({
    @required String email,
  }) async {
  }
}