import 'package:flutter/material.dart';

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
            
            ],
          ),
        );
  }
}
