import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailor_app/Modals/category_modal.dart';
import 'package:tailor_app/Modals/city_modal.dart';
import 'package:tailor_app/Modals/customer_modal.dart';
import 'package:tailor_app/Modals/item_modal.dart';
import 'package:tailor_app/Modals/pattern_modal.dart';
import 'package:tailor_app/Modals/product_item_detail_modal.dart';
import 'package:tailor_app/Modals/product_modal.dart';
import 'package:tailor_app/Modals/user_modal.dart';
import 'package:tailor_app/Reusable%20components/app_bar.dart';
import 'package:tailor_app/Screens/Home%20screen/%20Add%20Order/add_order_screen.dart';
import 'package:tailor_app/Urls/url_holder_loan.dart';

class HomeProvider with ChangeNotifier {
  List<CategoryModal> categoryList = [];
  List<CategoryItem> categoryItem = [];
  List<CustomerModal> customerList = [];
  List<TransactionModal> trasactionList = [];

  // List<OrderModal> orderList = [];
  List<ProductModal> productList = [];
  List<CityModal> cityList = [];
  List<String> cityNames = [];
  int? lastPage;
  int totalOrders = 0;
  int activeOrders = 0;
  int deliveredOrders = 0;
  int totalCustomer = 0;
  List<ProductItemDetail> selectedProductsItemDetail = [];
  List<PatternModal> patternList = [];
  String orderId = "";
  String orderNumber = "";
  List<AddOrderModal> addOrderItemList = [];

  Future<List<OrderModal>> getOrders(
      {int pageCount = 30, required int page}) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");

