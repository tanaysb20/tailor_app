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

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddOrderScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool save = true;
  TextEditingController productController = TextEditingController();
  TextEditingController patternController = TextEditingController();
  TextEditingController productTypeController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController shoulderController = TextEditingController();
  TextEditingController seleeveLength1Controller = TextEditingController();
  TextEditingController seleeveLength2Controller = TextEditingController();
  TextEditingController seleeveLength3Controller = TextEditingController();
  TextEditingController chest1Controller = TextEditingController();
  TextEditingController chest2Controller = TextEditingController();
  TextEditingController stomach1Controller = TextEditingController();
  TextEditingController stomach2Controller = TextEditingController();
  TextEditingController hips1Controller = TextEditingController();
  TextEditingController hips2Controller = TextEditingController();
  TextEditingController neck1Controller = TextEditingController();
  TextEditingController neck2Controller = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  String deliveryDate = "";
  bool loading = false;
  bool show = false;

  //// Inputs

  ProductModal selectedProduct = ProductModal(id: "", name: "", type: "");

  List<ValueItem<dynamic>> selectedPattern = [];

  /////
  void clear() {
    save = true;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      loading = true;
    });
    Provider.of<HomeProvider>(context, listen: false).getCity().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<HomeProvider>(context, listen: false);
    log("${selectedPattern.length} selected");
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
                  ])),
              body: SingleChildScrollView(
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 19.w, right: 10.w, bottom: 42.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 25.h),
                      Container(
                        margin: EdgeInsets.only(left: 5.w, bottom: 20.h),
                        child: DropdownInput(
                          isMargin: false,

                          value: selectedProduct.name.isEmpty
                              ? "Select Product"
                              : selectedProduct.name,

                          // value: consajda.value.text,

                          isEnabled: true,
                          inputFieldWidth: double.infinity,
                          items: item.productList.map((ProductModal value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),

                          onChanged: (value) async {
                            print(value);
                            ProductModal selectproduct = item.productList
                                .firstWhere((element) => element.id == value);

                            selectedProduct = selectproduct;
                            setState(() {
                              loading = true;
                            });
                            await item.getPatterns(value);
                            setState(() {
                              loading = false;
                            });
                            show = true;
                            // print("$value vauejnka");

                            setState(() {});
                          },
                        ),
                      ),
                      if (show)
                        MultiSelectDropDown<dynamic>(
                          onOptionSelected: (selectedOptions) {
                            selectedPattern = selectedOptions;
                            setState(() {});
                          },
                          options: item.patternList.map((PatternModal value) {
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
                          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
                          dropdownHeight: 300,
                          optionTextStyle: TextStyle(fontSize: 16.sp),
                          selectedOptionIcon: const Icon(Icons.check_circle),
                        ),
                      SizedBox(height: 40.h),
                      if (selectedProduct.type == "1")
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
                                    controller: lengthController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "length",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: shoulderController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "sleeve length 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: seleeveLength2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength3Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: chest1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "chest 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: chest2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: stomach1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Stomach 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: stomach2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: hips1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Hips 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: hips2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: neck1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Neck 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: neck2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: detailsController,
                                    margin: false,
                                    maxCheck: 2,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: qtyController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Qty",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffFF7126)),
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
                      if (selectedProduct.type == "2")
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
                                    controller: lengthController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Bottom half form length 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: shoulderController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Bottom 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: seleeveLength2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength3Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: chest1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Knee 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: chest2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: stomach1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Thigh 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: stomach2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: hips1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Waist 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: hips2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: neck1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: detailsController,
                                    margin: false,
                                    maxCheck: 2,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: qtyController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Qty",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffFF7126)),
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
                      if (selectedProduct.type == "3")
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
                                    controller: lengthController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "length",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: shoulderController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "sleeve length 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: seleeveLength2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength3Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: chest1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "chest 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: chest2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: stomach1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Stomach 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: stomach2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: hips1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Hips 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: hips2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: neck1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Neck 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: neck2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: lengthController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Bottom half form length 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: shoulderController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Bottom 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: seleeveLength2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: seleeveLength3Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: chest1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Knee 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: chest2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: stomach1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Thigh 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: stomach2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: hips1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Waist 1",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: CustomTextField(
                                    controller: hips2Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: neck1Controller,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: detailsController,
                                    margin: false,
                                    maxCheck: 2,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
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
                                    controller: qtyController,
                                    margin: false,
                                    textColor: Color.fromARGB(255, 0, 13, 24),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Mobile number can\'t be empty';
                                      }
                                      return null;
                                    },
                                    txKeyboardType: TextInputType.number,
                                    hintText: "Qty",
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xffFF7126)),
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
                      SizedBox(height: 40.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                        height: 80.h,
                        child: CustomButtonScreen(
                            text1: "Next",
                            check: true,
                            bgcolor: Color(0xffFF7126),
                            fun: () async {
                              if (_formKey.currentState!.validate()) {
                                if (save) {}

                                EasyLoading.show(
                                    maskType: EasyLoadingMaskType.black);

                                // bool check = await item.sendOtp(
                                //     mobileNumberController.value.text,
                                //     passwordController.value.text);
                                EasyLoading.dismiss();
                                //   if (check) {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return AddOrderScreen();
                                  },
                                ));
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
