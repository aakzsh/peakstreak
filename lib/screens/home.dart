import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/edit_challenge.dart';
import 'package:peakstreak/screens/new_challenge.dart';
import 'package:peakstreak/screens/welcome.dart';
import 'package:peakstreak/services/api/save_report.dart';
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
  List<String> challengeProgressLocal = [];

  getTotalDaysData() async {
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
    // log("progress is " + challengeProgress.toString());
    if (challengeProgress.length < differenceDays + 1) {
      // log("went inside");
      List<String> temporary = List.filled(challengeTasks.length, "0");
      challengeProgress.add(temporary.toString());
      // log("now it iss" + challengeProgress.toString());
      setChallengeProgress(challengeProgress);
      setState(() {
        challengeProgressLocal = challengeProgress;
      });
      // log("i is " + challengeProgressLocal.toString());
    }
    if (challengeProgress.last.length < 3) {
      challengeProgress[challengeProgress.length - 1] =
          challengeProgress[challengeProgress.length - 1]
              .replaceAll('[', '')
              .replaceAll(']', '');
      List<String> elements = challengeProgress.last.split(', ');
      elements = List.filled(challengeTasks.length, "0");
      challengeProgress[challengeProgress.length - 1] = elements.toString();
      setChallengeProgress(challengeProgress);
      setState(() {
        challengeProgressLocal = challengeProgress;
      });
    }

    String todayTemp = challengeProgress[challengeProgress.length - 1]
        .replaceAll('[', '')
        .replaceAll(']', '');
    setState(() {
      allTasks = challengeTasks;
      todaysTasks = todayTemp.split(', ');
    });
    setState(() {
      challengeProgressLocal = challengeProgress;
    });

    return true;
  }

  updateChallengeData(newdata) async {
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
      await getDayIndex();
      await getChallengeData();
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const GetText(
                            fontSize: 20.0,
                            color: Colors.white,
                            centerAlign: false,
                            text: Helper.hash),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: w - 60,
                          child: GetText(
                              fontSize: 20.0,
                              color: AppColors.brightred,
                              centerAlign: false,
                              text: challengeName),
                        )
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
                              text:
                                  "Day ${differenceDays + 1}/$totalDays\n${formatDate(DateTime.now())}")),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: w - 40,
                      height: todaysTasks.length * 25 > 60
                          ? todaysTasks.length * 25
                          : 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: todaysTasks.length,
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    todaysTasks[index] =
                                        todaysTasks[index] == "0" ? "1" : "0";
                                  });
                                  await updateChallengeData(todaysTasks);
                                },
                                child: todaysTasks[index] == "0"
                                    ? Text(
                                        allTasks[index],
                                        style: const TextStyle(
                                          color: AppColors.brightred,
                                        ),
                                      )
                                    : Text(
                                        allTasks[index],
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            color: AppColors.brightgreen),
                                      ),
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
                              text: todaysTasks
                                      .where((element) => element == "0")
                                      .isEmpty
                                  ? totalDays == differenceDays + 1
                                      ? Helper.lastDayDone
                                      : Helper.doneForTheDay
                                  : "${todaysTasks.where((element) => element == "0").length}/${todaysTasks.length} ${Helper.tasksRemaining}")),
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
                              text: Helper.streakChart)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        height: 30*(totalDays/10) + 20,
                        child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalDays,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: GestureDetector(
                              onTap: () {
                                if (index < differenceDays + 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditChallenge(
                                              index: index,
                                              tasks:
                                                  challengeProgressLocal[index]
                                                      .replaceAll("[", "")
                                                      .replaceAll("]", "")
                                                      .split(", "),
                                              data: challengeProgressLocal,
                                              allTasks: allTasks)));
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: index == differenceDays
                                        ? (todaysTasks.contains("0")
                                            ? AppColors.brightred
                                            : AppColors.brightgreen)
                                        : (index > differenceDays
                                            ? (const Color.fromARGB(
                                                255, 41, 41, 41))
                                            : (challengeProgressLocal[index]
                                                    .replaceAll("[", "")
                                                    .replaceAll("]", "")
                                                    .split(", ")
                                                    .contains("0")
                                                ? AppColors.brightred
                                                : AppColors.brightgreen))),
                              ),
                            ),
                          );
                        },
                      ),
                      )
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    totalDays == differenceDays + 1
                        ? Column(
                            children: [
                              CustomButton(
                                  text: Helper.downloadReport,
                                  color: AppColors.dullgreen,
                                  onPressed: () async {
                                    String content = "";
                                    for (int i = 0; i < totalDays; i++) {
                                      String mid =
                                          "Day ${i + 1}: ${challengeProgressLocal[i].replaceAll("0", "Failed").replaceAll("1", "Passed")}";
                                      content += mid += "\n";
                                    }
                                    await downloadString(content, "report.txt");
                                  }),
                              CustomButton(
                                  text: Helper.createNewChallenge,
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
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    const Text(Helper.areYouSure),
                                                    CustomButton(
                                                        text: Helper.yes,
                                                        color:
                                                            AppColors.dullred,
                                                        onPressed: () async {
                                                          var res =
                                                              await deleteChallenge();
                                                          dev.log(
                                                              "deleted: ${res.toString()}");
                                                          // await NotificationService().cancelAllNotifs();
                                                          if (!mounted) return;
                                                          Navigator.pushAndRemoveUntil(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const Welcome()),
                                                              (route) => false);
                                                        })
                                                  ],
                                                ),
                                              ),
                                            ));
                                  })
                            ],
                          )
                        : CustomButton(
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
                                              const Text(Helper.areYouSure),
                                              CustomButton(
                                                  text: Helper.yes,
                                                  color: AppColors.dullred,
                                                  onPressed: () async {
                                                    var res =
                                                        await deleteChallenge();
                                                    dev.log(
                                                        "deleted: ${res.toString()}");
                                                    // await NotificationService().cancelAllNotifs();
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
