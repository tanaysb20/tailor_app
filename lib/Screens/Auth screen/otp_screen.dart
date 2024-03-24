
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tailor_app/Providers/auth_provider.dart';
import 'package:tailor_app/Reusable%20components/app_bar.dart';
import 'package:tailor_app/Reusable%20components/custom_button.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';
import 'package:tailor_app/Screens/landing_screen.dart';

// ignore: must_be_immutable
class OtpScreen extends StatefulWidget {
  String mobileNumber;
  OtpScreen({super.key, this.mobileNumber = ""});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final item = Provider.of<AuthProvider>(context, listen: true);

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: customAppBar(text: "OTP Verification"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Enter 4 digit code we just texted to your Mobile number",
                        style: textFieldStyle(
                          fontSize: 20.sp,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      TextSpan(
                        text: "  +91 ${widget.mobileNumber}",
                        style: textFieldStyle(
                            fontSize: 20.sp,
                            color: const Color(0xffFF7126),
                            weight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                OtpTextField(
                  fieldWidth: 80.w,
                  numberOfFields: 4,
                  textStyle: textFieldStyle(
                      color: Colors.black,
                      fontSize: 24.sp,
                      weight: FontWeight.bold),
                  borderColor: const Color(0xffFF7126),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {},
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {
                    print('$verificationCode tanayveru');
                    otp = verificationCode;
                    setState(() {});
                  }, // end onSubmit
                ),
                SizedBox(height: 70.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  child: CustomButtonScreen(
                      text1: "Verify",
                      check: true,
                      bgcolor: Color(0xffFF7126),
                      fun: () async {
                        // if (_formKey.currentState!.validate()) {
                        //   EasyLoading.show(maskType: EasyLoadingMaskType.black);
                        //   bool check =
                        //       await item.validateOtp(widget.mobileNumber, otp);
                        //   EasyLoading.dismiss();
                        //   if (check) {
                        //     if (item.userAvailable == "true") {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) {
                        //           return LandingScreen();
                        //         },
                        //       ));
                        //     } else {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return LandingScreen();
                                },
                              ));
                        //     }
                        //   }
                        // } else {}
                      },
                      color: Colors.white,
                      width: 400.w,
                      radius: 40),
                ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: () async {
                    EasyLoading.show(maskType: EasyLoadingMaskType.black);
                     await item.resendOtp(widget.mobileNumber);
                    EasyLoading.dismiss();
                  },
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't receive code?",
                          style: textFieldStyle(
                            fontSize: 20.sp,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        TextSpan(
                          text: "  Resend code",
                          style: textFieldStyle(
                              fontSize: 20.sp,
                              color: const Color(0xffFF7126),
                              weight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
