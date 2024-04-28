import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/created_challenge.dart';
import 'package:peakstreak/widgets/appbar.dart';
import 'package:peakstreak/widgets/button.dart';
import 'package:peakstreak/widgets/text.dart';

class NewChallenge extends StatefulWidget {
  const NewChallenge({super.key});

  @override
  State<NewChallenge> createState() => _NewChallengeState();
}

class _NewChallengeState extends State<NewChallenge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 20,),
            GetText(fontSize: 25.0, color: Colors.white, centerAlign: false, text: Helper.newChallenge1),
            GetText(fontSize: 25.0, color: AppColors.brightred, centerAlign: false, text: Helper.newChallenge2),

          ],
        ),
       
        Expanded(child:  SingleChildScrollView(
          child: Column(
            children: [
              Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                 Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                 Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
                Text("hehe"),
               Text("hehe"),
               
               
            ],
          ),
        ),),
        CustomButton(text: Helper.create, color: AppColors.dullgreen, onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreatedChallenge()));
        }),
        SizedBox(height: 10,)
      ],
      ),
    );
  }
}