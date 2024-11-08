import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(LoginFailure(errMsg: 'No user found for that email.'));
      } else if (e.code == 'invalid-credential') {
        emit(LoginFailure(errMsg: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(LoginFailure(errMsg: e.toString()));
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(RegisterFailure(errMsg: 'The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errMsg: 'The account already exists for that email.'));
      } else if (e.code == 'invalid-email') {
        emit(RegisterFailure(errMsg: 'The email address is not valid.'));
      } else {
        emit(
            RegisterFailure(errMsg: e.message ?? 'An unknown error occurred.'));
      }
    } catch (e) {
      emit(RegisterFailure(errMsg: e.toString()));
    }
  }
}
