import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/home.dart';
import 'package:peakstreak/widgets/button.dart';
import 'package:peakstreak/widgets/text.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
          Column(
            children: [
              Image.asset(
                "assets/images/grid.png",
                scale: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GetText(
                      fontSize: 35.0,
                      color: Colors.white,
                      centerAlign: false,
                      text: Helper.title1),
                  GetText(
                      fontSize: 35.0,
                      color: AppColors.brightred,
                      centerAlign: false,
                      text: Helper.title2),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
             const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GetText(
                          fontSize: 13.0,
                          color: Colors.white,
                          centerAlign: true,
                          text: Helper.subtitle1),
                          GetText(
                          fontSize: 13.0,
                          color: AppColors.brightred,
                          centerAlign: true,
                          text: Helper.subtitle2)
                    ],
                  ),
                    GetText(
                          fontSize: 13.0,
                          color: Colors.white,
                          centerAlign: true,
                          text: Helper.subtitle3)
                ],
              )
            ],
          ),
          CustomButton(
              text: Helper.getBetter,
              color: AppColors.dullgreen,
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) => const Home())), (route) => false);
              })
        ],
      ),
    );
  }
}
