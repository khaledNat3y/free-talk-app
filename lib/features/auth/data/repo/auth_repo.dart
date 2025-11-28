import 'package:dartz/dartz.dart';
import 'package:free_talk_app/core/services/firebase_service.dart';

class AuthRepo {
  final FirebaseService firebaseService;

  AuthRepo({required this.firebaseService});

  Future<Either<String, String>> createUserWithEmailAndPassword({required String userName, required String emailAddress, required String password}) async{
    return await firebaseService.createUserWithEmailAndPassword(userName : userName, emailAddress: emailAddress, password: password);
  }

  Future<Either<String, String>> signInWithEmailAndPassword({required String emailAddress, required String password}) async{
    return await firebaseService.signInWithEmailAndPassword(emailAddress: emailAddress, password: password);
  }

  Future<Either<String, String>> signOut() async{
    return await firebaseService.signOut();
  }

}