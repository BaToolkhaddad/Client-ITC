import 'package:client_itc/core/constant/color.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColor.blue,
      child: const Center(child: Text('<<<  الرجاء الانتظار قليلا ' ,  style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                  shadows: [
                Shadow(
                    offset: Offset(3, 3), color: Colors.black38, blurRadius: 3),
              ],
                fontSize: 35),
          ),
        ),
    ));
  }
}
