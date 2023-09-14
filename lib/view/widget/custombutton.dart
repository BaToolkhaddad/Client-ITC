import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constant/color.dart';

// ignore: must_be_immutable
class CustomButton extends GetView {
  CustomButton({Key? key, this.text, this.onPressed, required this.iconData})
      : super(key: key);
  final String? text;
  void Function()? onPressed;

  IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(50),
              topLeft: Radius.circular(50),
            ),
            boxShadow: [
              BoxShadow(
                  offset: Offset(5, 5), color: Colors.black38, blurRadius: 3),
            ]),
        width: MediaQuery.of(context).size.width * .6,
        height: MediaQuery.of(context).size.height * .07,
        child: Center(
            child: TextButton(
          onPressed: onPressed,
          child: Text(
            text!,
            style: const TextStyle(
                color: AppColor.blue,
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        )));
  }
}
