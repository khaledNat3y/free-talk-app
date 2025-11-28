import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_talk_app/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.signInWithEmailAndPassword(
      emailAddress: email,
      password: password,
    );
    result.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (successMessage) => emit(AuthSuccess(successMessage)),
    );
  }

  Future<void> register(String userName, String email, String password) async {
    emit(AuthLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      userName: userName,
      emailAddress: email,
      password: password,
    );
    result.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (successMessage) => emit(AuthSuccess(successMessage)),
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    final result = await authRepo.signOut();
    result.fold(
      (errorMessage) => emit(AuthError(errorMessage)),
      (successMessage) => emit(AuthSuccess(successMessage)),
    );
  }
}
