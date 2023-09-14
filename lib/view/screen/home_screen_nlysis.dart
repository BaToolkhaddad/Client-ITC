import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:client_itc/controller/analyis_controller.dart';
import 'package:client_itc/view/widget/home%20widget/typer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constant/color.dart';
import 'package:getwidget/getwidget.dart';
import '../widget/drawer.dart';

class HomeScreenN extends StatefulWidget {
  static String routeName = '/homesecreenn';
  const HomeScreenN({super.key});

  @override
  State<HomeScreenN> createState() => _HomeScreenNState();
}

class _HomeScreenNState extends State<HomeScreenN> {
  @override
  Widget build(BuildContext context) {
    print("build HomeScreenN");

    return Scaffold(
      appBar: GFAppBar(
        backgroundColor: AppColor.blue,
        title: const Text(
          "          التحاليل",
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
            'يعرض لك هذا القسم معلومات مفصلة عن أي تحليل تريد و مدة صلاحية نتيجة التحليل و متوسط السعر له,و يمكنك البحث عن تحليل معين , نحن نسعى لتوفير أنسب سعر لك مع إيجاد أقرب مخبر لديك فقط تواصل معنا من خلال الضغط على أيقونة الرسائل',
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
              child: AnotherCarousel(
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
                  AssetImage('assets/images/s.jpg'),
                  AssetImage('assets/images/ss.jpg'),
                  AssetImage('assets/images/sss.jpg'),
                  AssetImage('assets/images/sssss.png'),
                  AssetImage('assets/images/ssssss.png'),
                ],
              ),
              //  HomeimageNWidget(),
            ),
            Expanded(
              flex: 2,
              child: FutureBuilder(
                  future:
                      Provider.of<InfoAnalyisProvider>(context, listen: false)
                          .getInfoAnalyis(),
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
                      return Consumer<InfoAnalyisProvider>(
                          builder: (context, ifoanalyisProv, _) {
                        return ListView.builder(
                            itemCount: ifoanalyisProv.infoAnalyis.length,
                            itemBuilder: (context, i) {
                              var infoanalyis = ifoanalyisProv.infoAnalyis[i];
                              return Provider.value(
                                value: ifoanalyisProv.infoAnalyis[i],
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
                                    title: infoanalyis.itemsName,
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
                                        Text(infoanalyis.itemsDescription!,textAlign: TextAlign.right)),
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
