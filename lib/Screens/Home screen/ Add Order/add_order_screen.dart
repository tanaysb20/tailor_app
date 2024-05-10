import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/pattern_modal.dart';
import 'package:tailor_app/Modals/product_modal.dart';
import 'package:tailor_app/Providers/home_provider.dart';
import 'package:tailor_app/Reusable%20components/custom_button.dart';
import 'package:tailor_app/Reusable%20components/dropdown.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';
import 'package:tailor_app/Screens/landing_screen.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool save = true;
  TextEditingController invoiceController = TextEditingController();

  ////// Inputs

  TextEditingController productTypeController = TextEditingController();

  String deliveryDate = "";
  bool loading = false;
  bool show = false;

  ///////// Inputs

  ////////////
  void clear() {
    save = true;
    Provider.of<HomeProvider>(context, listen: false).addOrderItemList = [];
    Provider.of<HomeProvider>(context, listen: false).increaseOrder();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    clear();
    Provider.of<HomeProvider>(context, listen: false).getCity().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<HomeProvider>(context, listen: true);

    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: Scaffold(
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
                    SizedBox(width: 8.w),
                    Text(
                      "Add Order",
                      style: TextStyle(
                        fontSize: 24.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 50.h,
                      width: 180.w,
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: CustomButtonScreen(
                          text1: "Add Product +",
                          check: true,
                          bgcolor: Color(0xffFF7126),
                          fun: () async {
                            item.increaseOrder();
                          },
                          color: Colors.white,
                          width: 400.w,
                          radius: 40),
                    ),
                  ])),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 19.w, right: 10.w, bottom: 42.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      //// first heading
                      Row(
                        children: [
                          Text(
                            "Order No.#${item.orderNumber}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: CustomTextField(
                              controller: invoiceController,
                              margin: false,
                              textColor: Color.fromARGB(255, 0, 13, 24),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Invoice no. can\'t be empty';
                                }
                                return null;
                              },
                              txKeyboardType: TextInputType.number,
                              hintText: "Enter Invoice No",
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 30.h),

                      ...(item.addOrderItemList).map((e) {
                        return Column(
                          children: [
                            //// Dropdown heading
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: 5.w, bottom: 20.h),
                                    child: DropdownInput(
                                      isMargin: false,
                                      value: e.selectedProduct.name.isEmpty
                                          ? "Select Product"
                                          : e.selectedProduct.name,
                                      isEnabled: true,
                                      inputFieldWidth: double.infinity,
                                      items: item.productList
                                          .map((ProductModal value) {
                                        return DropdownMenuItem<String>(
                                          value: value.id,
                                          child: Text(value.name),
                                        );
                                      }).toList(),
                                      onChanged: (value) async {
                                        print(value);
                                        ProductModal selectproduct = item
                                            .productList
                                            .firstWhere((element) =>
                                                element.id == value);

                                        e.selectedProduct = selectproduct;
                                        setState(() {
                                          loading = true;
                                        });
                                        await item.getPatterns(value);
                                        e.patternList = item.patternList;
                                        setState(() {
                                          loading = false;
                                        });
                                        show = true;
                                        // print("$value vauejnka");

                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 20.h, left: 10.w),
                                  width: 30.w,
                                  child: InkWell(
                                      onTap: () {
                                        item.deleteOrder(e.id);
                                      },
                                      child: Icon(Icons.delete,
                                          size: 30.sp, color: Colors.red)),
                                )
                              ],
                            ),
                            if (e.patternList!.isNotEmpty)
                              MultiSelectDropDown<dynamic>(
                                controller: e.patternController,
                                onOptionSelected: (selectedOptions) {
                                  log("${e.selectedPattern.length}");
                                  e.selectedPattern = selectedOptions;
                                  setState(() {});
                                },
                                options:
                                    e.patternList!.map((PatternModal value) {
                                  return ValueItem(
                                      label: value.name, value: value.id);
                                }).toList(),
                                selectionType: SelectionType.multi,
                                borderColor: Color(0xffFF7126),
                                hint: "Select Pattern",
                                borderRadius: 8,
                                focusedBorderColor: Color(0xffFF7126),
                                hintStyle: textFieldStyle1111(
                                    color: Colors.black, fontSize: 23.sp),
                                chipConfig:
                                    const ChipConfig(wrapType: WrapType.wrap),
                                dropdownHeight: 300,
                                optionTextStyle: TextStyle(fontSize: 16.sp),
                                selectedOptionIcon:
                                    const Icon(Icons.check_circle),
                              ),
                            SizedBox(height: 40.h),
                            if (e.selectedProduct.type == "1")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Top Measurement",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.lengthController,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          txKeyboardType: TextInputType.number,
                                          hintText: "length",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.shoulderController,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sholder",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller:
                                              e.seleeveLength1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sleeve length 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller:
                                              e.seleeveLength2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sleeve length 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller:
                                              e.seleeveLength3Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sleeve length 3",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.chest1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "chest 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.chest2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "chest 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.stomach1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Stomach 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.stomach2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Stomach 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.hips1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Hips 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.hips2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Hips 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.neck1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Neck 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.neck2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Neck 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.detailsController,
                                          margin: false,
                                          maxCheck: 2,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Details",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.qtyController,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Qty",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xffFF7126)),
                                              onPressed: () async {
                                                final DateTime? picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (picked != null) {
                                                  deliveryDate =
                                                      DateFormat('dd-MM-yy')
                                                          .format(picked);

                                                  setState(() {});
                                                  // controller?.value = TextEditingValue(text: DateFormat('dd-MM-yyyy').format(picked).toString());
                                                }
                                              },
                                              child: Text(
                                                deliveryDate.isEmpty
                                                    ? "Select Delivery Date"
                                                    : deliveryDate,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Sora",
                                                  fontSize: deliveryDate.isEmpty
                                                      ? 14.sp
                                                      : 19.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ))),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                ],
                              ),
                            if (e.selectedProduct.type == "2")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bottom Measurement",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomHalfLength1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom half form length 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomHalfLength2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom half form length 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottom1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottom2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomlength,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom length",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.knee1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Knee 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.knee2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Knee 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.thigh1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Thigh 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.thigh2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Thigh 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.waist1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Waist 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.waist2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Waist 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomhips,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom hips",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.detailsController,
                                          margin: false,
                                          maxCheck: 2,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Details",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.qtyController,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Qty",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xffFF7126)),
                                              onPressed: () async {
                                                final DateTime? picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (picked != null) {
                                                  deliveryDate =
                                                      DateFormat('dd-MM-yy')
                                                          .format(picked);

                                                  setState(() {});
                                                  // controller?.value = TextEditingValue(text: DateFormat('dd-MM-yyyy').format(picked).toString());
                                                }
                                              },
                                              child: Text(
                                                deliveryDate.isEmpty
                                                    ? "Select Delivery Date"
                                                    : deliveryDate,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Sora",
                                                  fontSize: deliveryDate.isEmpty
                                                      ? 14.sp
                                                      : 19.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ))),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                ],
                              ),
                            if (e.selectedProduct.type == "3")
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Top Measurement",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.lengthController,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "length",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.shoulderController,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sholder",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller:
                                              e.seleeveLength1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sleeve length 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller:
                                              e.seleeveLength2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sleeve length 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller:
                                              e.seleeveLength3Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "sleeve length 3",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.chest1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "chest 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.chest2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "chest 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.stomach1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Stomach 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.stomach2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Stomach 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.hips1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Hips 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.hips2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Hips 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.neck1Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Neck 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.neck2Controller,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Neck 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Text(
                                    "Bottom Measurement",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 20.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomHalfLength1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom half form length 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomHalfLength2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom half form length 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottom1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottom2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomlength,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom length",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.knee1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Knee 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.knee2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Knee 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.thigh1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Thigh 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.thigh2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Thigh 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.waist1,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Waist 1",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.waist2,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Waist 2",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.bottomhips,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Bottom hips",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.detailsController,
                                          margin: false,
                                          maxCheck: 2,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Details",
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextField(
                                          controller: e.qtyController,
                                          margin: false,
                                          textColor:
                                              Color.fromARGB(255, 0, 13, 24),
                                          // validator: (value) {
                                          //   if (value == null || value.isEmpty) {
                                          //     return 'Mobile number can\'t be empty';
                                          //   }
                                          //   return null;
                                          // },
                                          txKeyboardType: TextInputType.number,
                                          hintText: "Qty",
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xffFF7126)),
                                              onPressed: () async {
                                                final DateTime? picked =
                                                    await showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime(2000),
                                                  lastDate: DateTime(2101),
                                                );
                                                if (picked != null) {
                                                  deliveryDate =
                                                      DateFormat('dd-MM-yy')
                                                          .format(picked);

                                                  setState(() {});
                                                  // controller?.value = TextEditingValue(text: DateFormat('dd-MM-yyyy').format(picked).toString());
                                                }
                                              },
                                              child: Text(
                                                deliveryDate.isEmpty
                                                    ? "Select Delivery Date"
                                                    : deliveryDate,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Sora",
                                                  fontSize: deliveryDate.isEmpty
                                                      ? 14.sp
                                                      : 19.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ))),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
                                ],
                              ),
                            SizedBox(height: 20.h),
                            Divider(thickness: 3),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }).toList(),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        height: 80.h,
                        child: CustomButtonScreen(
                            text1: "Submit",
                            check: true,
                            bgcolor: Color(0xffFF7126),
                            fun: () async {
                              if (_formKey.currentState!.validate()) {
                                if (save) {}

                                EasyLoading.show(
                                    maskType: EasyLoadingMaskType.black);

                                bool check = await item.addOrder(
                                    item.orderId, invoiceController.value.text);

                                EasyLoading.dismiss();
                                if (check) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return LandingScreen();
                                    },
                                  ));
                                }
                              }
                            },
                            color: Colors.white,
                            width: 400.w,
                            radius: 40),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}

