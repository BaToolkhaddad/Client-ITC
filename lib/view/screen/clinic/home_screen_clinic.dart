import 'package:client_itc/controller/clinic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../../../core/constant/color.dart';
import 'package:getwidget/getwidget.dart';
import '../abbpar_bottom.dart';
import '../../widget/drawer.dart';
import '../../widget/home widget/home_page_clinic.dart';

class HomeScreenC extends StatefulWidget {
  static String routeName = '/homesecreenc';
  const HomeScreenC({super.key});

  @override
  State<HomeScreenC> createState() => _HomeScreenCState();
}

class _HomeScreenCState extends State<HomeScreenC> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: GFAppBar(
          backgroundColor: AppColor.blue,
          title: const Text(
            "           العيادات",
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
                  // Get.to(const SearchCSecreen());
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
        bottomNavigationBar: AbbParBottom(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .73,
                          child: AnimationLimiter(
                              child: FutureBuilder(
                                  future: Provider.of<ClinicProvider>(context,
                                          listen: false)
                                      .getLabs(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                        child: Text(
                                            " حصل خطأ أثناء جلب البيانات , تحقق من الاتصال بالانترنت"),
                                      );
                                    } else {
                                      return Consumer<ClinicProvider>(
                                          builder: (context, clinicProv, _) {
                                        return GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 5,
                                              mainAxisSpacing: 5,
                                              crossAxisCount: 2,
                                            ),
                                            itemCount:
                                                clinicProv.listClinic.length,
                                            itemBuilder: (context, i) {
                                              var infoclinic =
                                                  clinicProv.clinic[1];
                                              return Provider.value(
                                                value: clinicProv.clinic[i],
                                                child: Services(
                                                  label: infoclinic.clinicName,
                                                  // image: infoclinic.image,
                                                  onTap: () {
                                                    // Get.to(const Beautifying());
                                                  },
                                                ),
                                              );
                                            });
                                      });
                                    }
                                  })))
                    ]))));
  }
}
