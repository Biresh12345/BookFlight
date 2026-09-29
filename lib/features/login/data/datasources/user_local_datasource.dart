import 'dart:convert';

import 'package:app_mobile/features/login/data/model/user_model.dart';
import 'package:flutter/services.dart';

class UserLocalDatasource {
  Future<List<UserModel>> getUser() async {
    final jsonString = await rootBundle.loadString('assets/json/users.json');
    final List<dynamic> jsonData = jsonDecode(jsonString);
    Future.delayed(Duration(seconds: 1));
    return jsonData.map((json) => UserModel.fromJson(json)).toList();
  }
}
