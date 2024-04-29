import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "Order Details #16542",
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ])),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Text(
                "Customer Name",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "Karan Chuhan",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Mobile Number",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "8788755585",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Address",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "502, Archana Soc, HSR Layout, Hubli, Karnataka, 500525",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              Divider(),
              SizedBox(height: 20.h),
              Text(
                "Products",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "Shirt Pattern Kurta",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Delivery Date",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "22 April 2022",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              Divider(),
              SizedBox(height: 20.h),
              Text(
                "Shirt Pattern Kurta",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Text(
                "Pattern",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "Suit Back Cut, Apple Cut, Collor Size",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Sleeve Lenth",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "5.2, 5.2",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Chest",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "5.2, 5.2",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Stomach",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "5.2, 5.2",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Hips",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "5.2, 5.2",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                "Other Details",
                style: TextStyle(color: Color(0xff757575), fontSize: 19.sp),
              ),
              SizedBox(height: 10.h),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua",
                style: TextStyle(color: Colors.black, fontSize: 21.sp),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
