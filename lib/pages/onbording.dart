import 'package:flutterpartproject/pages/auth/loginpage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// ignore: camel_case_types
class introScreen extends StatelessWidget {
  const introScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.amberAccent,

      body: Container(
        padding: const EdgeInsets.only(top: 100),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color(0xff262A4C),
              Color(0xff505B96),
              Color(0xff9199C0),
              Color(0xffE3E3EE)
            ])),
        child: Center(
          child: IntroductionScreen(
            globalBackgroundColor: Colors.transparent,

            pages: [
              modelpageview(
                  "اختر المنطقه ",
                  " اخنر المنطقه السكنيه المتواجده بالقرب منك للوصول الى العامل المطلوب بسرعه",
                  "assets/selectNear.json"),
              modelpageview(
                  "اراء العملاء",
                  "إقرأ اراء  وتقييم العملاء السابقين على العمال وحدد الانسب اليك ",
                  "assets/reedOpinion.json"),
              modelpageview(
                  "اختر العامل ",
                  "بعد اختيار العامل المناسب لك قم بالتواصل معه و الاتفاق على التفاصيل",
                  "assets/findWorker.json"),
            ],

            showNextButton: true,
            showSkipButton: true,

            dotsDecorator: DotsDecorator(
                spacing: const EdgeInsets.all(5),
                color: Colors.white,
                activeColor: const Color(0xff464F86),
                size: const Size.square(10),
                activeSize: const Size(20, 10),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),

            onDone: () {
              Get.off(() => Login());
            },

            //DONE button
            done: Container(
              height: 60,
              width: 60,
              decoration: decorationfrobutton(),
              child: const Center(
                child: Text(
                  "انهاء",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            //// SKIP button
            skip: Container(
              height: 60,
              width: 60,
              decoration: decorationfrobutton(),
              child: const Center(
                child: Text(
                  "تخطي",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ////// Next button
            next: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: const Color(0xff464F86), width: 2),
              ),
              child: const Center(
                  child: Icon(
                Icons.navigate_next,
                size: 30,
                color: Color(0xff464F86),
                // Colors.amberAccent,
              )),
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration decorationfrobutton() {
    return BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff2D3156),
              Color(0xff909ABE),
            ]),
        borderRadius: BorderRadius.circular(40),
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(2, 2))
        ]);
  }

  ////////////// PageViewModel for all screens in introdaction pages///////////////////////
  PageViewModel modelpageview(String titel, String deisc, String assets) {
    return PageViewModel(
      titleWidget: Text(
        "  $titel",
        style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(offset: Offset(-1.5, -1.5), color: Color(0xff262A4C)),
              Shadow(offset: Offset(1.5, -1.5), color: Color(0xff262A4C)),
              Shadow(offset: Offset(1.5, 1.5), color: Color(0xff262A4C)),
              Shadow(offset: Offset(-1.5, 1.5), color: Color(0xff262A4C))
            ]),
      ),
      bodyWidget: Text(
        "$deisc",
        style: const TextStyle(color: Colors.white, fontSize: 20, shadows: [
          Shadow(color: Colors.grey, blurRadius: 5, offset: Offset(1, 1))
        ]),
        textAlign: TextAlign.center,
      ),
      image: Container(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.asset(
            "$assets",
            width: 500,
            height: 500,
          )),
    );
  }
}
