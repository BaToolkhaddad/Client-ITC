import 'package:auto_size_text/auto_size_text.dart';
import 'package:client_itc/core/constant/color.dart';
import 'package:client_itc/view/screen/profile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/auth_controller.dart';
import '../../../model/profile.dart';
import '../../widget/loading_dialog.dart';
import '../auth/login.dart';
import '../auth/signup_screen.dart';

class MainProfileScreen extends StatefulWidget {
  static const routeName = '/Profile';

  const MainProfileScreen({Key? key}) : super(key: key);

  @override
  State<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  late SharedPreferences prefs;

  void setImageFromSelection() {
    setState(() {
      // result = r;
    });
  }

  @override
  void initState() {
    getPersonalImage();
    super.initState();
  }

  void getPersonalImage() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (err) {
      prefs = await SharedPreferences.getInstance();
    }
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

  void showAlertDialoglogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "تأكيد تسجيل الخروج؟",
            textAlign: TextAlign.right,
            style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          actions: [
            TextButton(
              child: const Text(
                "إلغاء",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("تأكيد", style: TextStyle(color: Colors.green)),
              onPressed: () async {
                  showLoadingDialog(context);
                  await Provider.of<Auth>(context, listen: false)
                      .deleteAccount('id', context);
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove("userAuthData").then((_) {
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed(SignUpPage.routeName);
                  });
                }
            ),
          ],
        );
      },
    );
  }

  void showAlertDialogdelet(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text(
            "هل تريد حذف حسابك ؟",
            textAlign: TextAlign.right,
            style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          actions: [
            TextButton(
              child: const Text(
                "إلغاء",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("تأكيد", style: TextStyle(color: Colors.green)),
              onPressed: () async {
                // Navigator.pop(context);
                showLoadingDialog(context);

                await Provider.of<Auth>(context, listen: false).logout();
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove("userAuthData").then((_) {
                  Navigator.pop(context);

                  Navigator.of(context).pushNamed(LoginPage.routeName);
                });
              },
            ),
          ],
        );
      },
    );
  }

  void showDialogInfoPerson(BuildContext context, Profile profileData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            children: <Widget>[
              makeListTile2(
                context,
                'اسم المستخدم',
                '${profileData.currentUser!.name}',
                Icons.person,
              ),
              makeListTile2(
                context,
                'رقم الهاتف',
                '${profileData.currentUser!.userPhone}',
                Icons.phone_android,
              ),
              makeListTile2(
                context,
                'رقم الهوية',
                '${profileData.currentUser!.userIdent}',
                Icons.abc_outlined,
              ),
              makeListTile2(
                context,
                'تاريخ إنشاء الحساب ',
                '${profileData.currentUser!.createdAt}',
                Icons.phone_android,
              ),
              makeListTile2(
                context,
                'تاريخ التعديل ',
                '${profileData.currentUser!.updatedAt}',
                Icons.phone_android,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(
                "إغلاق",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, Profile profileData) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
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
        children: [
          const Icon(Icons.person,
              color: AppColor.primaryColor,
              size: 100,
              shadows: [
                BoxShadow(
                    offset: Offset(1, 5),
                    color: Colors.black38,
                    spreadRadius: 2,
                    blurRadius: 5),
              ]),
          Text(
            '${profileData.currentUser!.name}',
            style: const TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 25,
              shadows: [
                Shadow(
                  offset: Offset(5, 5),
                  color: Colors.black38,
                  blurRadius: 5,
                ),
              ],
            ),
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(BuildContext context, Profile profileData) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              makeListTile(
                context,
                'معلومات الملف الشخصي',
                Icons.person,
                () => showDialogInfoPerson(context, profileData),
              ),
              makeListTile(
                context,
                'تعديل الملف الشخصي',
               const IconData(0xf5d6, fontFamily: 'MaterialIcons'),
                () => Navigator.of(context).pushNamed(
                  EditProfile.routeName,
                ),
              ),
            
              makeListTile(
                context,
                'تسجيل الخروج',
                Icons.settings_power,
                () => showAlertDialoglogout(context),
              ),
              makeListTile(
                context,
                'حذف حسابي',
                Icons.remove_circle,
                () => showAlertDialogdelet(context),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget makeListTile(
      BuildContext context, String title, IconData trailing, ontap) {
    return InkWell(
      onTap: ontap,
      child: Card(
        //color: Theme.of(context).backgroundColor,
        elevation: 2,
        shadowColor: AppColor.blue,
        child: ListTile(
          leading: const Icon(
            Icons.arrow_back_ios,
            color: AppColor.primaryColor,
          ),
          title: AutoSizeText(
            title,
            textDirection: TextDirection.rtl,
            overflow: TextOverflow.ellipsis,
            minFontSize: 9,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: MediaQuery.of(context).textScaleFactor *
                  18, // Adjust the font size as needed
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            trailing,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget makeListTile2(
      context, String title, String subTitle, IconData trailing) {
    return Card(
      elevation: 2,
      shadowColor: Theme.of(context).colorScheme.secondary,
      child: ListTile(
        //leading: Icon(Icons.arrow_back_ios),
        title: AutoSizeText(
          title,
          textDirection: TextDirection.rtl,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          minFontSize: 9,
          style: const TextStyle(
            color: AppColor.primaryColor,
          ),
        ),
        subtitle: AutoSizeText(
          subTitle,
          textDirection: TextDirection.rtl,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          minFontSize: 9,
          style: const TextStyle(
            color: AppColor.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          trailing,
          color: AppColor.primaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final ownerData = Provider.of<Profile>(context, listen: false);

    return Container(
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
        future: Future.wait([
          ownerData.getOwnerInfo(),
        ])
          ..catchError((error, stackTrace) {
            print('Error occurred: $error');

            // ignore: invalid_return_type_for_catch_error

            return null;
          }),
        builder: (BuildContext ctx, AsyncSnapshot<List<dynamic>> snapshotData) {
          if (snapshotData.hasError || snapshotData.data == null) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColor.primaryColor,
                      AppColor.white,
                    ]),
              ),
              height: height,
            );
          } else if (snapshotData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
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
                children: <Widget>[
                  _buildHeader(context, ownerData),
                  const SizedBox(height: 10.0),
                  _buildInfo(context, ownerData),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
