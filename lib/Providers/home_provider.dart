import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/Modals/category_modal.dart';
import 'package:tailor_app/Modals/city_modal.dart';
import 'package:tailor_app/Modals/customer_modal.dart';
import 'package:tailor_app/Modals/item_modal.dart';
import 'package:tailor_app/Modals/product_modal.dart';
import 'package:tailor_app/Modals/user_modal.dart';
import 'package:tailor_app/Urls/url_holder_loan.dart';

class HomeProvider with ChangeNotifier {
  List<CategoryModal> categoryList = [];
  List<CategoryItem> categoryItem = [];
  List<CustomerModal> customerList = [];
  List<TransactionModal> trasactionList = [];

  List<OrderModal> orderList = [];
  List<ProductModal> productList = [];
  List<CityModal> cityList = [];
  List<String> cityNames = [];
  int? lastPage;
  int totalOrders = 0;
  int activeOrders = 0;
  int deliveredOrders = 0;
  int totalCustomer = 0;

  Future getOrders() async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");

    var headers = {'Authorization': 'Bearer $_accessToken'};
    var request =
        Request('GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.orderList}'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    List<OrderModal> demoOrderList = [];

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"];

      responseData.forEach((element) {
        return demoOrderList.add(OrderModal(
          id: element["id"].toString(),
          address: element["address"] ?? "",
          bill_no: element["bill_no"] ?? "",
          cust_name: element["cust_name"] ?? "",
          mobile_no: element["mobile_no"] ?? "",
          city_id: element["city_id"] ?? "",
          created_at: element["created_at"] ?? "",
          cust_id: element["cust_id"] ?? "",
          order_no: element["order_no"] ?? "",
          sales_name: element["sales_name"] ?? "",
          status: element["status"] ?? "",
        ));
      });
      orderList = demoOrderList;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getCustomer(int page) async {
    log("$page");
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {'Authorization': 'Bearer $_accessToken'};

    var request = Request('GET',
        Uri.parse('${UrlHolder.baseUrl}${UrlHolder.customerList}?page=$page'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();
    List<CustomerModal> demoCustomerList = [];

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"];
      final txlastPage = json.decode(xyz)["last_page"];

      responseData.forEach((element) {
        return demoCustomerList.add(CustomerModal(
          id: element["id"].toString(),
          address: element["address"] ?? "",
          city_id: element["city_id"] ?? "",
          created_at: element["created_at"] ?? "",
          avtar: element["avtar"] ?? "",
          name: element["name"] ?? "",
          order_count: element["order_count"] ?? "",
          phone_no: element["phone_no"] ?? "",
        ));
      });
      customerList = demoCustomerList;
      lastPage = txlastPage;

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }

    // var request = Request(
    //     'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.customerList}'));

    // request.headers.addAll(headers);

    // List<CustomerModal> demoCustomerList = [];

    // StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   final xyz = await response.stream.bytesToString();

    //   final List responseData = json.decode(xyz)["data"];

    //   responseData.forEach((element) {
    //     return demoCustomerList.add(CustomerModal(
    //       id: element["id"].toString(),
    //       address: element["address"] ?? "",
    //       city_id: element["city_id"] ?? "",
    //       created_at: element["created_at"] ?? "",
    //       avtar: element["avtar"] ?? "",
    //       city: element["city"]["city"] ?? "",
    //       name: element["name"] ?? "",
    //       order_count: element["order_count"] ?? "",
    //       phone_no: element["phone_no"] ?? "",
    //     ));
    //   });
    //   customerList = demoCustomerList;

    //   notifyListeners();
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  Future getProductList() async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {'Authorization': 'Bearer $_accessToken'};

    var request = Request(
        'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.productList}'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();
    List<ProductModal> demoproductList = [];

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz)["data"];

      responseData.forEach((element) {
        return demoproductList.add(ProductModal(
          id: element["id"].toString(),
          name: element["name"] ?? "",
          type: element["type"] ?? "",
        ));
      });
      productList = demoproductList;

      log("${productList.length}");

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }

    // var request = Request(
    //     'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.customerList}'));

    // request.headers.addAll(headers);

    // List<CustomerModal> demoCustomerList = [];

    // StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   final xyz = await response.stream.bytesToString();

    //   final List responseData = json.decode(xyz)["data"];

    //   responseData.forEach((element) {
    //     return demoCustomerList.add(CustomerModal(
    //       id: element["id"].toString(),
    //       address: element["address"] ?? "",
    //       city_id: element["city_id"] ?? "",
    //       created_at: element["created_at"] ?? "",
    //       avtar: element["avtar"] ?? "",
    //       city: element["city"]["city"] ?? "",
    //       name: element["name"] ?? "",
    //       order_count: element["order_count"] ?? "",
    //       phone_no: element["phone_no"] ?? "",
    //     ));
    //   });
    //   customerList = demoCustomerList;

    //   notifyListeners();
    // } else {
    //   print(response.reasonPhrase);
    // }
  }

  Future getCounts() async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {'Authorization': 'Bearer $_accessToken'};
    var request =
        Request('GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.getCount}'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final responseData = json.decode(xyz);
      totalOrders = responseData["total_order"];
      activeOrders = responseData["active_order"];
      deliveredOrders = responseData["delivered_order"];
      totalCustomer = responseData["total_customers"];
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getCity() async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {'Authorization': 'Bearer $_accessToken'};

    var request =
        Request('GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.cityList}'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();
    List<CityModal> demoCityList = [];
    List<String> demoCityNames = [];

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz);

      responseData.forEach((element) {
        return demoCityList.add(CityModal(
          id: element["id"].toString(),
          cityName: element["name"] ?? "",
          cityId: element["type"] ?? "",
        ));
      });
      responseData.forEach((element) {
        return demoCityNames.add(
          element["name"] ?? "",
        );
      });
      cityList = demoCityList;
      cityNames = demoCityNames;

      log(cityList[0].cityName + "lengtthhhh");
      log(cityNames[0] + "lengtthhhh");

      log("${cityList.length} lengtthhhh");

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  // Future getOrders() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   var _accessToken = await prefs.getString("userToken");
  //   var headers = {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer $_accessToken'
  //   };
  //   var request = Request(
  //       'GET', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.getOrders}'));

  //   request.headers.addAll(headers);

  //   List<TransactionModal> demoTrasactionList = [];

  //   StreamedResponse response = await request.send();

  //   if (response.statusCode == 200) {
  //     final xyz = await response.stream.bytesToString();

  //     final List responseData = json.decode(xyz)["data"]["result"];
  //     responseData.forEach((element) {
  //       return demoTrasactionList.add(TransactionModal(
  //         id: element["product"]["id"].toString(),
  //         name: element["product"]["name"] ?? "",
  //         date: element["product"]["created_at"] ?? "",
  //         point: element["product"]["points"] ?? "",
  //       ));
  //     });

  //     orderList = demoTrasactionList;

  //     notifyListeners();
  //   } else {
  //     final xyz = await response.stream.bytesToString();

  //     final responseData = json.decode(xyz)["msg"];
  //     message(responseData);
  //   }
  // }
}
