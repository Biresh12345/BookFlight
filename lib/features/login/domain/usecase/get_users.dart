import 'package:app_mobile/features/login/data/model/user_model.dart';
import 'package:app_mobile/features/login/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;
  GetUsers(this.repository);

  Future<List<UserModel>> call() async {
    return await repository.getUsers();
  }
}
