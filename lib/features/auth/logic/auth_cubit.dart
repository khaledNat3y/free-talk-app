import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_talk_app/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    // Wait for 5 seconds, just for demo
    await Future.delayed(const Duration(seconds: 5));

    // successful login
    emit(AuthSuccess("Login Success"));

    // TODO: When you have a real API Service, replace with actual API call
    // try {
    //   final response = await authRepo.signInWithEmailAndPassword(
    //     loginRequestBody: LoginRequestBody(email: email, password: password),
    //   );
    //   emit(AuthSuccess("Login Success"));
    // } catch (e) {
    //   emit(AuthError(e.toString()));
    // }
  }

  Future<void> register(String userName, String email, String password) async {
    emit(AuthLoading());

    // Wait for 5 seconds (simulate API call)
    await Future.delayed(const Duration(seconds: 5));

    // Simulate successful registration
    emit(AuthSuccess("Register Success"));

    // TODO: When you have a real API Service, replace with actual API call
    // try {
    //   final response = await authRepo.createUserWithEmailAndPassword(
    //     userName: userName,
    //     emailAddress: email,
    //     password: password,
    //   );
    //   emit(AuthSuccess("Register Success"));
    // } catch (e) {
    //   emit(AuthError(e.toString()));
    // }
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    // TODO: Call logout endpoint if you have.
    // try {
    //   await authRepo.signOut();
    //   emit(AuthInitial());
    // } catch (e) {
    //   emit(AuthError(e.toString()));
    // }
  }
}