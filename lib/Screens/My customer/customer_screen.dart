import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pagination_flutter/pagination.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/customer_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';
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

  DateTime? selectedDate;
  bool loading = false;

  List<CustomerModal> filterCustomerList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    start();
  }

  Future start() async {
    setState(() {
      loading = true;
    });
    Provider.of<HomeProvider>(context, listen: false)
        .getCustomer(page)
        .then((value) {
      setState(() {
        loading = false;
      });
      filterCustomerList =
          Provider.of<HomeProvider>(context, listen: false).customerList;
    });
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
        : SingleChildScrollView(
            child: Column(
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
                      onChanged: (value) {
                        filterList(value);
                      },
                      margin: false,
                      hintText: "Search by Name or Mobile No."),
                ),
                SizedBox(height: 20.h),

                Pagination(
                  numOfPages: item.lastPage!,
                  selectedPage: page,
                  pagesVisible: 4,
                  onPageChanged: (txpage) {
                    print(txpage);
                    page = txpage;
                    start();
                    setState(() {});
                  },
                  inactiveBtnStyle: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(38),
                    )),
                  ),
                  inactiveTextStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  nextIcon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue,
                    size: 14,
                  ),
                  previousIcon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.blue,
                    size: 14,
                  ),
                  activeTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                  activeBtnStyle: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(38),
                      ),
                    ),
                  ),
                ),

                filterCustomerList.isEmpty
                    ? Text("Customer list is empty",
                        style: textFieldStyle(
                            fontSize: 19.sp,
                            color: const Color(0xff071245),
                            weight: FontWeight.w600))
                    : ListView.builder(
                        shrinkWrap: true,
                        controller: ScrollController(keepScrollOffset: false),
                        itemCount: filterCustomerList.length,
                        itemBuilder: (context, index) {
                          return customListView(
                              context, filterCustomerList[index]);
                        },
                      )
              ],
            ),
          );
  }
}

Widget customListView(BuildContext context, CustomerModal itemFile) {
  return Column(
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
  );
}
