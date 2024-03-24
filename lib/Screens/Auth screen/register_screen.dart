// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:relation_app/Providers/auth_provider.dart';
// import 'package:relation_app/Reusable%20components/app_bar.dart';
// import 'package:relation_app/Reusable%20components/custom_button.dart';
// import 'package:relation_app/Reusable%20components/text_field.dart';
// import 'package:relation_app/Screens/landing_screen.dart';

// // ignore: must_be_immutable
// class RegisterScreen extends StatefulWidget {
//   String mobileNumber;
//   RegisterScreen({super.key, this.mobileNumber = ""});

//   @override
//   State<RegisterScreen> createState() => _OtpScreenState();
// }

// class _OtpScreenState extends State<RegisterScreen> {
//    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//     TextEditingController nameController = TextEditingController();
//     TextEditingController addressController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     final item = Provider.of<AuthProvider>(context, listen: true);
   
//     return Form(
//       key: _formKey,
//       child: Scaffold(
//         appBar: customAppBar(text: "Register with us"),
//         body: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 30.h),
//                 Text("Full Name",
//                     style: textFieldStyle(
//                       fontSize: 20.sp,
//                       color: Colors.grey.shade800,
//                     )),
//                 SizedBox(height: 10.h),
                
//                 CustomTextField(
//                   controller: nameController,
//                   margin: false,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Name can\'t be empty';
//                     }
//                     return null;
//                   },
//                   hintText: "Enter Full Name",
//                 ),
//                 SizedBox(height: 25.h),
//                 Text("Mobile Number",
//                     style: textFieldStyle(
//                       fontSize: 20.sp,
//                       color: Colors.grey.shade800,
//                     )),
//                 SizedBox(height: 10.h),
//                 CustomTextField(
//                   margin: false,
//                   controller: TextEditingController(text: widget.mobileNumber),
//                   isEnabled: false,
//                 ),
//                 SizedBox(height: 25.h),
//                 Text("Address",
//                     style: textFieldStyle(
//                       fontSize: 20.sp,
//                       color: Colors.grey.shade800,
//                     )),
//                 SizedBox(height: 10.h),
//                 CustomTextField(
//                   margin: false,
//                   controller: addressController,
//                   hintText: "Enter Address",
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Address be empty';
//                     }
//                     return null;
//                   },
//                   maxCheck: 3,
//                 ),
//                 SizedBox(height: 50.h),
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 6.0.w),
//                   child: CustomButtonScreen(
//                       text1: "Continue",
//                       check: true,
//                       bgcolor: Color(0xff0B30E0),
//                       fun: () async {
//                         // if (_formKey.currentState!.validate()) {
//                         //   EasyLoading.show(maskType: EasyLoadingMaskType.black);
//                         //   bool check = await item.updateProfile(
//                         //       nameController.value.text,
//                         //       addressController.value.text);
//                         //   EasyLoading.dismiss();
//                         //   if (check) {
//                             Navigator.of(context).push(MaterialPageRoute(
//                               builder: (context) {
//                                 return LandingScreen();
//                               },
//                             ));
//                         //   }
//                         // } else {}
//                       },
//                       color: Colors.white,
//                       width: 400.w,
//                       radius: 40),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
