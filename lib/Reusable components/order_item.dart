import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

// ignore: must_be_immutable
class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 6.h),
      child: Card(
         shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),),
        // margin: EdgeInsets.symmetric(horizontal: 4.w,vertical: 10.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 20.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                children: [
                  Text(
                    "#165432 (Karan Chauhan)",
                    style: textFieldStyle(fontSize: 18.sp,weight: FontWeight.w500),
                  ),
                  Spacer(),
                  CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 6, 118, 9),
                      radius: 8),
                  SizedBox(width: 4.w),
                  Text(
                    "Active",
                    style: textFieldStyle(fontSize: 18.sp),
                  ),
                  SizedBox(width: 8.w),
                  Icon(Icons.arrow_forward_ios,
                      size: 18.sp, color: Color(0xffFF7126))
                ],
              ),
              SizedBox(height: 14.h),
              Divider(thickness: 2),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Mobile Number",
                          style: textFieldStyle(
                              color: Color(0xff757575), fontSize: 17.sp,weight: FontWeight.w400)),
                      SizedBox(height: 8.h),
                      Text("9624966952",
                          style: textFieldStyle(
                              color: Color(0xff101010), fontSize: 17.sp)),
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Deliverable Date",
                          style: textFieldStyle(
                              color: Color(0xff757575), fontSize: 17.sp,weight: FontWeight.w400)),
                      SizedBox(height: 8.h),
                      Text("22 Apr 2022",
                          style: textFieldStyle(
                              color: Color(0xff101010), fontSize: 17.sp)),
                    ],
                  )
                ],
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }
}
