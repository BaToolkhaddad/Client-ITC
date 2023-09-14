// ignore_for_file: prefer_const_constructors

import 'package:client_itc/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../widget/search_widget.dart';

class SearchSecreen extends GetView {
  const SearchSecreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GFAppBar(
          backgroundColor: AppColor.blue,
          title: const Text(
            " البحث",
            style: TextStyle(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          iconTheme: const IconThemeData(
              color: AppColor.primaryColor,
              shadows: [
                Shadow(
                    offset: Offset(3, 3), color: Colors.black38, blurRadius: 3),
              ],
              size: 30),
        ),
       
        body: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SearchWidget(),
        ));
  }
}
