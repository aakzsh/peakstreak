import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/new_challenge.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_active.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_name.dart';
import 'package:peakstreak/widgets/appbar.dart';
import 'package:peakstreak/widgets/button.dart';
import 'package:peakstreak/widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isChallengeActive = false;
  String challengeName = "";

  getChallengeData()async{
    var name =await getChallengeName();
    setState(() {
      challengeName = name;
    });
  }

  setChallengeActive()async{
    var isActive = await getChallengeActive();
    setState(() {
      isChallengeActive = isActive;
    });
    if(isActive){
      getChallengeData();
    }
  }
  @override
  void initState(){
    super.initState();
    setChallengeActive();
  }

  String formatDate(DateTime date) {
  // Define the format
  final DateFormat formatter = DateFormat('EEEE, d MMMM, yyyy');

  // Format the date
  return formatter.format(date);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppbar(),
      body: 
      isChallengeActive?SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [SizedBox(width: 20,),
              GetText(fontSize: 20.0, color:Colors.white, centerAlign: false, text: Helper.hash),
              GetText(fontSize: 20.0, color: AppColors.brightred, centerAlign: false, text: " $challengeName")
              ],
            ),SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: GetText(fontSize: 12.0, color: Colors.white, centerAlign: false, text: formatDate(DateTime.now()))),
            ),
            CustomButton(text: Helper.deleteChallenge, color: AppColors.dullred, onPressed: ()async{
              showDialog(context: context, builder: (context)=>Dialog(
                backgroundColor: AppColors.bg,
                child: Container(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    Text("Are you sure?"),
                    CustomButton(text: "Yes", color: AppColors.dullred, onPressed: ()async{
                      print("delete");
                    })
                  ],),
                ),
              ));
            })
          ],),
        ),
      ):Column(
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
