import 'package:app_mobile/features/login/data/model/user_model.dart';
import 'package:app_mobile/features/login/domain/repositories/user_repository.dart';

class SaveUser {
  final UserRepository repository;

  SaveUser(this.repository);

  Future<UserModel> call({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) {
    return repository.saveUser(
      userName: userName,
      userEmail: userEmail,
      userPassword: userPassword,
    );
  }
}
