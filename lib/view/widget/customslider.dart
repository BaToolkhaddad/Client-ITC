import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/onboarding_controller.dart';
import '../../core/constant/color.dart';
import '../../data/datasource/static/static.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return PageView.builder(
        controller: controller.pageController,
        onPageChanged: (val) {
          controller.onPageChanged(val);
        },
        itemCount: onBoardingList.length,
        itemBuilder: (context, i) => Column(
              children: [
                SizedBox(height: h * .03),
                Text(
                  onBoardingList[i].title!,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      shadows: [
                        const Shadow(
                            offset: Offset(7, 7),
                            color: Colors.black38,
                            blurRadius: 7),
                        Shadow(
                            offset: const Offset(-6, -6),
                            color: Colors.white.withOpacity(0.85),
                            blurRadius: 7)
                      ],
                      color: AppColor.primaryColor),
                ),
                SizedBox(height: h * .05),
                Container(
                  height: h * .3,
                  width: w * .8,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.8),
                        // offset: const Offset(-15.0, -15.0),
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(6, 6),
                        blurRadius: 0.1,
                      ),
                    ],
                    color: AppColor.grey,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Image.asset(
                    onBoardingList[i].image!,
                    height: h * .3,
                    width: w * .7,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: h * .03),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    onBoardingList[i].body!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        shadows: [
                          const Shadow(
                              offset: Offset(3, 3),
                              color: Colors.black38,
                              blurRadius: 5),
                          Shadow(
                              offset: const Offset(-6, -6),
                              color: Colors.white.withOpacity(0.85),
                              blurRadius: 5)
                        ],
                        color: AppColor.primaryColor),
                  ),
                ),
              ],
            ));
  }
}
