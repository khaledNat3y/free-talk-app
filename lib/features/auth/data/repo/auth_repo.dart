import '../models/login_request_body.dart';

class AuthRepo {
  // create object of API service class to access its functions here
  AuthRepo();

  Future createUserWithEmailAndPassword({required String userName, required String emailAddress, required String password}) async{

  }

  Future<dynamic> signInWithEmailAndPassword({required LoginRequestBody loginRequestBody}) async{

  }

  Future<dynamic> signOut() async{
    // return await firebaseService.signOut();
  }

}