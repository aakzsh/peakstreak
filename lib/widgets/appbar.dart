
import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/widgets/text.dart';


AppBar getAppbar(){
  return AppBar(backgroundColor: Colors.transparent, elevation: 0.0,
      leadingWidth: double.maxFinite,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: Row(children: [
        const SizedBox(width: 20,),
        Image.asset("assets/images/grid.png",height: 20,),
         const SizedBox(width: 10,),
        const GetText(fontSize: 15.0, color: Colors.white, centerAlign: true, text: "Peak"),
        const GetText(fontSize: 15.0, color: AppColors.brightred, centerAlign: true, text: "Streak"),
      ],)
      );
}