import '../repository/auth_repository.dart';

class SignoutUseCase {
  final AuthRepository repository;

  SignoutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
