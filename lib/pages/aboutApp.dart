import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';

class AboutApp extends StatefulWidget {
  AboutApp({Key? key}) : super(key: key);

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("عن التطبيق"),
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 600,
                  child: Center(
                      child: Image.asset('images/IMG-20211215-WA0000.jpg')),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: text(
                      "منصة يمنية تتيح لأصحاب الأعمال ايجاد مهنيين محترفين للقيام بأعمالهم وكذلك تتيح للمهنيين عرض أعمالهم ومكانا لإيجاد مشاريع يعملون عليها ويكسبون من خلالها",
                      20.0,
                      Colors.black),
                ),
              ],
            )),
          ),
        ));
  }

//
}
