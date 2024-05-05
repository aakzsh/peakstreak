import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peakstreak/constants/colors.dart';
import 'package:peakstreak/constants/helper.dart';
import 'package:peakstreak/screens/created_challenge.dart';
import 'package:peakstreak/services/sharedpreferences/set_new_challenge.dart';
import 'package:peakstreak/widgets/appbar.dart';
import 'package:peakstreak/widgets/button.dart';
import 'package:peakstreak/widgets/text.dart';

class NewChallenge extends StatefulWidget {
  const NewChallenge({super.key});

  @override
  State<NewChallenge> createState() => _NewChallengeState();
}

class _NewChallengeState extends State<NewChallenge> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _numdayController = TextEditingController();
  List<String> tasks = [""];
  Future<Map<String, dynamic>> validate() async {
    Map<String, dynamic> result = {};
    if (_nicknameController.text.isEmpty) {
      result['success'] = false;
      result['message'] = "Challenge name can't be blank!";
      return result;
    }
    if (_numdayController.text.isEmpty ||
        int.parse(_numdayController.text) < 1) {
      result['success'] = false;
      result['message'] = "Number of days can't be blank or less than 1!";
      return result;
    }
    if(tasks.contains("") || tasks.contains(" ") || tasks.isEmpty){
      result['success'] = false;
      result['message'] = "tasks can't be blank!";
      return result;
    }
    result["success"] = true;
    return result;
  }

  int count = 1;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppbar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 20,
              ),
              GetText(
                  fontSize: 25.0,
                  color: Colors.white,
                  centerAlign: false,
                  text: Helper.newChallenge1),
              GetText(
                  fontSize: 25.0,
                  color: AppColors.brightred,
                  centerAlign: false,
                  text: Helper.newChallenge2),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: GetText(
                          fontSize: 10.0,
                          color: Colors.white,
                          centerAlign: false,
                          text: Helper.challengeNickname),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: TextField(
                        controller: _nicknameController,
                        decoration: const InputDecoration.collapsed(
                          hintText: "",
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: GetText(
                          fontSize: 10.0,
                          color: Colors.white,
                          centerAlign: false,
                          text: Helper.numberOfDays),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: TextField(
                        controller: _numdayController,
                        decoration: const InputDecoration.collapsed(
                          hintText: "",
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: GetText(
                          fontSize: 10.0,
                          color: Colors.white,
                          centerAlign: false,
                          text: Helper.addTasks),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: List.generate(
                        tasks.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: index==tasks.length-1?w - 90:w-40,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: TextField(
                                      onChanged: (val){
                                        setState(() {
                                          tasks[index] = val;
                                        });
                                      },
                                  decoration: const InputDecoration.collapsed(
                                    hintText: "",
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                )),
                              ),
                              (index==tasks.length-1)?IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // tasks.pop(tasks[index]);
                                          tasks.removeLast();
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        color: AppColors.brightred,
                                      )): const SizedBox()
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    MaterialButton(onPressed: (){
                      setState(() {
                        tasks.add("");
                      });
                    },
                    minWidth: double.maxFinite,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    color: AppColors.dullgreen,
                    child: const Text("Add More"),
                    )
                  ],
                ),
              ),
            ),
          ),
          CustomButton(
              text: Helper.create,
              color: AppColors.dullgreen,
              onPressed: () async {
                var res = await validate();
                if (!res["success"]) {
                  if(!mounted) return;
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text("Alert!"),
                            content: Text(res["message"]),
                          ));
                } else {
                  var data = {
                    "challengeName": _nicknameController.text,
                    "challengeDays": _numdayController.text,
                    "challengeArray": tasks,
                  };
                  var settingResult = await setNewChallenge(data);
                  if (settingResult) {
                    if(!mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreatedChallenge()));
                  }
                }
              }),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
