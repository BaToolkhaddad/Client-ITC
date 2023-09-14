import 'package:client_itc/core/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Services extends StatelessWidget {
  Services({Key? key, this.label, this.image, this.onTap, this.size})
      : super(key: key);

  final String? label;
  final String? image;
  Function()? onTap;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(7),
        
        child: Container(
          decoration: const BoxDecoration(
              color: AppColor.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                    offset: Offset(5, 5), color: Colors.black38, blurRadius: 3),
              ]),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            color: AppColor.blue,
            onPressed: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  image!,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  label!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(5, 5),
                          color: Colors.black38,
                          blurRadius: 5),
                    ],
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