class AddOrderModal {
  String id;
  ProductModal selectedProduct;
  List<PatternModal>? patternList = [];
  MultiSelectController<dynamic>? patternController;

  List<ValueItem<dynamic>> selectedPattern = [];
  TextEditingController? lengthController;
  TextEditingController? shoulderController;

  TextEditingController? seleeveLength1Controller;
  TextEditingController? seleeveLength2Controller;
  TextEditingController? seleeveLength3Controller;
  TextEditingController? chest1Controller;
  TextEditingController? chest2Controller;
  TextEditingController? stomach1Controller;
  TextEditingController? stomach2Controller;
  TextEditingController? hips1Controller;
  TextEditingController? hips2Controller;
  TextEditingController? neck1Controller;
  TextEditingController? neck2Controller;
  TextEditingController? detailsController;
  TextEditingController? qtyController;
  TextEditingController? cityController;

  TextEditingController? bottomHalfLength1;
  TextEditingController? bottomHalfLength2;
  TextEditingController? bottom1;
  TextEditingController? bottom2;
  TextEditingController? bottomlength;
  TextEditingController? knee1;
  TextEditingController? knee2;
  TextEditingController? thigh1;
  TextEditingController? thigh2;
  TextEditingController? waist1;
  TextEditingController? waist2;
  TextEditingController? bottomhips;

  AddOrderModal({
    this.id = "",
    this.bottom1,
    this.patternController,
    this.neck1Controller,
    this.patternList,
    this.bottomHalfLength1,
    this.bottomHalfLength2,
    this.bottomhips,
    this.bottomlength,
    this.chest1Controller,
    this.chest2Controller,
    this.cityController,
    this.bottom2,
    this.detailsController,
    this.hips1Controller,
    this.hips2Controller,
    this.knee1,
    this.knee2,
    this.lengthController,
    this.neck2Controller,
    this.qtyController,
    required this.selectedPattern,
    required this.selectedProduct,
    this.seleeveLength1Controller,
    this.seleeveLength2Controller,
    this.seleeveLength3Controller,
    this.shoulderController,
    this.stomach1Controller,
    this.stomach2Controller,
    this.thigh1,
    this.thigh2,
    this.waist1,
    this.waist2,
  });
}
