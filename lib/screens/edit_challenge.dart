import 'package:flutter/material.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/welcome.dart';
import 'package:peakstreak/services/sharedpreferences/get_challenge_progress.dart';
import 'package:peakstreak/services/sharedpreferences/set_challenge_progress.dart';
import 'package:peakstreak/widgets/appbar.dart';
import 'package:peakstreak/widgets/button.dart';

class EditChallenge extends StatefulWidget {
  const EditChallenge(
      {super.key,
      required this.index,
      required this.tasks,
      required this.data,
      required this.allTasks});
  final int index;
  final List<String> tasks;
  final List<String> data;
  final List<String> allTasks;

  @override
  State<EditChallenge> createState() => _EditChallengeState();
}

class _EditChallengeState extends State<EditChallenge> {
  @override
  void initState() {
    super.initState();
  }

  updateChallengeData(newdata) async {
    List<String> tempProgress = await getChallengeProgress();
    tempProgress.last = newdata.toString();
    await setChallengeProgress(tempProgress);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: getAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                Container(
                  width: w - 40,
                  height: widget.tasks.length * 25 > 60
                      ? widget.tasks.length * 25
                      : 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white10,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: widget.tasks.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () async {
                              setState(() {
                                widget.tasks[index] =
                                    widget.tasks[index] == "0" ? "1" : "0";
                              });

                              await updateChallengeData(widget.tasks);
                            },
                            child: widget.tasks[index] == "0"
                                ? Text(
                                    widget.allTasks[index],
                                    style: const TextStyle(
                                      color: AppColors.brightred,
                                    ),
                                  )
                                : Text(
                                    widget.allTasks[index],
                                    style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors.brightgreen),
                                  ),
                          );
                        })),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButton(
                    text: Helper.update,
                    color: AppColors.dullgreen,
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
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        const Welcome())),
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
        ));
  }
}
