import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Modals/city_modal.dart';
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

  List<String> productType = [
    "Top",
    "Bottom",
    "Both",
  ];

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
                        height: 80.h,
                        margin: EdgeInsets.only(left: 5.w, bottom: 20.h),
                        child: DropdownInput(
                          isMargin: false,
                          controller: productController,

                          value: "Select Product",
                          // value: consajda.value.text,

                          isEnabled: true,
                          inputFieldWidth: double.infinity,
                          items: item.productList.map((ProductModal value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            print(value);
                            // print("$value vauejnka");

                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        height: 80.h,
                        margin: EdgeInsets.only(left: 5.w, bottom: 20.h),
                        child: DropdownInput(
                          isMargin: false,
                          controller: patternController,

                          value: "Select Pattern",
                          // value: consajda.value.text,

                          isEnabled: true,
                          inputFieldWidth: double.infinity,
                          items: item.productList.map((ProductModal value) {
                            return DropdownMenuItem<String>(
                              value: value.id,
                              child: Text(value.name),
                            );
                          }).toList(),
                          onChanged: (value) {
                            print(value);
                            // print("$value vauejnka");

                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        height: 80.h,
                        margin: EdgeInsets.only(left: 5.w, bottom: 20.h),
                        child: DropdownInput(
                          isMargin: false,
                          controller: productTypeController,

                          value: "Select Product Type",
                          // value: consajda.value.text,

                          isEnabled: true,
                          inputFieldWidth: double.infinity,
                          items: productType.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            productTypeController =
                                TextEditingController(text: value);
                            print(value);
                            // print("$value vauejnka");

                            setState(() {});
                          },
                        ),
                      ),

                      // Container(
                      //   height: 80.h,
                      //   margin: EdgeInsets.only(bottom: 20.h),
                      //   child: DropdownInput(
                      //     isMargin: false,
                      //     controller: cityController,

                      //     value: "Select City",
                      //     isEnabled: true,
                      //     // value: consajda.value.text,

                      //     inputFieldWidth: double.infinity,
                      //     items: item.cityList.map((CityModal value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value.cityName,
                      //         child: Text(value.cityName),
                      //       );
                      //     }).toList(),
                      //     onChanged: (value) {
                      //       print(value + "vallluuee");
                      //       cityController = TextEditingController(text: value);
                      //       // print("$value vauejnka");

                      //       setState(() {});
                      //     },
                      //   ),
                      // ),

                      if (productTypeController.value.text == "Top")
                        Column(
                          children: [
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
                                            primary: Color(0xffFF7126)),
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
                      if (productTypeController.value.text == "Bottom")
                        Column(
                          children: [
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
                                            primary: Color(0xffFF7126)),
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
                      if (productTypeController.value.text == "Both")
                        Column(
                          children: [
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
                                            primary: Color(0xffFF7126)),
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
