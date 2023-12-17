import '../../data/model/user_model.dart';
import '../param/signin_param.dart';
import '../repository/auth_repository.dart';

class SigninUseCase {
  final AuthRepository repository;

  SigninUseCase({required this.repository});

  @override
  Future<UserModel?> call(SigninParam param) async{
    UserModel? user =  await repository.signInWithEmailAndPassword(param);
    return user;
  }
}