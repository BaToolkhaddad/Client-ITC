import 'package:client_itc/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class Typer extends StatelessWidget {
  const Typer({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: AppColor.blue,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      child: Marquee(
        text: text!,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
            fontSize: 17),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 20,
        velocity: 100,
        pauseAfterRound: const Duration(seconds: 1),
        showFadingOnlyWhenScrolling: true,
        fadingEdgeStartFraction: 0.1,
        fadingEdgeEndFraction: 0.1,
        numberOfRounds: 1000,
        startPadding: 3,
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.bounceInOut,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
        // textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
      ),
    );
  }
}
