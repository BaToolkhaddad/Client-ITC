import 'package:client_itc/controller/lab_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/color.dart';
import 'package:getwidget/getwidget.dart';
import '../widget/custombutton.dart';
import '../widget/drawer.dart';
import 'make_appointmment_lab.dart';

class HomeSecreenLab extends GetView {
  static String routeName = '/homesecreenlab';
  const HomeSecreenLab({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.blue,
        title: const Text(
          "             المخابر",
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
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: AppColor.primaryColor,
                size: 30,
                shadows: [
                  Shadow(
                      offset: Offset(3, 3),
                      color: Colors.black38,
                      blurRadius: 3),
                ],
              ))
        ],
        iconTheme: const IconThemeData(
            color: AppColor.primaryColor,
            shadows: [
              Shadow(
                  offset: Offset(3, 3), color: Colors.black38, blurRadius: 3),
            ],
            size: 30),
      ),
      drawer: const AppDrawer(),
      body: Container(
        height: h * .99,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColor.primaryColor,
                AppColor.white,
              ]),
        ),
        child: FutureBuilder(
            future: Provider.of<LabProvider>(context, listen: false).getLabs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                      " حصل خطأ أثناء جلب البيانات , تحقق من الاتصال بالانترنت"),
                );
              } else {
                return Consumer<LabProvider>(builder: (context, labProv, _) {
                  return ListView.builder(
                      itemCount: labProv.listLabs.length,
                      itemBuilder: (context, i) {
                        var infolabs = labProv.Labs[i];
                        return Provider.value(
                            value: labProv.Labs[i],
                            child: GFCard(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                ),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    AppColor.blue,
                                    AppColor.blue,
                                  ],
                                ),
                                height: h * .4,
                                title: GFListTile(
                                  color: AppColor.blue,
                                  avatar: GFAvatar(
                                    child: Image.network(infolabs.getImageUrl()!)
                                  ),
                                  title: Text(
                                    infolabs.laboratoriesName!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(3, 3),
                                            color: Colors.black38,
                                            blurRadius: 3),
                                      ],
                                    ),
                                  ),
                                  subTitle:
                                      Text(infolabs.laboratoriesLocation!),
                                ),
                                content: Text(
                                  infolabs.laboratoriesDescribe!,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: AppColor.primaryColor,
                                    shadows: [
                                      Shadow(
                                          offset: Offset(3, 3),
                                          color: Colors.black38,
                                          blurRadius: 5),
                                    ],
                                  ),
                                ),
                                buttonBar: GFButtonBar(children: <Widget>[
                                  // SizedBox(
                                  //   height: h * .02,
                                  // ),
                                  Column(
                                    children: [
                                      RichText(
                                        // textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: "تواصل معنا",
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .wavy,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    shadows: [
                                                      Shadow(
                                                          offset: Offset(3, 3),
                                                          color: Colors.black38,
                                                          blurRadius: 3),
                                                    ],
                                                    color: Colors.blue),
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {}),
                                          ],
                                        ),
                                      ),
                                    
                                      CustomButton(
                                          iconData: Icons.wechat_sharp,
                                          text: 'حجز موعد',
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                MakeAppointmentLabSecreen
                                                    .routeName);
                                          })
                                    ],
                                  ),
                                ])));
                      });
                });
              }
            }),
      ),
    );
  }
}
