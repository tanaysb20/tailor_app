import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/user_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';

class OrderDetailScreen extends StatefulWidget {
  OrderModal orderItem;
  OrderDetailScreen({super.key, required this.orderItem});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoading = true;
    });
    Provider.of<HomeProvider>(context, listen: false)
        .getOrderDetail(widget.orderItem.id)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<HomeProvider>(context, listen: false);
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
              "Order Details #${widget.orderItem.id}",
              style: TextStyle(
                fontSize: 24.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ])),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: const Color(0xff112951)))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      "Customer Name",
                      style:
                          TextStyle(color: Color(0xff757575), fontSize: 19.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.orderItem.cust_name,
                      style: TextStyle(color: Colors.black, fontSize: 21.sp),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Mobile Number",
                      style:
                          TextStyle(color: Color(0xff757575), fontSize: 19.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.orderItem.mobile_no,
                      style: TextStyle(color: Colors.black, fontSize: 21.sp),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Address",
                      style:
                          TextStyle(color: Color(0xff757575), fontSize: 19.sp),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      widget.orderItem.address,
                      style: TextStyle(color: Colors.black, fontSize: 21.sp),
                    ),
                    Divider(),
                    ...(item.selectedProductsItemDetail).map((e) {
                      return e.type == "1"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Text(
                                  e.product_name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Pattern",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  e.pattern_name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Length",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.length},",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Sholder",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.sholder},",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Sleeve Length",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.sleeve_length_1}, ${e.sleeve_length_2}, ${e.sleeve_length_3}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Chest",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.chest_1}, ${e.chest_2},",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Stomach",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.stomach_1}, ${e.stomach_2},",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Hips",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.hips_1}, ${e.hips_2},",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Neck",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.neck_1}, ${e.neck_2},",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Other Detail",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.other_detail}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.qty}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Delivery Date",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.delivery_date}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 30.h),
                                Divider(),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 20.h),
                                Text(
                                  e.product_name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Pattern",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  e.pattern_name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Other Detail",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.other_detail}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Quantity",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.qty}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Delivery Date",
                                  style: TextStyle(
                                      color: Color(0xff757575),
                                      fontSize: 19.sp),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  "${e.delivery_date}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 21.sp),
                                ),
                                SizedBox(height: 30.h),
                                Divider(),
                              ],
                            );
                    }).toList(),
                  ],
                ),
              ),
            ),
    );
  }
}
