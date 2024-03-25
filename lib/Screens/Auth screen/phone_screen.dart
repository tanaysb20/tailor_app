import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tailor_app/Reusable%20components/custom_button.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';
import 'package:tailor_app/Screens/Auth%20screen/otp_screen.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  TextEditingController mobileNumberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // final item = Provider.of<AuthProvider>(context, listen: true);
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70.h,
          backgroundColor: Colors.white,
          title: Text(
            "Let's Get Started",
            style: TextStyle(
              fontSize: 22.sp,
              color: const Color(0xffFF7126),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text("Please enter your Mobile number to Login",
                    style: textFieldStyle(
                        fontSize: 20.sp, color: Colors.grey.shade700)),
                SizedBox(height: 30.h),
                Text("Mobile Number",
                    style: textFieldStyle(
                        fontSize: 20.sp,
                        color: Colors.black)),
                SizedBox(height: 15.h),
                CustomTextField(
                  controller: mobileNumberController,
                  margin: false,
                  textColor: Color.fromARGB(255, 0, 13, 24),
                  prefix: "+91 | ",
                  maxlength: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Mobile number can\'t be empty';
                    } else if (value.length != 10) {
                      return 'Mobile number must be of 10 digits';
                    }
                    return null;
                  },
                  txKeyboardType: TextInputType.number,
                  hintText: "Enter your mobile Number",
                ),
                SizedBox(height: 70.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: CustomButtonScreen(
                      text1: "Send OTP",
                      check: true,
                      bgcolor: Color(0xffFF7126),
                      fun: () async {
                        // if (_formKey.currentState!.validate()) {
                        //   EasyLoading.show(maskType: EasyLoadingMaskType.black);
                        //   bool check = await item
                        //       .sendOtp(mobileNumberController.value.text);
                        //     EasyLoading.dismiss();
                        //   if (check) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return OtpScreen(mobileNumber: mobileNumberController.value.text);
                              },
                            ));
                        //   }
                        // } else {}
                      },
                      color: Colors.white,
                      width: 400.w,
                      radius: 40),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
