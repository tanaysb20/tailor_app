import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/customer_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';
import 'package:tailor_app/Reusable%20components/customer_item.dart';
import 'package:tailor_app/Reusable%20components/debouncer.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<CustomerScreen>
    with SingleTickerProviderStateMixin {
  int indexx = 0;
  int currentIndexx = 0;
  int tab = 1;
  int page = 1;
  TextEditingController search = TextEditingController();
  DateTime? selectedDate;
  bool loading = false;

  final PagingController<int, CustomerModal> pagingController =
      PagingController(firstPageKey: 1);

  final _debouncer = Debouncer(milliseconds: 900);

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
            .getCustomer(page: pageIndex, search: search.text);
    if (orders.isNotEmpty) {
      // currentPage = currentPage + 1;
      final isLastPage = orders.length < 30;
      if (isLastPage) {
        pagingController.appendLastPage(orders ?? []);
      } else {
        final nextPageKey = pageIndex + 1;
        pagingController.appendPage(orders, nextPageKey);
      }
    } else {
      pagingController.appendLastPage(orders ?? []);
    }
    loading = false;
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
        : PagedListView<int, CustomerModal>(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<CustomerModal>(
                itemBuilder: (context, item, index) {
                  print(index);
                  return Column(
                    children: [
                      if (index == 0) bodyWidget(context),
                      CustomerItem(orderItem: item),
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
              controller: search,
              onChanged: (value) {
                _debouncer.run(() {
                  pagingController.refresh();
                });
              },
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
}
