import 'dart:ui';

import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user-model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// !------------ ------------------------------------------------------------------
// ! create a Interface class which will implemented In Future   !!!!!!!!!!!!!!!!!
// !------------ ------------------------------------------------------------------
abstract interface class AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSource(this.supabaseClient);
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  Future<UserModel> loginWithEmailPassword({
    // required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}
// !------------ ------------------------------------------------------------------
// ! create a generic class which will implement this above definitions
// !------------ ------------------------------------------------------------------

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);
//?  ------------ ------------------------------------------------------------------
//? fetch data from databaas to get latest info about user
//? ------------ ------------------------------------------------------------------
  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

// !------------ ------------------------------------------------------------------
// !      loginWithEmailPassword        !!!!!!!!!!
// !------------ ------------------------------------------------------------------

// !
  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
      );

      if (response.user == null) {
        throw const ServerException("User is nulll");
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

// !------------ ------------------------------------------------------------------
// !      signUpWithEmailPassword                                        !!!!!!!!!!
// !------------ ------------------------------------------------------------------

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
          password: password,
          email: email,
          //! data proprty to store additional data of user
          data: {
            // key  value
            'name': name,
          });

      if (response.user == null) {
        throw const ServerException("User is nulll");
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: currentUserSession!.user.email);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if (currentUserSession != null) {
        // only one data

        final userData = await supabaseClient.from('profiles').select().eq(
              'id',
              currentUserSession!.user.id,
            );

        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
