import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

import '../../Modals/relatives_modal.dart';

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
  
  DateTime? selectedDate;
  bool loading = false;

  List<RelationModal> customerList = [
    RelationModal(
        id: "1",
        image: "",
        name: "Saif",
        phonenos: "9602901242",
        relation: ""
        ),
    RelationModal(
        id: "2",
        image: "",
        name: "Sameer",
        phonenos: "741408000",
        relation: ""
        ),
    RelationModal(
        id: "3",
        image: "",
        name: "Ravi",
        phonenos: "9829244470",
        relation: ""
        ),
    RelationModal(
        id: "4",
        image: "",
        name: "Nitin",
        phonenos: "9414063031",
        relation: ""
        ),
  ];
  List<RelationModal> filterCustomerList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterCustomerList = customerList;

    // setState(() {
    //   loading =true;
    // });
    //  Provider.of<HomeProvider>(context, listen: false).getTransaction().then((value) {
    //   setState(() {
    //   loading =false;
    // });
    //  });
  }

  void filterList(String query) {
    setState(() {
      filterCustomerList = customerList
          .where((item) =>
              item.phonenos!.contains(query) || item.name.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void dispose() {
    

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final item = Provider.of<HomeProvider>(context, listen: true);
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
                    onChanged: (value) {
                      filterList(value);
                    },

                    margin: false,
                    hintText: "Search by Name or Mobile No."),
              ),
              SizedBox(height: 20.h),

              ListView.builder(
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

Widget customListView(BuildContext context, RelationModal itemFile) {
  return InkWell(
    onTap: () async {
       
    },
    child: Column(
      children: [
        ListTile(
          leading: CircleAvatar(
              child: SvgPicture.asset("assets/pic.svg"),
              radius: 30.sp),
          title: Text("${itemFile.name}",
              style: textFieldStyle(
                  fontSize: 21.sp,
                  color: const Color(0xff071245),
                  weight: FontWeight.w600)),
          subtitle: Container(
            margin: EdgeInsets.only(top: 6.h),
            child: Text("+91 ${itemFile.phonenos}",
                style: textFieldStyle(
                  fontSize: 18.sp,
                  color: Colors.grey.shade600,
                )),
          ),
        
        ),
        Divider(thickness: 1),
      ],
    ),
  );
}
