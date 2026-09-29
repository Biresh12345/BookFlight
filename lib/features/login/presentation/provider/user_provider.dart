import 'dart:async';

import 'package:app_mobile/features/login/data/datasources/user_local_datasource.dart';
import 'package:app_mobile/features/login/data/model/user_model.dart';
import 'package:app_mobile/features/login/data/repositories/user_repository_impl.dart';
import 'package:app_mobile/features/login/domain/usecase/get_users.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userLocalDataSourceProvider = Provider<UserLocalDatasource>((ref) {
  return UserLocalDatasource();
});

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl(ref.read(userLocalDataSourceProvider));
});

final getUserProvider = Provider<GetUsers>((ref) {
  return GetUsers(ref.read(userRepositoryProvider));
});

final userProvider = AsyncNotifierProvider<UserNotifier, List<UserModel>>(
  UserNotifier.new,
);

class UserNotifier extends AsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() {
    return ref.read(getUserProvider).call();
  }
}
