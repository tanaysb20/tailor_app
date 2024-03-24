import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/Modals/category_modal.dart';
import 'package:tailor_app/Modals/item_modal.dart';
import 'package:tailor_app/Reusable%20components/app_bar.dart';
import 'package:tailor_app/Urls/url_holder_loan.dart';

class HomeProvider with ChangeNotifier {
  List<CategoryModal> categoryList = [];
  List<CategoryItem> categoryItem = [];
  List<TransactionModal> trasactionList = [];
  List<TransactionModal> orderList = [];


 Future getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IllvK2hGY1RjcXMva1UrOWNiZ0xHUUE9PSIsInZhbHVlIjoia1ZJeHVKWXhjczRZcU50eko4RTUzb0IyM0hRbjc1RFJjaklzeDRheElLL3pSSWROYWtIRlpWVTFRb2RWNFJodGM2aDhDVnJIOThudHVoa0pod2Z2U3pYWk9mWmU0S29PWU9OZzltU2l4YndweDZHMXlDdDBYcEJwNjRicUc5TnEiLCJtYWMiOiI4M2Q4Zjc0ZDliZTNjODU3ODM3N2YwZWRhOWIzM2QzOTg0MzdjYzlmNGM5ZDI0NjUzOWYyMWMyYTI5NzFlMjBlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjFjblBWN1QxN0RLTEdjVGdJN0NqK1E9PSIsInZhbHVlIjoiNnczYUR5NWdUbW5VYllNVkJZSEp2U2x5OVdVOEp4akE3OGJSd1R5cW1EWGZhNXVOYlVKSDR6UnJscVBQd25IR0dvQisyZzc1bG9NUXk5TkExRWVBa291TVQ2dmovR2pqTjVidHNkY2VFMHZCZzBaVmh6OENZZTVtRWFpQlVoRVIiLCJtYWMiOiJiY2M1NDIxYTJmZGE3ZmNjOTMyOWRlNDRkYTYxOWMzZjU0ZmI5YmFhM2VkYzNmNzNkODU4MTE0NTQyYjRjZjU4IiwidGFnIjoiIn0%3D'
    };
    var request =
        Request('GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.category}'));

    request.headers.addAll(headers);

    List<CategoryModal> demoCategoryList = [];

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"];

      responseData.forEach((element) {
        return demoCategoryList.add(CategoryModal(
          id: element["id"].toString(),
          name: element["name"].toString(),
        ));
      });

      categoryList = demoCategoryList;
      notifyListeners();
    } else {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
    }
  }

  Future getCategoriesItems(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6IllvK2hGY1RjcXMva1UrOWNiZ0xHUUE9PSIsInZhbHVlIjoia1ZJeHVKWXhjczRZcU50eko4RTUzb0IyM0hRbjc1RFJjaklzeDRheElLL3pSSWROYWtIRlpWVTFRb2RWNFJodGM2aDhDVnJIOThudHVoa0pod2Z2U3pYWk9mWmU0S29PWU9OZzltU2l4YndweDZHMXlDdDBYcEJwNjRicUc5TnEiLCJtYWMiOiI4M2Q4Zjc0ZDliZTNjODU3ODM3N2YwZWRhOWIzM2QzOTg0MzdjYzlmNGM5ZDI0NjUzOWYyMWMyYTI5NzFlMjBlIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjFjblBWN1QxN0RLTEdjVGdJN0NqK1E9PSIsInZhbHVlIjoiNnczYUR5NWdUbW5VYllNVkJZSEp2U2x5OVdVOEp4akE3OGJSd1R5cW1EWGZhNXVOYlVKSDR6UnJscVBQd25IR0dvQisyZzc1bG9NUXk5TkExRWVBa291TVQ2dmovR2pqTjVidHNkY2VFMHZCZzBaVmh6OENZZTVtRWFpQlVoRVIiLCJtYWMiOiJiY2M1NDIxYTJmZGE3ZmNjOTMyOWRlNDRkYTYxOWMzZjU0ZmI5YmFhM2VkYzNmNzNkODU4MTE0NTQyYjRjZjU4IiwidGFnIjoiIn0%3D'
    };
    var request = Request(
        'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.category}/$id'));

    request.headers.addAll(headers);

    List<CategoryItem> demoCategoryList = [];

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"]["product"];

      responseData.forEach((element) {
        return demoCategoryList.add(CategoryItem(
          id: element["id"].toString(),
          name: element["name"].toString(),
          category_id: element["category_id"].toString(),
          image: element["image"].toString(),
          points: element["points"].toString(),
        ));
      });

      categoryItem = demoCategoryList;
      notifyListeners();
    } else {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
    }
  }

  Future<bool> couponCode(String couponId) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
      'Content-Type': 'application/json'
    };
    var request = Request(
        'POST', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.couponValidate}'));
    request.body = json.encode({"coupon_code": couponId});
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
      return true;
    } else {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
      return true;
    }
  }

  Future orderProduct(String product_id) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken',
      'Content-Type': 'application/json'
    };
    var request = Request(
        'POST', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.productOrder}'));
    request.body = json.encode({"product_id": product_id});
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
      return true;
    } else {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
      return true;
    }
  }

  Future getTransaction() async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken'
    };
    var request = Request(
        'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.getTransaction}'));

    request.headers.addAll(headers);

    List<TransactionModal> demoTrasactionList = [];

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"];
      responseData.forEach((element) {
        return demoTrasactionList.add(TransactionModal(
          id: element["order"]["id"].toString(),
          name: element["order"]["product"]["name"] ?? "",
          date: element["order"]["product"]["created_at"] ?? "",
          point: element["order"]["product"]["points"] ?? "",
        ));
      });

      trasactionList = demoTrasactionList;

      notifyListeners();
    } else {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
    }
  }

  Future getFilterTransaction(String txDate) async {
    print(txDate);
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_accessToken'
    };
    var request = Request('GET',
        Uri.parse('${UrlHolder.baseUrl}${UrlHolder.getFilterTransaction}'));
    request.body = json.encode({"date": txDate});
    request.headers.addAll(headers);

    List<TransactionModal> demoTrasactionList = [];

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"];
      responseData.forEach((element) {
        return demoTrasactionList.add(TransactionModal(
          id: element["order"]["id"].toString(),
          name: element["order"]["product"]["name"] ?? "",
          date: element["order"]["product"]["created_at"] ?? "",
          point: element["order"]["product"]["points"] ?? "",
        ));
      });

      trasactionList = demoTrasactionList;

      notifyListeners();
    } else {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
    }
  }

  Future uploadImage(String image) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization':
          'Bearer $_accessToken',
    'Content-Type': 'application/json'
    };
    var request = MultipartRequest('POST',
        Uri.parse('${UrlHolder.baseUrl}${UrlHolder.uploadImage}'));
    request.files
        .add(await MultipartFile.fromPath('image', image));
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
        final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
    } else {
        final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
    }
  }


  Future getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $_accessToken'
    };
    var request = Request(
        'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.getOrders}'));

    request.headers.addAll(headers);

    List<TransactionModal> demoTrasactionList = [];

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"]["result"];
      responseData.forEach((element) {
        return demoTrasactionList.add(TransactionModal(
          id: element["product"]["id"].toString(),
          name: element["product"]["name"] ?? "",
          date: element["product"]["created_at"] ?? "",
          point: element["product"]["points"] ?? "",
        ));
      });

      orderList = demoTrasactionList;

      notifyListeners();
    } else {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz)["msg"];
      message(responseData);
    }
  }

 

}
