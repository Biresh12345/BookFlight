import 'package:app_mobile/features/login/data/datasources/user_local_datasource.dart';
import 'package:app_mobile/features/login/data/model/user_model.dart';
import 'package:app_mobile/features/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final UserLocalDatasource datasource;
  UserRepositoryImpl(this.datasource);
  @override
  Future<List<UserModel>> getUsers() async {
    return await datasource.getUser();
  }
}
