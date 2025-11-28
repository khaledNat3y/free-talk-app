
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:free_talk_app/core/helpers/logger.dart';

import '../helpers/shared_pref_helper.dart';

class FirebaseService {
  Future<Either<String, String>> createUserWithEmailAndPassword({
    required String userName,
    required String emailAddress,
    required String password,
  }) async {
    try {
      Logger.debug("debug in try block");
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      final firestore = FirebaseFirestore.instance;
      final user = firestore.collection('users').doc(credential.user!.uid);
      await user.set({'userName': userName,'email': emailAddress, 'uid': credential.user!.uid});
      return const Right("Account Created Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger.debug('The password provided is too weak.');
        return const Left("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        Logger.debug('The account already exists for that email.');
        return const Left("The account already exists for that email.");
      }
    } catch (e) {
      Logger.debug(e.toString());
      return Left("$e");
    }
    return const Left("Something went wrong");
  }

  Future<Either<String, String>> signInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      /// Get user name and email to save in shared preferences
      final user = FirebaseAuth.instance.currentUser;
      if(user != null) {
        final docSnapshot = await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
        if (docSnapshot.exists) {
            SharedPrefHelper.setData("userName", docSnapshot.data()?['userName'] ?? 'No Name');
            SharedPrefHelper.setData("userEmail", docSnapshot.data()?['email'] ?? 'No Email');
        }
      }

      Logger.debug("Signed In Successfully");
      return const Right("Signed In Successfully");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger.debug('No user found for that email.');
        return const Left("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        Logger.debug('Wrong password provided for that user.');
        return const Left("Wrong password provided for that user.");
      }
    }catch (e) {
      Logger.debug(e.toString());
      return Left("$e");
    }
    return const Left("Something went wrong");
  }

  Future<Either<String, String>> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right("Signed Out Successfully");
    }catch(e) {
      Logger.debug(e.toString());
      return Left("$e");
    }
  }
}
