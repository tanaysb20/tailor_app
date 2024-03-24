import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomButtonScreen extends StatelessWidget {
  final String text1;
  final void Function()? fun;
  final double? width;
  final double? radius;
  final double? height;
  final bool check;
  final Color color;
  final Color bgcolor;

  const CustomButtonScreen({
    super.key,
    this.fun,
    this.radius = 10,
    this.text1 = "",
    this.height = 60,
    this.width,
    this.color = Colors.black,
    this.bgcolor = const Color.fromARGB(255, 74, 163, 236),
    this.check = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              bgcolor), // Set your desired button color here
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  radius ?? 10), // Set your desired border radius here
            ),
          ),
        ),
        onPressed: fun,
        child: Text(
          text1,
          style: TextStyle(
              fontSize: check ? 22.sp : 19.sp,
              fontWeight: FontWeight.w700,
              color: color),
        ),
      ),
    );
  }
}
