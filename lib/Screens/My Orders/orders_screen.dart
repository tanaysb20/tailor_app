import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/user_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';
import 'package:tailor_app/Reusable%20components/dropdown.dart';
import 'package:tailor_app/Reusable%20components/order_item.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

class RelativesScreen extends StatefulWidget {
  const RelativesScreen({super.key});

  @override
  State<RelativesScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<RelativesScreen>
    with SingleTickerProviderStateMixin {
  int indexx = 0;
  int currentIndexx = 0;
  int tab = 1;
  DateTime? selectedDate;
  bool loading = false;
  TextEditingController sortDropDownController = TextEditingController();

  List<String> relativesList = [
    "Ordered",
    "Ready for delivery",
    "For delivered",
  ];

  final PagingController<int, OrderModal> pagingController =
      PagingController(firstPageKey: 1);

  // List<RelationModal> filterRelativesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      getOrders(pageKey);
    });
    // setState(() {
    //   loading =true;
    // });
    //  Provider.of<HomeProvider>(context, listen: false).getTransaction().then((value) {
    //   setState(() {
    //   loading =false;
    // });
    //  });
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

  @override
  Widget build(BuildContext context) {
    // final item = Provider.of<HomeProvider>(context, listen: false);

    // final DateFormat formatterDate = DateFormat('MMMM, yyyy');
    return loading
        ? Center(
            child: CircularProgressIndicator(color: const Color(0xff112951)))
        : RefreshIndicator(
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
          );
  }

  Widget bodyWidget() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(right: 20.w, top: 20.h),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Sort by :",
                style: textFieldStyle(fontSize: 18.sp, weight: FontWeight.w500),
              ),
              SizedBox(width: 10.w),
              Container(
                // margin: EdgeInsets.symmetric(
                //     vertical: 14.h, horizontal: 14.w),
                width: 260.w,

                child: DropdownInput(
                  isMargin: false,
                  // validatorsss: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Relationship can\'t be empty';
                  //   }
                  //   return null;
                  // },
                  // controller: relationshipDropdownController,
                  value: sortDropDownController.value.text.isEmpty
                      ? "Select Order Type"
                      : sortDropDownController.value.text,

                  // labelText: "Select Description Of Goods",
                  // value: consajda.value.text,

                  isEnabled: true,
                  inputFieldWidth: double.infinity,
                  items: relativesList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
        // ListView.builder(
        //   shrinkWrap: true,
        //   controller: ScrollController(keepScrollOffset: false),
        //   itemCount: item.orderList.length,
        //   itemBuilder: (context, index) {
        //     return OrderItem(orderItem: item.orderList[index]);
        //   },
        // )
      ],
    );
  }
}
