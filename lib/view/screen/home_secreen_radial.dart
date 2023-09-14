
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:client_itc/view/widget/home%20widget/typer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/color.dart';
import 'package:getwidget/getwidget.dart';
import '../../controller/rey_x_controller.dart';
import '../widget/drawer.dart';
class HomeScreenR extends StatefulWidget {
  static String routeName = '/homesecreenr';
  const HomeScreenR({super.key});

  @override
  State<HomeScreenR> createState() => _HomeScreenRState();
}

class _HomeScreenRState extends State<HomeScreenR> {
  @override
  Widget build(BuildContext context) {
  // final h =MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.blue,
        title: const Text(
          "           الأشعة",
          style: TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 30,
            shadows: [
              Shadow(
                  offset: Offset(5, 5), color: Colors.black38, blurRadius: 5),
            ],
          ),
        ),
        actions: [
         
          IconButton(
              onPressed: () {
                // Get.to(const SearchNSecreen());
              },
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
            'يعرض لك هذا القسم معلومات مفصلة عن أي صورة أشعة تريدها و متوسط السعر لها,و يمكنك البحث عن أي نوع صورة أشعة لاطلاع على كامل المعلومات التي تخصها , نحن نسعى لتوفير أنسب سعر لك مع إيجاد أقرب قسم أشعة لديك فقط تواصل معنا من خلال الضغط على أيقونة الرسائل',
      ),
      drawer: const AppDrawer(),
      body: Container(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Expanded(
              flex: 1,
              child:  AnotherCarousel(
                  boxFit: BoxFit.cover,
                  borderRadius: true,
                  autoplay: true,
                  moveIndicatorFromBottom: 360,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: const Duration(milliseconds: 1000),
                  dotSize: 0,
                  dotIncreasedColor: AppColor.primaryColor,
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomCenter,
                  dotVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 5.0,
                  images: const [
                    AssetImage('assets/images/r1.jpg'),
                    AssetImage('assets/images/r2.jpg'),
                    AssetImage('assets/images/r3.jpg'),
                    AssetImage('assets/images/r4.jpg'),
                    AssetImage('assets/images/r5.webp'),
                    AssetImage('assets/images/r6.jpg'),
                    AssetImage('assets/images/r7.webp'),
                    AssetImage('assets/images/r8.jpg'),
                    AssetImage('assets/images/r9.webp'),
                    AssetImage('assets/images/ray.webp'),
                  ],
                ),
            ),
              //  HomeimageNWidget(),
           
            Expanded(
              flex: 2,
              child: FutureBuilder(
                  future:
                      Provider.of<InfoRayXProvider>(context, listen: false)
                          .getInfoRayx(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text(" حصل خطأ أثناء جلب البيانات , تحقق من الاتصال بالانترنت"),
                      );
                    } else {
                      return Consumer<InfoRayXProvider>(
                          builder: (context, iforayxProv, _) {
                        return ListView.builder(
                              itemCount: iforayxProv.infoRayx.length,
                    itemBuilder: (context, i) {
                  var infopory = iforayxProv.infoRayx[i]; 
                              return Provider.value(
                        value: iforayxProv.infoRayx[i],
                        child: GFAccordion(
                                    contentBackgroundColor: AppColor.white,
                                    expandedTitleBackgroundColor:
                                        AppColor.primaryColor,
                                    collapsedTitleBackgroundColor:
                                        AppColor.primaryColor,
                                    collapsedIcon: const Icon(
                                        Icons.arrow_drop_down_sharp,
                                        color: AppColor.white),
                                    expandedIcon: const Icon(
                                      Icons.arrow_drop_up_sharp,
                                      color: AppColor.white,
                                    ),
                                    title: infopory.itemsName,
                                    textStyle: const TextStyle(
                                      color: AppColor.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      shadows: [
                                        Shadow(
                                            offset: Offset(5, 5),
                                            color: Colors.black38,
                                            blurRadius: 5),
                                      ],
                                    ),
                                    titleBorderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    contentBorderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    contentChild:
                                        Text(infopory.itemsDescription!,textAlign: TextAlign.right,)),
                              );
                            });
                      });
                    }
                  }),
            ),
           
          ],
        ),
      ),
    );
  }
}
