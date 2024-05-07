import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tailor_app/Modals/customer_modal.dart';
import 'package:tailor_app/Reusable%20components/text_field.dart';

class CustomerItem extends StatelessWidget {
  CustomerModal orderItem;
  Function()? onTapx;

  CustomerItem({
    super.key,
    required this.orderItem,
    this.onTapx,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapx,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                child: SvgPicture.asset("assets/pic.svg"), radius: 26.sp),
            title: Text("${orderItem.name}",
                style: textFieldStyle(
                    fontSize: 19.sp,
                    color: const Color(0xff071245),
                    weight: FontWeight.w600)),
            subtitle: Container(
              margin: EdgeInsets.only(top: 6.h),
              child: Text("+91 ${orderItem.phone_no}",
                  style: textFieldStyle(
                    fontSize: 17.sp,
                    color: Colors.grey.shade600,
                  )),
            ),
          ),
          Divider(thickness: 1),
        ],
      ),
    );
  }
}
