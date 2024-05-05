import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/new_challenge.dart';
import 'package:peakstreak/screens/welcome.dart';
import 'package:peakstreak/services/sharedpreferences/delete_challenge.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_active.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_name.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_progress.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_start.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_tasks.dart';
import 'package:peakstreak/services/sharedpreferences/get_total_days.dart';
import 'package:peakstreak/services/sharedpreferences/set_challenge_progress.dart';
import 'package:peakstreak/widgets/appbar.dart';
import 'package:peakstreak/widgets/button.dart';
import 'package:peakstreak/widgets/text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int differenceDays = 0;
  List<String> allTasks = [];
  bool isChallengeActive = false;
  String challengeName = "";
  List<String> todaysTasks = [];
  int totalDays = 0;


  getTotalDaysData()async{
    int days = await getTotalDays();
    setState(() {
      totalDays = days;
    });
  }
  getChallengeData() async {
    var name = await getChallengeName();
    await getTotalDaysData();
    setState(() {
      challengeName = name;
    });
    var challengeTasks = await getChallengeTasks();
    var challengeProgress = await getChallengeProgress();
    if(challengeProgress.length<differenceDays+1){
      List<String> temporary =  List.filled(challengeTasks.length, "0");
      challengeProgress.add(temporary.toString());
      setChallengeProgress(challengeProgress);
    }
    if(challengeProgress.last.length<3){
    challengeProgress[challengeProgress.length-1] = challengeProgress[challengeProgress.length-1].replaceAll('[', '').replaceAll(']', '');
    List<String> elements = challengeProgress.last.split(', ');
    elements = List.filled(challengeTasks.length, "0");
    challengeProgress[challengeProgress.length-1] = elements.toString();
    setChallengeProgress(challengeProgress);
    }

    String todayTemp = challengeProgress[challengeProgress.length-1].replaceAll('[', '').replaceAll(']', '');
    setState(() {
      allTasks = challengeTasks;
      todaysTasks = todayTemp.split(', ');
    });
  }

  updateChallengeData(newdata)async{
    List<String> tempProgress = await getChallengeProgress();
    tempProgress.last = newdata.toString();
    await setChallengeProgress(tempProgress);
  }

  getDayIndex() async {
    var startDay = await getChallengeStart();
    var today = DateTime.now();
    int difference = today.difference(DateTime.parse(startDay)).inDays;
    // print("difference is $difference");
    setState(() {
      differenceDays = difference;
    });
  }

  setChallengeActive() async {
    var isActive = await getChallengeActive();
    setState(() {
      isChallengeActive = isActive;
    });
    if (isActive) {
      await getChallengeData();
      await getDayIndex();
    }
  }

  @override
  void initState() {
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
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppbar(),
      body: isChallengeActive
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const GetText(
                            fontSize: 20.0,
                            color: Colors.white,
                            centerAlign: false,
                            text: Helper.hash),
                        GetText(
                            fontSize: 20.0,
                            color: AppColors.brightred,
                            centerAlign: false,
                            text: " $challengeName")
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GetText(
                              fontSize: 12.0,
                              color: Colors.white,
                              centerAlign: false,
                              text: "Day ${differenceDays+1}/$totalDays\n${formatDate(DateTime.now())}")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w - 40,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: todaysTasks.length,
                            itemBuilder: ((context, index) 
                                {
                                 return   GestureDetector(
                                      onTap: ()async{
                                        setState(() {
                                          todaysTasks[index] = todaysTasks[index]=="0"?"1":"0";
                                        });
                                        await updateChallengeData(todaysTasks);
                                      },
                                      child: todaysTasks[index]=="0"?Text(allTasks[index], style: const TextStyle(color: AppColors.brightred,),):Text(allTasks[index], style: const TextStyle(
                                         decoration: TextDecoration.lineThrough,
                                         color: AppColors.brightgreen
                                      ),),
                                    );

                                })),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GetText(
                              fontSize: 10.0,
                              color: Colors.white,
                              centerAlign: false,
                              text: 
                              todaysTasks.where((element) => element == "0").isEmpty?
                             totalDays!=differenceDays+1? "🎉 Last Day Done, and Dusted! 🎉":  "done for the day! sit and relaxx..":
                              "${todaysTasks.where((element) => element == "0").length}/${todaysTasks.length} tasks remaining. You can do it!"
                              )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: GetText(
                              fontSize: 18.0,
                              color: Colors.white,
                              centerAlign: false,
                              text: "Streak Chart")),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 100,
                          width: w - 40,
                          child: GridView.builder(
                            itemCount: differenceDays+1,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 10,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                            
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: todaysTasks.contains("0")?AppColors.brightred:AppColors.brightgreen, // Change color based on contributions
                                  ),
                                ),
                              );
                            },
                          ),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                        text: Helper.deleteChallenge,
                        color: AppColors.dullred,
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                    backgroundColor: AppColors.bg,
                                    child: SizedBox(
                                      height: 150,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text("Are you sure?"),
                                          CustomButton(
                                              text: "Yes",
                                              color: AppColors.dullred,
                                              onPressed: () async {
                                                var res =
                                                    await deleteChallenge();
                                                log("deleted: ${res.toString()}");
                                                if (!mounted) return;
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Welcome()),
                                                    (route) => false);
                                              })
                                        ],
                                      ),
                                    ),
                                  ));
                        })
                  ],
                ),
              ),
            )
          : Column(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const NewChallenge())));
                    })
              ],
            ),
    );
  }
}
