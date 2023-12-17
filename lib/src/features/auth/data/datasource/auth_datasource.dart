import 'package:bk_compare_price_mvc/src/core/component/dialog.dart';
import 'package:bk_compare_price_mvc/src/core/error/exception.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/param/reset_password_param.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/param/signin_param.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/param/signup_param.dart';
import 'package:bk_compare_price_mvc/src/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthDataSource{
  final FirebaseAuth auth;

  AuthDataSource({required this.auth});

  Future<UserModel?> signInWithEmailAndPassword(SigninParam param) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: param.email,
        password: param.password,
      );
      return UserModel.fromFirebase(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      DialogWidget.showErrorDialog(e.message!);
    }
  }

  Future<UserModel?> createUserWithEmailAndPassword(SignupParam param) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: param.email,
        password: param.password,
      );
      userCredential.user!.updateDisplayName(param.name);
      return UserModel.fromFirebase(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        return UserModel.fromFirebase(user);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<void> sendPasswordResetEmail(ResetPasswordParam param) async {
    try {
      await auth.sendPasswordResetEmail(email: param.email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Stream<UserModel?> get userStream {
    return auth.authStateChanges().map((user) => user != null ? UserModel.fromFirebase(user) : null);
  }

}