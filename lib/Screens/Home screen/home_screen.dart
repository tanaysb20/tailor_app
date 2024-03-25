import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/Reusable%20components/order_item.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int indexx = 0;
  int currentIndexx = 0;
  int tab = 1;

  TextEditingController couponCodeController = TextEditingController();
  bool loading = false;
  //  QRViewController? controller;
  //  Barcode? result;
  String result = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refresh() {
    print("object");
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: CircularProgressIndicator(color: const Color(0xff193F80)))
        : Scaffold(
          body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 25.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                            child: customBox(
                                Color(0xff5F67EC), "100", "Total Orders","box1")),
                                SizedBox(width: 18.w),
                        Expanded(
                            child: customBox(
                                Color(0xffF77163), "30", "Active Orders","box2")),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                            child: customBox(
                                Color(0xff1FB6F3), "70", "Delivered Orders","box3")),
                                SizedBox(width: 18.w),
                        Expanded(
                            child: customBox(
                                Color(0xffFF9056), "100", "Total Customers","box4")),
                      ],
                    ),
                  ),
                    Container(
                          margin: EdgeInsets.symmetric(horizontal: 8.w,vertical: 15.h),
                      alignment: Alignment.centerLeft,
                      child: Text("Current Order",  style: TextStyle(
                                      fontSize: 24.sp,
                                      color:  Color(0xff101010),
                                      fontWeight: FontWeight.w600,
                                    ),),
                    ),
                    Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: CustomTextField(
                  prefixIcon: true,
                    onChanged: (value) {
                      
                    },

                    margin: false,
                    hintText: "Search..."),
              ),
              
              OrderItem(),
              OrderItem(),
              OrderItem(),
              OrderItem(),
                ],
              ),
            ),
            floatingActionButton: SizedBox(
              height: 70.h,
              width: 70.w,
              child: FloatingActionButton(onPressed: () {
                
              },child: Icon(Icons.add,size: 35.sp),backgroundColor: Color(0xffFF9056)),
            ),
        );
  }
}

Widget customBox(Color txcolor, String text1, String text2,String image) {
  return Container(
    padding: EdgeInsets.only(top: 30.h, bottom: 30.h, left: 15.w),
    
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(8), color: txcolor),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/$image.svg",
              fit: BoxFit.cover,
              height: 30.h,
              width: 30.w,
            ),
            SizedBox(width: 8.w),
            Text(
              text1,
              style: textFieldStyle(color: Colors.white, fontSize: 22.sp),
            )
          ],
        ),
        SizedBox(height: 14.h),
        Text(
          text2,
          style: textFieldStyle(color: Colors.white, fontSize: 18.sp),
        )
      ],
    ),
  );
}


