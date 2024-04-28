import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/home.dart';
import 'package:peakstreak/widgets/appbar.dart';
import 'package:peakstreak/widgets/text.dart';

class CreatedChallenge extends StatefulWidget {
  const CreatedChallenge({super.key});

  @override
  State<CreatedChallenge> createState() => _CreatedChallengeState();
}

class _CreatedChallengeState extends State<CreatedChallenge> {
  int seconds = 3;
  Duration _duration = Duration(seconds: 3);
  // Define a Timer object
  Timer? _timer;

  Duration _gradientDuration = Duration(seconds: 3);
  // Define a Timer object
  Timer? _gradientTimer;
  double percent = 0;
  @override
  void initState() {
    super.initState();
    // Start the countdown timer
    startTimer();
    startGradientTimer();
  }

  @override
  void dispose() {
    // Cancel the timer to avoid memory leaks
    _timer?.cancel();
    _gradientTimer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_duration.inSeconds <= 0) {
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else {
        setState(() {
          seconds = _duration.inSeconds;
          _duration = _duration - Duration(seconds: 1);
        });
      }
    });
  }

  void startGradientTimer() {
    _gradientTimer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
     setState(() {
          percent += 0.01 / 3;
          _gradientDuration = _gradientDuration - const Duration(milliseconds: 10);
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const GetText(
              fontSize: 35.0,
              color: AppColors.brightgreen,
              centerAlign: true,
              text: Helper.created),
          const SizedBox(
            height: 20,
          ),
          const GetText(
              fontSize: 11.0,
              color: Colors.white,
              centerAlign: true,
              text: Helper.hopingLuck),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              height: 60,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        AppColors.dullgreen,
                        AppColors.brightgreen.withOpacity(0.0),
                      ],
                      stops: [
                        0,
                        percent
                      ]),
                  borderRadius: BorderRadius.circular(10)),
              child: Center(child: Text(Helper.redirectingYouIn + "$seconds")),
            ),
          ),
        ],
      ),
    );
  }
}