    var headers = {'Authorization': 'Bearer $_accessToken'};
    var request = Request('GET',
        Uri.parse('${UrlHolder.baseUrl}${UrlHolder.orderList}?page=${page}'));

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
      return demoOrderList;
      // notifyListeners();
    } else {
      print(response.reasonPhrase);
      return [];
    }
  }

  Future<List<CustomerModal>> getCustomer(
      {int pageCount = 30, required int page}) async {
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
          cityname: element["city"]["city"],
          name: element["name"] ?? "",
          order_count: element["order_count"] ?? "",
          phone_no: element["phone_no"] ?? "",
        ));
      });
      customerList = demoCustomerList;
      lastPage = txlastPage;

      notifyListeners();
      return customerList;
    } else {
      print(response.reasonPhrase);
      return customerList;
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

    var request = Request('GET',
        Uri.parse('${UrlHolder.baseUrl}${UrlHolder.productList}?page=1'));

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
      print(xyz);
      final List responseData = json.decode(xyz)["data"];

      responseData.forEach((element) {
        return demoCityList.add(CityModal(
          id: element["id"].toString(),
          cityName: element["city"] ?? "",
          cityId: element["state_id"] ?? "",
        ));
      });
      // log("getting City data");
      responseData.forEach((element) {
        // log(element.toString());
        return demoCityNames.add(
          element["city"] ?? "",
        );
      });
      cityList = demoCityList;
      cityNames = demoCityNames;

      log(cityList[0].cityName + "lengtthhhh");
      log(cityNames[0] + "lengtthhhh");

      log("${cityNames.length}");

      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getOrderDetail(String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {'Authorization': 'Bearer $_accessToken'};

    var request = Request('GET',
        Uri.parse('${UrlHolder.baseUrl}${UrlHolder.itemDetail}/$orderId'));

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    List<ProductItemDetail> demoselectedProductsItemDetail = [];

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz);

      responseData.forEach((element) {
        return demoselectedProductsItemDetail.add(ProductItemDetail(
          bottm_half_form_len_1: element["bottm_half_form_len_1"] ?? "",
          bottm_half_form_len_2: element["bottm_half_form_len_2"] ?? "",
          id: element["id"].toString(),
          bottom_1: element["bottom_1"] ?? "",
          bottom_2: element["bottom_2"] ?? "",
          bottom_hips: element["bottom_hips"] ?? "",
          bottom_len: element["bottom_len"] ?? "",
          chest_1: element["chest_1"] ?? "",
          chest_2: element["chest_2"] ?? "",
          delivery_date: element["delivery_date"] ?? "",
          hips_1: element["hips_1"] ?? "",
          hips_2: element["hips_2"] ?? "",
          item_status: element["item_status"] ?? "",
          knee_1: element["knee_1"] ?? "",
          knee_2: element["knee_2"] ?? "",
          length: element["length"] ?? "",
          neck_1: element["neck_1"] ?? "",
          neck_2: element["neck_2"] ?? "",
          order_id: element["order_id"] ?? "",
          other_detail: element["other_detail"] ?? "",
          pattern_id: element["pattern_id"] ?? "",
          pattern_name: element["pattern_name"] ?? "",
          product_id: element["product_id"] ?? "",
          product_name: element["product"]["name"] ?? "",
          qty: element["qty"] ?? "",
          sholder: element["sholder"] ?? "",
          sleeve_length_1: element["sleeve_length_1"] ?? "",
          sleeve_length_2: element["sleeve_length_2"] ?? "",
          sleeve_length_3: element["sleeve_length_3"] ?? "",
          stomach_1: element["stomach_1"] ?? "",
          stomach_2: element["stomach_2"] ?? "",
          thigh_1: element["thigh_1"] ?? "",
          thigh_2: element["thigh_2"] ?? "",
          type: element["type"] ?? "",
          waist_1: element["waist_1"] ?? "",
          waist_2: element["waist_2"] ?? "",
        ));
      });
      selectedProductsItemDetail = demoselectedProductsItemDetail;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getPatterns(String id) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {'Authorization': 'Bearer $_accessToken'};
    var request = Request(
        'GET',
        Uri.parse(
            '${UrlHolder.baseUrl}${UrlHolder.patternFilter}/${int.parse(id)}'));

    request.headers.addAll(headers);

    List<PatternModal> demoPatternList = [];

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      final List responseData = json.decode(xyz);

      responseData.forEach((element) {
        return demoPatternList.add(PatternModal(
          id: element["id"].toString(),
          name: element["name"] ?? "",
        ));
      });
      patternList = demoPatternList;
      notifyListeners();
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<bool> addCustomerAndOrder(
      {String customerId = "",
      String customerName = "",
      String phoneNo = "",
      String cityId = "",
      String address = ""}) async {
    log("$customerId cehcknigng");
    log("$customerName cehcknigng");
    log("$phoneNo cehcknigng");
    log("$cityId cehcknigng");
    log("$address cehcknigng");
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {'Authorization': 'Bearer $_accessToken'};
    var request = MultipartRequest(
        'POST', Uri.parse('${UrlHolder.baseUrl}${UrlHolder.orderAdd}'));
    request.fields.addAll({
      'customer_name': customerName,
      'phone_no': phoneNo,
      'address': address,
      'city_id': cityId,
      'customer_id': customerId
    });

    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final xyz = await response.stream.bytesToString();

      print("object success");

      final responseData = json.decode(xyz);
      // log("${response.stream.bytesToString()}");
      orderId = responseData["order_detail"]["order_id"].toString();
      orderNumber = responseData["order_detail"]["order_no"] ?? "";
      notifyListeners();
      return true;
    } else {
      final xyz = await response.stream.bytesToString();
      final responseData = json.decode(xyz)["errors"]["address"][0];
      log("${xyz}");
      message(responseData.toString());
      return false;
    }
  }

  void increaseOrder() {
    addOrderItemList.add(AddOrderModal(
        selectedProduct: ProductModal(id: "", name: "", type: ""),
        patternList: [],
        patternController: MultiSelectController(),
        bottom1: TextEditingController(),
        bottom2: TextEditingController(),
        bottomHalfLength1: TextEditingController(),
        bottomHalfLength2: TextEditingController(),
        bottomhips: TextEditingController(),
        bottomlength: TextEditingController(),
        chest1Controller: TextEditingController(),
        chest2Controller: TextEditingController(),
        cityController: TextEditingController(),
        detailsController: TextEditingController(),
        hips1Controller: TextEditingController(),
        hips2Controller: TextEditingController(),
        knee1: TextEditingController(),
        knee2: TextEditingController(),
        lengthController: TextEditingController(),
        neck1Controller: TextEditingController(),
        neck2Controller: TextEditingController(),
        qtyController: TextEditingController(),
        seleeveLength1Controller: TextEditingController(),
        seleeveLength2Controller: TextEditingController(),
        seleeveLength3Controller: TextEditingController(),
        shoulderController: TextEditingController(),
        stomach1Controller: TextEditingController(),
        thigh1: TextEditingController(),
        stomach2Controller: TextEditingController(),
        waist1: TextEditingController(),
        thigh2: TextEditingController(),
        waist2: TextEditingController(),
        selectedPattern: [],
        id: DateTime.now().toString()));
    notifyListeners();
  }

  void deleteOrder(String id) {
    addOrderItemList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future addOrder(String orderId, String bill_no) async {
    final prefs = await SharedPreferences.getInstance();
    var _accessToken = await prefs.getString("userToken");
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_accessToken'
    };

    List<AddOrderModal> finalAddOrderItemList = addOrderItemList
        .where((element) => element.selectedProduct.id.isNotEmpty)
        .toList();

    var request = Request('POST',
        Uri.parse('${UrlHolder.baseUrl}${UrlHolder.addOrderItem}/$orderId'));
    request.body = json.encode({
      "order_id": orderId,
      "bill_no": bill_no,
      "products": finalAddOrderItemList.map((e) => {
            "product_id": e.selectedProduct.id,
            "pattern_id": e.selectedPattern.isEmpty
                ? []
                : e.selectedPattern.map((e) => e.value).toList(),
            "length": e.lengthController?.value.text ?? "",
            "sholder": e.shoulderController?.value.text ?? "",
            "sleeve_length_1": e.seleeveLength1Controller?.value.text ?? "",
            "sleeve_length_2": e.seleeveLength2Controller?.value.text ?? "",
            "sleeve_length_3": e.seleeveLength3Controller?.value.text ?? "",
            "chest_1": e.chest1Controller?.value.text ?? "",
            "chest_2": e.chest2Controller?.value.text ?? "",
            "stomach_1": e.stomach1Controller?.value.text ?? "",
            "stomach_2": e.stomach2Controller?.value.text ?? "",
            "hips_1": e.hips1Controller?.value.text ?? "",
            "hips_2": e.hips2Controller?.value.text ?? "",
            "neck_1": e.neck1Controller?.value.text ?? "",
            "neck_2": e.neck2Controller?.value.text ?? "",
            "bottom_len": e.bottomlength?.value.text ?? "",
            "bottm_half_form_len_1": e.bottomHalfLength1?.value.text ?? "",
            "bottm_half_form_len_2": e.bottomHalfLength2?.value.text ?? "",
            "bottom_1": e.bottom1?.value.text ?? "",
            "bottom_2": e.bottom2?.value.text ?? "",
            "knee_1": e.knee1?.value.text ?? "",
            "knee_2": e.knee2?.value.text ?? "",
            "thigh_1": e.thigh1?.value.text ?? "",
            "thigh_2": e.thigh2?.value.text ?? "",
            "waist_1": e.waist1?.value.text ?? "",
            "waist_2": e.waist2?.value.text ?? "",
            "bottom_hips": e.bottomhips?.value.text ?? "",
            "other_detail": e.detailsController?.value.text ?? "",
            "qty": e.qtyController?.value.text ?? "",
            "delivery_date": e.detailsController?.value.text ?? "",
          })
    });
    request.headers.addAll(headers);

    StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
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
