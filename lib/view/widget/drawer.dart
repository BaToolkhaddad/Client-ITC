import 'package:client_itc/controller/auth_controller.dart';
import 'package:client_itc/view/screen/auth/login.dart';
import 'package:client_itc/view/screen/select_type.dart';
import 'package:client_itc/view/widget/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/color.dart';
import '../screen/auth/signup_screen.dart';
import '../screen/pending.dart';

class AppDrawer extends GetView {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
        color: AppColor.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const GFDrawerHeader(
              decoration: BoxDecoration(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Medical Center ITC',
                    style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 35,
                        shadows: [
                          Shadow(
                              offset: Offset(5, 5),
                              color: Colors.black38,
                              blurRadius: 3),
                        ],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
                leading: const Icon(Icons.grid_view, size: 35, shadows: [
                  Shadow(
                      offset: Offset(3, 3),
                      color: Colors.black38,
                      blurRadius: 3),
                ]),
                iconColor: AppColor.primaryColor,
                textColor: AppColor.primaryColor,
                title: const Text(
                  'الأقسام',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(3, 3),
                          color: Colors.black38,
                          blurRadius: 3),
                    ],
                  ),
                ),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(SelectType.routeName)),
            ListTile(
                leading: const Icon(Icons.notifications_active_outlined,
                    size: 35,
                    shadows: [
                      Shadow(
                          offset: Offset(3, 3),
                          color: Colors.black38,
                          blurRadius: 3),
                    ]),
                iconColor: AppColor.primaryColor,
                textColor: AppColor.primaryColor,
                title: const Text(
                  'طلباتي',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(3, 3),
                          color: Colors.black38,
                          blurRadius: 3),
                    ],
                  ),
                ),
                onTap: () => Navigator.of(context)
                    .pushReplacementNamed(OrdersPending.routeName)),
            ListTile(
                leading: const Icon(Icons.share, size: 35, shadows: [
                  Shadow(
                      offset: Offset(3, 3),
                      color: Colors.black38,
                      blurRadius: 3),
                ]),
                iconColor: AppColor.primaryColor,
                textColor: AppColor.primaryColor,
                title: const Text(
                  'مشاركة',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(3, 3),
                          color: Colors.black38,
                          blurRadius: 3),
                    ],
                  ),
                ),
                onTap: () => Share.share(
                    'http://play.google.com/store/apps/details?id=com.instructivetech.testapp')),
            const ListTile(
              leading: Icon(Icons.person, size: 35, shadows: [
                Shadow(
                    offset: Offset(5, 3), color: Colors.black38, blurRadius: 3),
              ]),
              iconColor: AppColor.primaryColor,
              textColor: AppColor.primaryColor,
              title: Text(
                'الملف الشخصي',
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  shadows: [
                    Shadow(
                        offset: Offset(3, 3),
                        color: Colors.black38,
                        blurRadius: 3),
                  ],
                ),
              ),
              // onTap: () =>
              // Navigator.of(context).pushNamed(MainProfileScreen.routeName)
            ),
            ListTile(
                leading: const Icon(Icons.power_settings_new_sharp,
                    size: 35,
                    shadows: [
                      Shadow(
                          offset: Offset(3, 3),
                          color: Colors.black38,
                          blurRadius: 3),
                    ]),
                iconColor: AppColor.primaryColor,
                textColor: AppColor.primaryColor,
                title: const Text(
                  'تسجيل خروج',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(3, 3),
                          color: Colors.black38,
                          blurRadius: 3),
                    ],
                  ),
                ),
                onTap: () async {
                  // Navigator.pop(context);
                  showLoadingDialog(context);

                  await Provider.of<Auth>(context, listen: false).logout();
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove("userAuthData").then((_) {
                    Navigator.pop(context);

                    Navigator.of(context).pushNamed(LoginPage.routeName);
                  });
                }),
            ListTile(
                leading: const Icon(Icons.remove_circle, size: 35, shadows: [
                  Shadow(
                      offset: Offset(3, 3),
                      color: Colors.black38,
                      blurRadius: 3),
                ]),
                iconColor: AppColor.primaryColor,
                textColor: AppColor.primaryColor,
                title: const Text(
                  'حذف حسابي',
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    shadows: [
                      Shadow(
                          offset: Offset(3, 3),
                          color: Colors.black38,
                          blurRadius: 3),
                    ],
                  ),
                ),
                onTap: () async {
                  showLoadingDialog(context);
                  await Provider.of<Auth>(context, listen: false)
                      .deleteAccount('id', context);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove("userAuthData").then((_) {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(SignUpPage.routeName);
                  });
                }),
          ],
        ));
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: const LoadingDialog());
      },
    );
  }
}
