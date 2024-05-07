import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/customer_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';
import 'package:tailor_app/Reusable%20components/customer_item.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

class SelectCustomerListScreen extends StatefulWidget {
  const SelectCustomerListScreen({super.key});

  @override
  State<SelectCustomerListScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<SelectCustomerListScreen>
    with SingleTickerProviderStateMixin {
  int indexx = 0;
  int currentIndexx = 0;
  int tab = 1;
  int page = 1;

  DateTime? selectedDate;
  bool loading = false;

  List<CustomerModal> filterCustomerList = [];
  final PagingController<int, CustomerModal> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pagingController.addPageRequestListener((pageKey) {
      start(pageKey);
    });
  }

  Future start(int pageIndex) async {
    List<CustomerModal> orders =
        await Provider.of<HomeProvider>(context, listen: false)
            .getCustomer(page: pageIndex);
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

  void filterList(String query) {
    setState(() {
      filterCustomerList = Provider.of<HomeProvider>(context, listen: false)
          .customerList
          .where((item) =>
              item.phone_no.contains(query) ||
              item.name.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<HomeProvider>(context, listen: true);
    // final DateFormat formatterDate = DateFormat('MMMM, yyyy');
    return loading
        ? Center(
            child: CircularProgressIndicator(color: const Color(0xff112951)))
        : Scaffold(
            appBar: AppBar(
                toolbarHeight: 70.h,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                titleSpacing: 20.w,
                centerTitle: false,
                title: Row(children: [
                  Icon(Icons.arrow_back, color: Color(0xffFF7126), size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    "Select Existing Customer",
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ])),
            body: PagedListView<int, CustomerModal>(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<CustomerModal>(
                  itemBuilder: (context, item, index) {
                    print(index);
                    return Column(
                      children: [
                        if (index == 0) bodyWidget(context),
                        CustomerItem(
                          orderItem: item,
                          onTapx: () {
                            Navigator.pop(context, item);
                          },
                        ),
                      ],
                    );
                  },
                  firstPageProgressIndicatorBuilder: (_) => Column(
                        children: [
                          bodyWidget(context),
                          Container(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        ],
                      ),
                  noItemsFoundIndicatorBuilder: (_) => Column(
                        children: [bodyWidget(context)],
                      ),
                  newPageProgressIndicatorBuilder: (_) => Column(
                        children: [
                          Center(
                            child: CircularProgressIndicator(),
                          )
                        ],
                      )),
            ),
          );
  }
}

Widget customListView(BuildContext context, CustomerModal itemFile) {
  return InkWell(
    onTap: () async {
      //
    },
    child: Column(
      children: [
        ListTile(
          leading: CircleAvatar(
              child: SvgPicture.asset("assets/pic.svg"), radius: 26.sp),
          title: Text("${itemFile.name}",
              style: textFieldStyle(
                  fontSize: 19.sp,
                  color: const Color(0xff071245),
                  weight: FontWeight.w600)),
          subtitle: Container(
            margin: EdgeInsets.only(top: 6.h),
            child: Text("+91 ${itemFile.phone_no}",
                style: textFieldStyle(
                  fontSize: 17.sp,
                  color: Colors.grey.shade600,
                )),
          ),
        ),
        Divider(thickness: 1),
      ],
    ),
  );
}

Widget bodyWidget(BuildContext context) {
  final item = Provider.of<HomeProvider>(context, listen: false);
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 30.h),
      // item.trasactionList.isEmpty?
      // Padding(
      //   padding:  EdgeInsets.symmetric(vertical:  150.0.h),
      //   child: Center(child: Text("No Transaction Yet",
      //     style: textFieldStyle(
      //         fontSize: 24.sp,
      //         color: const Color(0xff112951),
      //         weight: FontWeight.w800)),),
      // ):

      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0.w),
        child: CustomTextField(
            prefixIcon: true,
            onChanged: (value) {},
            margin: false,
            hintText: "Search by Name or Mobile No."),
      ),
      SizedBox(height: 20.h),

      // filterCustomerList.isEmpty
      //     ? Text("Customer list is empty",
      //         style: textFieldStyle(
      //             fontSize: 19.sp,
      //             color: const Color(0xff071245),
      //             weight: FontWeight.w600))
      //     : ListView.builder(
      //         shrinkWrap: true,
      //         controller: ScrollController(keepScrollOffset: false),
      //         itemCount: filterCustomerList.length,
      //         itemBuilder: (context, index) {
      //           return customListView(
      //               context, filterCustomerList[index]);
      //         },
      //       )
    ],
  );
}
