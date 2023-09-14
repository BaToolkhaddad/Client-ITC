// ignore: file_names
import 'package:client_itc/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/imgaeasset.dart';
import 'auth/signup_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});

  void _setonBoardViewed(context) async {
    int isViewed = 1;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('onBoard', isViewed);
    Navigator.of(context).pushNamed(SignUpPage.routeName);
  }

  static String routeName = '/on-boarding';
  final List<PageViewModel> introPages = [
    PageViewModel(
        title: "! لمحة عن التطبيق ",
        body:
            'كل ما تحتاجه طبيا\n( معلومات , خدمات ,استفسارات )  \nنوفره لك في تطبيقنا ',
        image: Image.asset(AppImageAsset.onBoardingImage3)),
    PageViewModel(
      title: "! لمحة عن التطبيق ",
      body:
          'يهدف هذا التطبيق لتقديم خدمات و تسهيلات كبيرة في إيجاد \nأقرب (مخبر تحاليل , عيادة , مركز تصوير) لديك \nو أنسب الأسعار لك من خلال التواصل معنا',
      image: Image.asset(AppImageAsset.onBoardingImage3),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 27),
        child: IntroductionScreen(
          pages: introPages.toList(),
          onDone: () => _setonBoardViewed(context),
          next: const Icon(
            Icons.navigate_next,
            color: AppColor.primaryColor,
            size: 30,
            shadows: [
              Shadow(
                  offset: Offset(4, 2), color: Colors.black38, blurRadius: 3),
            ],
          ),
          done: const Text(
            "حسنا",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              shadows: [
                Shadow(
                    offset: Offset(4, 2), color: Colors.black38, blurRadius: 3),
              ],
            ),
          ),
          dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            activeSize: const Size(15.0, 15.0),
            activeColor: AppColor.primaryColor,
            color: Colors.black26,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
