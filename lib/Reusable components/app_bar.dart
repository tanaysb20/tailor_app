import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable

AppBar customAppBar({String text = ""}) => AppBar(
    toolbarHeight: 70.h,
    iconTheme: IconThemeData(
      color: const Color(0xffFF7126),
    ),
    backgroundColor: Colors.white,
    title: Text(
      text,
      style: TextStyle(
        fontSize: 22.sp,
        color: const Color(0xffFF7126),
        fontWeight: FontWeight.w500,
      ),
    ));

Future<void> message(String message) {
  return EasyLoading.showToast(message, maskType: EasyLoadingMaskType.black);
}
