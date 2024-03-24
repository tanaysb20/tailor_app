import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

import '../../Modals/relatives_modal.dart';

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

  List<RelationModal> relativesList = [
    RelationModal(
        id: "1",
        image: "",
        name: "Tanay",
        phonenos: "9602901242",
        relation: "Child"),
    RelationModal(
        id: "2",
        image: "",
        name: "Saksham",
        phonenos: "741408000",
        relation: "Child"),
    RelationModal(
        id: "3",
        image: "",
        name: "Vinod",
        phonenos: "9829244470",
        relation: "Father"),
    RelationModal(
        id: "4",
        image: "",
        name: "Babita",
        phonenos: "9414063031",
        relation: "Mother"),
  ];
  List<RelationModal> filterRelativesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filterRelativesList = relativesList;

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
      filterRelativesList = relativesList
          .where((item) =>
              item.phonenos!.contains(query) || item.name!.contains(query))
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
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: CustomTextField(
                            onChanged: (value) {
                              filterList(value);
                            },

                            margin: false,
                            hintText: "Search by Name or Mobile No.")),
                    SizedBox(width: 2.w),
                    SizedBox(width: 15.w),
                    InkWell(
                        onTap: () async {}, child: Icon(Icons.filter_list)),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                itemCount: filterRelativesList.length,
                itemBuilder: (context, index) {
                  return customListView(
                      context, filterRelativesList[index]);
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
          trailing: Text("${itemFile.relation}",
              style: textFieldStyle(
                  fontSize: 18.sp,
                  color: const Color(0xff6C728D),
                  weight: FontWeight.w600)),
        ),
        Divider(thickness: 1),
      ],
    ),
  );
}
