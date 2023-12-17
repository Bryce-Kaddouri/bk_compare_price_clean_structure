import 'package:bk_compare_price_mvc/src/features/auth/business/param/reset_password_param.dart';

import '../repository/auth_repository.dart';

class SendResetPasswordUseCase{
  final AuthRepository repository;

  SendResetPasswordUseCase({required this.repository});

  @override
  Future<void> call(ResetPasswordParam param) async {
    return await repository.sendPasswordResetEmail(param);
  }
}
