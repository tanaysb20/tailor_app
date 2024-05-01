import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/user_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';
import 'package:tailor_app/Reusable%20components/order_item.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';
import 'package:tailor_app/Screens/Home%20screen/%20Add%20Order/add_customer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int indexx = 0;
  TextEditingController search = TextEditingController();
  int currentIndexx = 0;
  int tab = 1;

  TextEditingController couponCodeController = TextEditingController();
  bool loading = false;
  final PagingController<int, OrderModal> pagingController =
      PagingController(firstPageKey: 1);

  //  QRViewController? controller;
  //  Barcode? result;
  String result = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      getOrders(pageKey);
    });
  }

  Future<void> getOrders(int pageIndex) async {
    print(pageIndex);
    List<OrderModal> orders =
        await Provider.of<HomeProvider>(context, listen: false)
            .getOrders(page: pageIndex);
    if (orders.isNotEmpty) {
      // currentPage = currentPage + 1;
      final isLastPage = orders.length < 30;
      if (isLastPage) {
        pagingController.appendLastPage(orders ?? []);
      } else {
        final nextPageKey = pageIndex + 1;
        pagingController.appendPage(orders, nextPageKey);
      }
    }
    loading = false;
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
    // final item = Provider.of<HomeProvider>(context, listen: false);
    return loading
        ? Center(
            child: CircularProgressIndicator(color: const Color(0xff193F80)))
        : Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                pagingController.refresh();
              },
              child: PagedListView<int, OrderModal>(
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<OrderModal>(
                    itemBuilder: (context, item, index) {
                      print(index);
                      return Column(
                        children: [
                          if (index == 0) bodyWidget(),
                          OrderItem(orderItem: item),
                        ],
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) => Column(
                          children: [
                            bodyWidget(),
                            Container(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          ],
                        ),
                    noItemsFoundIndicatorBuilder: (_) => Column(
                          children: [bodyWidget()],
                        ),
                    newPageProgressIndicatorBuilder: (_) => Column(
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            )
                          ],
                        )),
              ),
            ),
            floatingActionButton: SizedBox(
              height: 70.h,
              width: 70.w,
              child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return AddCustomerScreen();
                      },
                    ));
                  },
                  child: Icon(Icons.add, size: 35.sp),
                  backgroundColor: Color(0xffFF9056)),
            ),
          );
  }

  Widget bodyWidget() {
    final item = Provider.of<HomeProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 25.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Expanded(
                  child: customBox(Color(0xff5F67EC),
                      item.totalOrders.toString(), "Total Orders", "box1")),
              SizedBox(width: 18.w),
              Expanded(
                  child: customBox(Color(0xffF77163),
                      item.activeOrders.toString(), "Active Orders", "box2")),
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
                      Color(0xff1FB6F3),
                      item.deliveredOrders.toString(),
                      "Delivered Orders",
                      "box3")),
              SizedBox(width: 18.w),
              Expanded(
                  child: customBox(
                      Color(0xffFF9056),
                      item.totalCustomer.toString(),
                      "Total Customers",
                      "box4")),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 15.h),
          alignment: Alignment.centerLeft,
          child: Text(
            "Current Order",
            style: TextStyle(
              fontSize: 24.sp,
              color: Color(0xff101010),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: CustomTextField(
              prefixIcon: true,
              controller: search,
              onChanged: (value) {},
              margin: false,
              hintText: "Search..."),
        ),
      ],
    );
  }
}

Widget customBox(Color txcolor, String text1, String text2, String image) {
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
