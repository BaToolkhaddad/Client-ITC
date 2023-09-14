
import 'package:client_itc/view/screen/clinic/make_appointment_clinic.dart';
import 'package:client_itc/view/screen/select_type.dart';
import 'package:client_itc/view/widget/home%20widget/typer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/color.dart';
import 'package:getwidget/getwidget.dart';

class Beautifying extends StatefulWidget {
  const Beautifying({super.key});

  @override
  State<Beautifying> createState() => _BeautifyingState();
}

class _BeautifyingState extends State<Beautifying> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
          backgroundColor: AppColor.blue,
          title: const Text(
            "الجراحة التجميلية",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              shadows: [
                Shadow(
                    offset: Offset(5, 5), color: Colors.black38, blurRadius: 5),
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to( const SelectType());
                },
                icon: const Icon(
                  Icons.home,
                  color: AppColor.primaryColor,
                  size: 30,
                  shadows: [
                    Shadow(
                        offset: Offset(3, 3),
                        color: Colors.black38,
                        blurRadius: 3),
                  ],
                )),
          ],
          iconTheme: const IconThemeData(
              color: AppColor.primaryColor,
              shadows: [
                Shadow(
                    offset: Offset(3, 3), color: Colors.black38, blurRadius: 3),
              ],
              size: 30),
        ),
        bottomNavigationBar: const Typer(
            text:
                'يعرض هذا القسم أسماء الأطباء الموجودين في ,و يمكنك من هنا حجز موعد عند أي دكنور ترغب  أو إلغاء حجز موعد , و يمكنك التواصل مهنا من أيقونة الرسائل أعلى الشاشة  '),
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GFListTile(
                  color: AppColor.blue,
                  titleText: 'الدكتور باسل دروبي',
                  listItemTextColor: AppColor.primaryColor,
                  subTitleText: ' أخصائي في الجراحة التجميلية و الترميمية',
                  avatar: TextButton(
                      onPressed: () => Get.to(const MakeAppointmentClinicSecreen()),
                      child: const Text('حجز موعد')),
                ),
              ]),
        ));
  }
}
