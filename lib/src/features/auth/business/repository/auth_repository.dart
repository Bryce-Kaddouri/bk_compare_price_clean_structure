import 'package:bk_compare_price_mvc/src/features/auth/business/param/signin_param.dart';
import 'package:bk_compare_price_mvc/src/features/auth/business/param/signup_param.dart';
import 'package:bk_compare_price_mvc/src/features/auth/data/model/user_model.dart';

import '../param/reset_password_param.dart';

abstract class AuthRepository{
  Future<UserModel?> signInWithEmailAndPassword(SigninParam param);
  Future<UserModel?> createUserWithEmailAndPassword(SignupParam param);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
  Future<void> sendPasswordResetEmail(ResetPasswordParam param);

}