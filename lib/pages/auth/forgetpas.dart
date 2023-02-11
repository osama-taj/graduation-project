import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../component/customComponent.dart';
import '../../functions/validation.dart';
import 'loginpage.dart';

class Forgetpas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Forgetpasstate();
  }
}

class Forgetpasstate extends State<Forgetpas> {
  TextEditingController passwordC = new TextEditingController();
  TextEditingController confirmpassowrdc = new TextEditingController();

  GlobalKey<FormState> forgetpassword = new GlobalKey();

  passwordvalidate() {
    var formdata = forgetpassword.currentState;
    if (formdata!.validate()) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //stack---------------------------------------------------------
      body: Container(
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
                //pagetopic----------------------------------------------------------------
                Container(
                  margin: const EdgeInsets.only(top: 100, left: 180),
                  child: const Text(
                    "إعادة تعيين كلمة المرور",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.60,
                  child: Form(
                    key: forgetpassword,
                    child: Container(
                      margin: const EdgeInsets.only(left: 7, right: 7),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: const BoxDecoration(
                          color: Color(0xffE3E3EE),
                          boxShadow: [
                            BoxShadow(color: Color(0xff505B96), blurRadius: 10)
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: ListView(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 35),
                              child: const Text(
                                  " الرجاء اختيار كلمة مرورجديدة للإنتهاء من تسجيل الدخول",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xff262A4C),
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),

                            //textformfailds--------------------------
                            const SizedBox(height: 15),
                            textform("أدخل كلمة السر", true, Icons.password,
                                passwordC, (value) {
                              return validInput(value!, 5, 10, "password");
                            }),

                            const SizedBox(height: 15),
                            textform("تأكيد كلمة السر", true, Icons.password,
                                confirmpassowrdc, (value) {
                              return confirmpasswordv(value!, passwordC.text);
                            }),

                            //button----------------------------------------------
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Column(children: [
                                ElevatedButton(
                                  onPressed: () {
                                    passwordvalidate();
                                    // FocusScope.of(context).unfocus();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: const Color(0xff262A4C),
                                    elevation: 15,
                                    primary: const Color(0xff262A4C),
                                    padding: const EdgeInsets.all(0.0),
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
                                        "تغيير كلمة المرور",
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

                            //-----------------------------------------------------
                            Container(
                              margin: const EdgeInsets.only(top: 30, left: 20),
                              child: InkWell(
                                  onTap: () {
                                    Get.to(() => Login());
                                  },
                                  child: const Text("العودة لصفحة تسجيل الدخول",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color(0xff505B96),
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),

//form-------------------------------------------------------------------
    );
  }
}
