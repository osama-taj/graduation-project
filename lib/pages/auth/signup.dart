import 'package:flutter/material.dart';
import 'package:flutterpartproject/services/constans.dart';
import 'package:flutterpartproject/functions/validation.dart';
import 'package:flutterpartproject/pages/auth/loginpage.dart';
import 'package:flutterpartproject/pages/auth/insertInormation.dart';
import 'package:get/get.dart';
import '../../component/customComponent.dart';
import '../../main.dart';
import '../../services/user_service.dart';

class Signup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Signupstate();
  }
}

class Signupstate extends State<Signup> {
  TextEditingController namec = new TextEditingController();
  TextEditingController usernamec = new TextEditingController();
  TextEditingController emailc = new TextEditingController();
  TextEditingController passowrdc = new TextEditingController();
  TextEditingController confirmpassowrdc = new TextEditingController();
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  List list = [];

  // register user
  void _registerUser() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      var response = await postRequest(registerURL, {
        "name": namec.text,
        "email": emailc.text,
        "password": passowrdc.text,
        "password_confirmation": confirmpassowrdc.text
      });
      if (response['message'] == 'secsuss') {
        userId.setString("userId", response['user']['id'].toString());
        userId.setString("userToken", response['token'].toString());
        Get.offAll(inserInfo());
      }
    } else {
      print("ont valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Color(0xff262A4C),
            gradient: LinearGradient(colors: [
              Color(0xff262A4C),
              Color(0xff505B96),
              Color(0xff9199C0),
              Color(0xffE3E3EE),
            ], begin: Alignment.topRight, end: Alignment.bottomRight),
          ),
          child: Center(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Text(
                      "إنشاء حساب",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //form------------------------------------------------------------
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.80,
                    child: Form(
                      key: formstate,
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 10, bottom: 20, left: 7, right: 7),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                            color: Color(0xffE3E3EE),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff505B96), blurRadius: 10)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),

                        //textformfailds-------------------------------------------------------
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textform("أدخل الاسم", false, Icons.person, namec,
                                (value) {
                              return validInput(value!, 4, 25, "username");
                            }),

                            const SizedBox(height: 15),
                            textform(
                                "أدخل الايميل ", false, Icons.email, emailc,
                                (value) {
                              return validInput(value!, 5, 100, "email");
                            }),

                            const SizedBox(height: 15),
                            textform("أدخل كلمة السر", true, Icons.password,
                                passowrdc, (value) {
                              return validInput(value!, 5, 10, "password");
                            }),

                            const SizedBox(height: 15),
                            textform("تأكيد كلمة السر", true, Icons.password,
                                confirmpassowrdc, (value) {
                              return confirmpasswordv(value!, passowrdc.text);
                            }),

                            //button---------------------------------------------------
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  _registerUser();
                                },
                                style: ElevatedButton.styleFrom(
                                  shadowColor: const Color(0xff262A4C),
                                  elevation: 15,
                                  primary: Color(0xff262A4C),
                                  padding: EdgeInsets.all(0.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Ink(
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xff262A4C),
                                        Color(0xff505B96),
                                        //Color(0xff9199C0)
                                      ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        maxHeight: 50, maxWidth: 300),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "إنشاء حساب",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            //-----------------------------------------------------------
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Get.to(() => Login());
                                        },
                                        child: const Text("تسجيل الدخول",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Color(0xff505B96),
                                              fontWeight: FontWeight.bold,
                                            ))),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 5,
                                      ),
                                      child: const Text(
                                        " تم إنشاء حساب سابقا ؟ ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Color(0xff505B96),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
