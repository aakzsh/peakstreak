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
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _numdayController = TextEditingController();
  List<TextEditingController> _taskControllers = [];

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
          Row(
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
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GetText(
                          fontSize: 10.0,
                          color: Colors.white,
                          centerAlign: false,
                          text: Helper.challengeNickname),
                    ),
                    SizedBox(
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
                        decoration: InputDecoration.collapsed(
                          hintText: "",
                          hintStyle: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GetText(
                          fontSize: 10.0,
                          color: Colors.white,
                          centerAlign: false,
                          text: Helper.numberOfDays),
                    ),
                    SizedBox(
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
                        decoration: InputDecoration.collapsed(
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
                        count,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: w - 90,
                                height: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.white),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                    child: TextField(
                                  decoration: InputDecoration.collapsed(
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
                              index == count - 1
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count++;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        color: AppColors.brightgreen,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          count--;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        color: AppColors.brightred,
                                      ))
                            ],
                          ),
                        ),
                      ),
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
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text("Alert!"),
                            content: Text(res["message"]),
                          ));
                } else {
                  var data = {
                    "challengeName": _nicknameController.text,
                    "challengeDays": _numdayController.text,
                    "challengeArray": ["xyz"]
                  };
                  var settingResult = await setNewChallenge(data);
                  if (settingResult) {
                    if(!mounted) return;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreatedChallenge()));
                  }
                }
              }),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
