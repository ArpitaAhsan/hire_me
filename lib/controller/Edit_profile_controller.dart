import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hire_me/api/api_root.dart';
import 'package:http/http.dart' as http;
import '../model/Edit_profile_model.dart';
class EditProfileController {
  Future<UserModel?> fetchUserData(String email) async {
    final String apiUrl = "${api_root}/profile/$email";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return UserModel.fromJson(data);
      } else {
        Fluttertoast.showToast(msg: "Failed to fetch user data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
      return null;
    }
  }

  Future<bool> updateUserData(UserModel user) async {
    final String apiUrl = "${api_root}/profile/${user.email}";
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Profile updated successfully");
        return true;
      } else {
        Fluttertoast.showToast(msg: "Failed to update profile: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An error occurred: $e");
      return false;
    }
  }
}
