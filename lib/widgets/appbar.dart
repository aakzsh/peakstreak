
import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/widgets/text.dart';


AppBar getAppbar(){
  return AppBar(backgroundColor: Colors.transparent, elevation: 0.0,
      leadingWidth: double.maxFinite,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leading: Row(children: [
        SizedBox(width: 20,),
        Image.asset("assets/images/grid.png",height: 20,),
         SizedBox(width: 10,),
        GetText(fontSize: 15.0, color: Colors.white, centerAlign: true, text: "Peak"),
        GetText(fontSize: 15.0, color: AppColors.brightred, centerAlign: true, text: "Streak"),
      ],)
      );
}