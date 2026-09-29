import 'package:app_mobile/features/login/data/model/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
}
