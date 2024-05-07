import 'dart:developer';
import 'dart:io';

import 'package:easy_autocomplete/easy_autocomplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/city_modal.dart';
import 'package:tailor_app/Modals/customer_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';
import 'package:tailor_app/Reusable%20components/custom_button.dart';
import 'package:tailor_app/Reusable%20components/dropdown.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';
import 'package:tailor_app/Screens/Home%20screen/%20Add%20Order/add_order_screen.dart';
import 'package:tailor_app/Screens/select_customer_list_screen.dart';
import 'package:tailor_app/Urls/url_holder_loan.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool save = true;
  TextEditingController customerNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String sendImage = "";
  String cityId = "";
  String customerId = "";
  File? showImage;

  void clear() {
    save = true;
    customerNameController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    cityController = TextEditingController();
    sendImage = "";
    showImage = null;

    cityId = "";
    customerId = "";

    setState(() {});
  }

  Future takeGallery(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Image From"),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      final imageFile = await ImagePicker().pickImage(
                          source: ImageSource.camera, imageQuality: 20);
                      if (imageFile != null) {
                        showImage = File(imageFile.path);
                        sendImage = imageFile.path;

                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 90.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffFF7126)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.camera_alt,
                        size: 45,
                        color: Color(0xffFF7126),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () async {
                      final imageFile = await ImagePicker().pickImage(
                          source: ImageSource.gallery, imageQuality: 20);
                      if (imageFile != null) {
                        showImage = File(imageFile.path);
                        sendImage = imageFile.path;
                        setState(() {});

                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 90.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffFF7126)),
                          borderRadius: BorderRadius.circular(10)),
                      child: Icon(
                        Icons.image,
                        size: 45,
                        color: Color(0xffFF7126),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<HomeProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 70.h,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            titleSpacing: 20.w,
            centerTitle: false,
            title: Row(children: [
              InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back,
                      color: Color(0xffFF7126), size: 20.sp)),
              SizedBox(width: 8.w),
              Text(
                "Add Customer",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ])),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 19.w, right: 10.w, bottom: 42.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 25.h),
                save == false
                    ? Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: CircleAvatar(
                          radius: 48.sp,
                          backgroundColor: Color(0xffFF7126),
                          backgroundImage: NetworkImage(sendImage),
                        ),
                      )
                    : showImage != null
                        ? InkWell(
                            onTap: () {
                              takeGallery(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: CircleAvatar(
                                radius: 48.sp,
                                backgroundColor: Color(0xffFF7126),
                                backgroundImage: FileImage(showImage!),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              takeGallery(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 48.sp,
                                    backgroundColor: Color(0xffC8D3FF),
                                    child: Icon(Icons.person,
                                        size: 40.sp, color: Color(0xff193F80)),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff193F80),
                                      radius: 18.sp,
                                      child: Icon(Icons.camera_alt,
                                          size: 23.sp, color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                SizedBox(height: 30.h),
                Container(
                  child: CustomTextField(
                    controller: customerNameController,
                    margin: false,
                    isEnabled: save ? true : false,
                    hintText: "Enter Customer Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Customer Name can\'t be empty';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () async {
                    final selectedCustomer =
                        await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return SelectCustomerListScreen();
                      },
                    ));
                    if (selectedCustomer != null) {
                      save = false;
                      customerNameController = TextEditingController(
                          text: (selectedCustomer as CustomerModal).name);
                      phoneController = TextEditingController(
                          text: selectedCustomer.phone_no);
                      addressController =
                          TextEditingController(text: selectedCustomer.address);
                      cityController = TextEditingController(
                          text: selectedCustomer.cityname);
                      cityId = selectedCustomer.city_id;
                      customerId = selectedCustomer.id;

                      sendImage =
                          "${UrlHolder.baseUrl}${selectedCustomer.avtar}${selectedCustomer.avtar}";
                      setState(() {});
                    }
                  },
                  child: Text(
                    "Select from Existing Customer",
                    style: TextStyle(
                      color: Color(0xffFF7126),
                      fontFamily: "Sora",
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 80.h,
                  child: DropdownInput(
                    isMargin: false,
                    controller: cityController,
                    value: cityController.text.isEmpty
                        ? "Select City"
                        : cityController.text,
                    isEnabled: true,
                    // value: consajda.value.text,
                    inputFieldWidth: double.infinity,
                    items: item.cityList.map((CityModal value) {
                      return DropdownMenuItem<String>(
                        value: value.id.toString(),
                        child: Text(
                          value.cityName.toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      log(value + "vallluuee");
                      cityId = value;
                      setState(() {});
                    },
                  ),
                ),
                CustomTextField(
                  controller: phoneController,
                  isEnabled: save ? true : false,
                  hintText: "Enter Mobile Number",
                  prefix: "+91 | ",
                  margin: false,
                  maxlength: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number can\'t be empty';
                    } else if (value.length != 10) {
                      return 'Mobile number must be of 10 digits';
                    }
                    return null;
                  },
                  txKeyboardType: TextInputType.number,
                ),
                SizedBox(height: 10.h),
                CustomTextField(
                  controller: addressController,
                  isEnabled: save ? true : false,
                  hintText: "Enter Address",
                  maxCheck: 4,
                  margin: false,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Address can\'t be empty';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(height: 40.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  height: 80.h,
                  child: CustomButtonScreen(
                      text1: "Next",
                      check: true,
                      bgcolor: Color(0xffFF7126),
                      fun: () async {
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show(maskType: EasyLoadingMaskType.black);
                          bool check = await item.addCustomerAndOrder(
                            address: addressController.value.text,
                            cityId: cityId,
                            customerId: customerId,
                            customerName: customerNameController.value.text,
                            phoneNo: phoneController.value.text,
                          );
                          EasyLoading.dismiss();
                          if (check) {
                            EasyLoading.dismiss();
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return AddOrderScreen();
                              },
                            ));
                          } else {
                            EasyLoading.dismiss();
                          }

                          // bool check = await item.sendOtp(
                          //     mobileNumberController.value.text,
                          //     passwordController.value.text);

                          //   if (check) {

                          // } else {}
                        }
                      },
                      color: Colors.white,
                      width: 400.w,
                      radius: 40),
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  height: 80.h,
                  child: CustomButtonScreen(
                      text1: "Clear",
                      check: true,
                      bgcolor: Colors.red,
                      fun: () async {
                        clear();
                      },
                      color: Colors.white,
                      width: 400.w,
                      radius: 40),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
