import '../../data/model/user_model.dart';
import '../repository/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<UserModel?> call() async {
    return await repository.getCurrentUser();
  }
}
