import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';


final controlName = TextEditingController();
final controlAge = TextEditingController();
final controlEmail = TextEditingController();
final controlPhone = TextEditingController();

// Delete User
Future<void> deleteUser(String id) async {
  //await Future.delayed(Duration(seconds: 1), () {});
  var user = ParseObject('Employee')..objectId = id;
  await user.delete();
}

// Update User
Future<void> updateUser(String id) async {
  //await Future.delayed(Duration(seconds: 1), () {});
  var todo = ParseObject('Employee')
    ..objectId = id
    ..set('name', controlName.text)
    ..set('age', controlAge.text)
    ..set('email', controlEmail.text)
    ..set('phone', controlPhone.text);
  await todo.save();
}

// Select User
Future<List<ParseObject>> selectUsers() async {
  QueryBuilder<ParseObject> queryUsers =
      QueryBuilder<ParseObject>(ParseObject('Employee'));
  final ParseResponse apiResponse = await queryUsers.query();

  if (apiResponse.success && apiResponse.results != null) {
    return apiResponse.results as List<ParseObject>;
  } else {
    return [];
  }
}
