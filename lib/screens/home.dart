import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/new_challenge.dart';
import 'package:peakstreak/widgets/appbar.dart';
import 'package:peakstreak/widgets/button.dart';
import 'package:peakstreak/widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetText(
                  fontSize: 25.0,
                  color: Colors.white,
                  centerAlign: false,
                  text: Helper.noChallengeSet1),
              GetText(
                  fontSize: 25.0,
                  color: AppColors.brightred,
                  centerAlign: false,
                  text: Helper.noChallengeSet2)
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          CustomButton(
              text: Helper.createOneNow,
              color: AppColors.dullgreen,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: ((context) => NewChallenge())));
              })
        ],
      ),
    );
  }
}
