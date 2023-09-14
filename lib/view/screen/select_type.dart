import 'package:client_itc/view/screen/home_page_lab.dart';
import 'package:client_itc/view/screen/home_screen_nlysis.dart';
import 'package:client_itc/view/screen/home_secreen_radial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../../../core/constant/color.dart';
import 'package:getwidget/getwidget.dart';
import '../widget/drawer.dart';
import '../widget/home widget/home_page_clinic.dart';
import 'clinic/home_screen_clinic.dart';

class SelectType extends GetView {
  static const routeName = '/selecttype';
  const SelectType({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.blue,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              " الأقسام       ",
              style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
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
        iconTheme: const IconThemeData(
            color: AppColor.primaryColor,
            shadows: [
              Shadow(
                  offset: Offset(3, 3), color: Colors.black38, blurRadius: 3),
            ],
            size: 30),
      ),
      // bottomNavigationBar: AbbParBottom(),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          height: h,
          width: w,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.white,
                    ]),
              ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: AnimationLimiter(
                        child: GridView(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              crossAxisCount: 2,
                            ),
                            children: [
                          Services(
                            label: 'التحاليل',
                            image: 'assets/images/s.jpg', 
                            onTap: () {
                              Navigator.of(context).pushNamed(HomeScreenN.routeName);
                            },
                          ),
                          Services(
                             label: 'الأشعة',
                            image: 'assets/images/ray.webp',
                           
                            size: 65,
                            onTap: () {
                               Navigator.of(context).pushNamed(HomeScreenR.routeName);
                            },
                          ),
                          Services(
                            onTap: () {
                         Navigator.of(context).pushNamed(HomeSecreenLab.routeName);                            },
                            label: 'المخابر',
                            image: 'assets/images/lab.jpg',
                          ),
                          Services(
                            onTap: () {
                               Navigator.of(context).pushNamed(HomeScreenC.routeName);
                            },
                            label: 'العيادات',
                            image: 'assets/images/clinic.jpg',
                          ),
                        ]))),
              ]),
        ),
      ),
    );
  }
}
