import 'package:client_itc/core/constant/color.dart';
import 'package:client_itc/view/screen/search_secreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'pending.dart';
import 'profile/myprofil.dart';
import 'select_type.dart';

class AbbParBottom extends StatefulWidget {
  static const routeName = 'abbparbottom';
  @override
  _AbbParBottomState createState() => _AbbParBottomState();
}

class _AbbParBottomState extends State<AbbParBottom> {
  int pageIndex = 0;
  final SelectType selectType = const SelectType();
  final MainProfileScreen mainProfileScreen = const MainProfileScreen();
  final OrdersPending ordersPending = const OrdersPending();
  final SearchSecreen searchSecreen =
      const SearchSecreen();

  Widget showPage = new SelectType();
  pageChooser(int page) {
    switch (page) {
      case 0:
        return selectType;
        break;
      case 1:
        return mainProfileScreen;
        break;
      case 2:
        return ordersPending;
        break;
      case 3:
        return searchSecreen;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;

    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          height: 60.0,
          index: pageIndex,
          items: const <Widget>[
            Icon(Icons.grid_view, size: 30),
            Icon(Icons.person_outline, size: 30),
            Icon(Icons.notifications_active_outlined, size: 30),
            Icon(Icons.search, size: 30),
          ],
          color: AppColor.blue,
          buttonBackgroundColor: AppColor.blue,
          backgroundColor: AppColor.primaryColor,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (int tappedIndex) {
            setState(() {
              showPage = pageChooser(tappedIndex);
            });
          },
        ),
        body: Container(
            color: Colors.blueAccent, child: Center(child: showPage)));
  }
}
