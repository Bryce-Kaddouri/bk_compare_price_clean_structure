import 'package:bk_compare_price_mvc/src/features/auth/business/param/reset_password_param.dart';

import 'package:bk_compare_price_mvc/src/features/auth/business/param/signin_param.dart';

import 'package:bk_compare_price_mvc/src/features/auth/business/param/signup_param.dart';
import 'package:bk_compare_price_mvc/src/features/auth/data/datasource/auth_datasource.dart';

import 'package:bk_compare_price_mvc/src/features/auth/data/model/user_model.dart';

import '../../business/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<UserModel?> createUserWithEmailAndPassword(SignupParam param) async{
    return await dataSource.createUserWithEmailAndPassword(param);
  }

  @override
  Future<UserModel?> getCurrentUser() async{
    return await dataSource.getCurrentUser();
  }

  @override
  Future<void> sendPasswordResetEmail(ResetPasswordParam param) async{
    return await dataSource.sendPasswordResetEmail(param);

  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(SigninParam param) async{
    return await dataSource.signInWithEmailAndPassword(param);

  }

  @override
  Future<void> signOut() async{
    return await dataSource.signOut();
  }

}