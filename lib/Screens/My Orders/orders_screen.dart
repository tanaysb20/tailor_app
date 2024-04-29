import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
  // List<RelationModal> filterRelativesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // setState(() {
    //   loading =true;
    // });
    //  Provider.of<HomeProvider>(context, listen: false).getTransaction().then((value) {
    //   setState(() {
    //   loading =false;
    // });
    //  });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<HomeProvider>(context, listen: false);

    // final DateFormat formatterDate = DateFormat('MMMM, yyyy');
    return loading
        ? Center(
            child: CircularProgressIndicator(color: const Color(0xff112951)))
        : SingleChildScrollView(
            child: Column(
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
                        style: textFieldStyle(
                            fontSize: 18.sp, weight: FontWeight.w500),
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
                ListView.builder(
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  itemCount: item.orderList.length,
                  itemBuilder: (context, index) {
                    return OrderItem(orderItem: item.orderList[index]);
                  },
                )
              ],
            ),
          );
  }
}
