import 'package:flutter/material.dart';
import 'package:wather_app/appColors/app_color.dart';

class CommonButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? widget;
  const CommonButton({super.key, this.width, this.height, this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: AppColor.lightBlueColor.withOpacity(.8),
          borderRadius: BorderRadius.circular(12)),
      child: widget,
    );
  }
}
