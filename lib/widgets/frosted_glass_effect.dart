import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wather_app/appColors/app_color.dart';

class FrostedGlassEffect extends StatelessWidget {
  final Widget? widget;
  const FrostedGlassEffect({
    super.key,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(children: [
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 7,
            sigmaY: 7,
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: AppColor.primeryColor,
                )
              ],
              border: Border.all(
                color: AppColor.whiteColor.withOpacity(0.2),
                width: 1.0,
              ),
              gradient: LinearGradient(
                colors: [
                  AppColor.whiteColor.withOpacity(0.5),
                  AppColor.whiteColor.withOpacity(0.2)
                ],
                stops: const [0.0, 1.0],
              ),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: widget,
          ),
        ),
      ]),
    );
  }
}
