import 'package:bk_compare_price_mvc/src/features/auth/data/model/user_model.dart';

import '../param/signup_param.dart';
import '../repository/auth_repository.dart';

class SignupUsecase {
  final AuthRepository repository;

  SignupUsecase({required this.repository});

  Future<UserModel?> call(SignupParam params) async {
    return await repository.createUserWithEmailAndPassword(params);
  }
}