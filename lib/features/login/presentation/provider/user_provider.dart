import 'dart:async';

import 'package:app_mobile/features/login/data/datasources/user_local_datasource.dart';
import 'package:app_mobile/features/login/data/model/user_model.dart';
import 'package:app_mobile/features/login/data/repositories/user_repository_impl.dart';
import 'package:app_mobile/features/login/domain/usecase/get_users.dart';
import 'package:app_mobile/features/login/domain/usecase/save_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum UserStatus { initial, loading, success, error }

class UserState {
  final UserStatus status;
  final List<UserModel> users;
  final String? errorMessage;

  const UserState({
    this.status = UserStatus.initial,
    this.users = const [],
    this.errorMessage,
  });

  UserState copyWith({
    UserStatus? status,
    List<UserModel>? users,
    String? errorMessage,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

final userLocalDataSourceProvider = Provider<UserLocalDatasource>((ref) {
  return UserLocalDatasource();
});

final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  return UserRepositoryImpl(ref.read(userLocalDataSourceProvider));
});

final getUserProvider = Provider<GetUsers>((ref) {
  return GetUsers(ref.read(userRepositoryProvider));
});

final saveUserProvider = Provider<SaveUser>((ref) {
  return SaveUser(ref.read(userRepositoryProvider));
});

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() {
    return const UserState();
  }

  Future<void> loadUsers() async {
    state = state.copyWith(status: UserStatus.loading);
    try {
      final user = await ref.read(getUserProvider).call();
      state = state.copyWith(status: UserStatus.success, users: user);
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<bool> loginUser({
    required String userEmail,
    required String userPassword,
  }) async {
    state = state.copyWith(status: UserStatus.loading);

    await Future.delayed(const Duration(seconds: 2));

    final isValid = state.users.any(
      (user) => user.email == userEmail && user.password == userPassword,
    );

    state = state.copyWith(
      status: isValid ? UserStatus.success : UserStatus.error,
    );
    return isValid;
  }

  Future<void> saveUser({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    state = state.copyWith(status: UserStatus.loading);
    try {
      final saveUser = await ref
          .read(saveUserProvider)
          .call(
            userName: userName,
            userEmail: userEmail,
            userPassword: userPassword,
          );
      state = state.copyWith(
        status: UserStatus.success,
        users: [...state.users, saveUser],
      );
    } catch (e) {
      state = state.copyWith(
        status: UserStatus.error,
        errorMessage: e.toString(),
      );
    }
  }
}
