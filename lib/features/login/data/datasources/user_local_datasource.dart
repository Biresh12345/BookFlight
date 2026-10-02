import 'dart:convert';
import 'dart:io';

import 'package:app_mobile/features/login/data/model/user_model.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class UserLocalDatasource {
  Future<File> _getUserFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/users.json');

    if (!await file.exists()) {
      final jsonString = await rootBundle.loadString('assets/json/users.json');

      await file.writeAsString(jsonString);
    }

    return file;
  }

  Future<List<UserModel>> getUser() async {
    final file = await _getUserFile();

    final jsonString = await file.readAsString();

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<UserModel> saveUser({
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    final file = await _getUserFile();

    final jsonString = await file.readAsString();

    final List<dynamic> jsonData = jsonDecode(jsonString);

    final emailExists = jsonData.any((user) => user['email'] == userEmail);

    if (emailExists) {
      throw Exception('Email already exists');
    }

    final lastId = jsonData.last['id'];

    final number = int.parse(lastId.toString().substring(1));

    final newId = 'U${(number + 1).toString().padLeft(3, '0')}';

    final userData = {
      'id': newId,
      'name': userName,
      'email': userEmail,
      'password': userPassword,
    };

    jsonData.add(userData);

    await file.writeAsString(jsonEncode(jsonData));

    return UserModel.fromJson(userData);
  }
}
