import 'package:flutter/material.dart';
import 'package:flutterpartproject/services/constans.dart';
import 'package:flutterpartproject/main.dart';
import 'package:flutterpartproject/pages/auth/forgetpas.dart';
import 'package:flutterpartproject/pages/auth/signup.dart';
import 'package:get/get.dart';
import '../../component/customComponent.dart';
import '../../functions/validation.dart';
import '../../services/user_service.dart';
import '../home/home.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Loginstate();
  }
}

class Loginstate extends State<Login> {
  bool loding = false;

  _loginUser() async {
    var formdata = formlogin.currentState;
    if (formdata!.validate()) {
      var response = await postRequest(
          loginURL, {"email": emailC.text, "password": paswordC.text});

      if (response['message'] != 'Invalid') {
        userId.setString("userId", response['user']['id'].toString());
        userId.setString("userToken", response['token']);
        userEmail.setString("userEmail", response['user']['email']);
        userImage.setString("userImage", response['user']['image']);
        userType.setString(
            "userType", response['user']['user_type'].toString());
        print(userToken.getString("userToken"));
        print(response);
        print(userType.getString('userType'));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                text(" كلمه المرور او الايميل غير صحيح", 20.0, Colors.white)));
      }
    }
  }

// texteditingcontrolle------------------------------------------------
  TextEditingController emailC = TextEditingController();
  TextEditingController paswordC = TextEditingController();
  GlobalKey<FormState> formlogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
                    margin: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  //form-----------------------------------------------------------------
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: Form(
                      key: formlogin,
                      child: Container(
                        margin:
                            const EdgeInsets.only(top: 10, left: 7, right: 7),
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 50),
                        decoration: const BoxDecoration(
                            color: Color(0xffE3E3EE),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff505B96), blurRadius: 10)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),

                        //textformfild------------------------------------------------------------
                        child: Column(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textform("دخل الايميل او رقم الهاتف", false,
                                  Icons.email, emailC, (value) {
                                return validInput(value!, 5, 100, "email");
                              }),
                              const SizedBox(height: 15),
                              textform("أدخل كلمة السر", true, Icons.password,
                                  paswordC, (value) {
                                return validInput(value!, 5, 10, "password");
                              }),
                              const SizedBox(height: 15),

                              //button------------------------------------------------------------------
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: loding
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Column(children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            _loginUser();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shadowColor:
                                                const Color(0xff262A4C),
                                            elevation: 15,
                                            primary: const Color(0xff262A4C),
                                            padding: const EdgeInsets.all(0.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),

                                            /////////////////////////////
                                            child: Container(
                                              constraints: const BoxConstraints(
                                                  maxHeight: 50, maxWidth: 300),
                                              alignment: Alignment.center,
                                              child: const Text(
                                                "سجل دخول",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ]),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                child: InkWell(
                                    onTap: () {
                                      Get.to(() => Forgetpas());
                                    },
                                    child: const Text(
                                      "هل نسيت كلمة السر؟",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff505B96),
                                      ),
                                    )),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 30),
                                //  padding: EdgeInsets.all(10),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            Get.to(() => Signup());
                                          },
                                          child: const Text("إنشاء حساب",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Color(0xff505B96),
                                                fontWeight: FontWeight.bold,
                                              ))),
                                      Container(
                                        margin: const EdgeInsets.only(left: 5),
                                        child: const Text(
                                          " لم يتم إنشاء حساب سابقا ؟ ",
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
                        ]),
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
