import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/Reusable%20components/app_bar.dart';
import 'package:tailor_app/Urls/url_holder_loan.dart';

class AuthProvider with ChangeNotifier {
  Future<bool> sendOtp(String phoneNos, String password) async {
    log(phoneNos + "sendd");
    log(password + "sendd");
    final prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    var request =
        Request('POST', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.login}'));
    request.body = json.encode({'phone_no': phoneNos, 'password': password});
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final responseDataMessage = json.decode(xyz)["message"];
      final authToken = json.decode(xyz)["token"];

      await prefs.setString(
        "userToken",
        authToken.toString(),
      );

      message(responseDataMessage);
      return true;
    } else {
      final xyz = await response.stream.bytesToString();
      final responseData = json.decode(xyz)["message"];
      message(responseData);
      return false;
    }
  }
  // Future updateProfile<bool>(String personName, String address) async {
  //   print(personName);
  //   print(address);
  //   final prefs = await SharedPreferences.getInstance();
  //   var _accessToken = await prefs.getString("userToken");
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $_accessToken',
  //     'Content-Type': 'application/json'
  //   };
  //   var request = Request(
  //       'POST', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.updateUser}'));
  //   request.body = json
  //       .encode({"contact_person_name": "$personName", "address": "$address"});
  //   request.headers.addAll(headers);

  //   StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     final xyz = await response.stream.bytesToString();

  //     final responseData = json.decode(xyz)["msg"];
  //     await viewProfile();
  //     message(responseData);
  //     return true;
  //   } else {
  //     final xyz = await response.stream.bytesToString();
  //     final responseData = json.decode(xyz)["msg"];
  //     message(responseData);
  //     return false;
  //   }
  // }

  // Future viewProfile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var _accessToken = await prefs.getString("userToken");

  //   var headers = {
  //     'Authorization': 'Bearer $_accessToken',
  //     'Cookie':
  //         'XSRF-TOKEN=eyJpdiI6IkZlc205Tkx3NUg1MS9JSTVMSzRycXc9PSIsInZhbHVlIjoiYytLazZWaG5iMWZwdHZkZFNQazh0YXlUNU5HUCtaNmNlZ0Nhb2FTdzB3bFhodzc0bmRwbWxKWWV2cmYxNzVUc0pqdkxtOVdoUjZ1UUJrVXJLY1BzaWtUVEo3Y04xaFc2TnZFMTg0WUxENmUyYzRwaU1aRWtmWlNuTzhaUmlNMmgiLCJtYWMiOiJkZmJhNTNhZmVkYjkwZjg4ODMxYzQ0YWI3NDcyNGNiMGRiZjY0NmMzZjJiMGZhYTYyYjFhMzViNDM4ZGFiNGYxIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6InluZ01YN1h5QlVSRE51RXBEelh4RGc9PSIsInZhbHVlIjoiOE1SUldmVmpVa3JzSjVuT3dWY01BWWxUczlyZFozb0llRi96S3pkbDlpajgyT0M1S2NmbStPTG0vTWVPVkdkWVBSTmxqa3ArTjF1L0V3ZTZHMUNqVFlocWNrbGd0RmQ5K0tZRi9wVDdRSC8rZTl4dEgySEdBcGdtcEErdW1nQTAiLCJtYWMiOiIyNmM1YmViNGQxNzNmOGNjNDE1MjdlOGI3OTdkZGFlMDlhOTc5MjI2OGIzN2M2OGQ3ZDhkNGRlMmRjZDIyMTI3IiwidGFnIjoiIn0%3D'
  //   };
  //   var request = Request(
  //       'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.viewProfile}'));

  //   request.headers.addAll(headers);

  //   StreamedResponse response = await request.send();

  //   UserModal? demoUserModal;

  //   if (response.statusCode == 200) {
  //     final xyz = await response.stream.bytesToString();

  //     final responseData = json.decode(xyz)["data"];

  //     demoUserModal = UserModal(
  //       address: responseData["address"] ?? "",
  //       contact_person_name: responseData["contact_person_name"] ?? "",
  //       current_wallet_points: responseData["current_wallet_points"] ?? "",
  //       id: responseData["id"].toString(),
  //       image: responseData["image"] ?? "",
  //       mobile_number: responseData["mobile_number"] ?? "",
  //     );

  //     userLogined = demoUserModal;
  //     notifyListeners();
  //   } else {
  //     final xyz = await response.stream.bytesToString();

  //     final responseData = json.decode(xyz)["msg"];
  //     message(responseData);
  //   }
  // }
}
