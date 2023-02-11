import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutterpartproject/pages/chat/screens/home_screen.dart';
import 'package:flutterpartproject/pages/home/home.dart';
import 'package:flutterpartproject/pages/notification/notifi.dart';
import 'package:flutterpartproject/pages/workers/worker.dart';

class Bar extends StatefulWidget {
  Bar({Key? key}) : super(key: key);

  @override
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  var barPageIndex;
  var indexPage = 1;
  var sholdPop;

//// dialog to exit from app
  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("DO you want to exst app"),
          actions: [
            ElevatedButton(
                child: Text("no"),
                onPressed: () => Navigator.pop(context, false)),
            ElevatedButton(
                child: Text("yes"),
                onPressed: () => Navigator.pop(context, true))
          ],
        ),
      );
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          if (barPageIndex == 0) {
            barPageIndex = 1;
            indexPage = 1;
            print("zero" + "$indexPage");
          } else if (barPageIndex == 1) {
            sholdPop = showWarning(context);

            print("one");
          } else if (barPageIndex == 2) {
            barPageIndex = 1;
            indexPage = 1;
            print("two" + "$indexPage");
          } else if (barPageIndex == 3) {
            barPageIndex = 1;
            indexPage = 1;
            print("three" + "$indexPage");
          }
        });

        return sholdPop ?? false;
      },
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: bottomBar(),
            bottomNavigationBar: CurvedNavigationBar(
              index: indexPage,
              height: 50,
              backgroundColor: Color(0xFF262A4C),
              items: const <Widget>[
                Icon(
                  Icons.search,
                ),
                Icon(
                  Icons.home_outlined,
                ),
                Icon(
                  Icons.chat_outlined,
                ),
                Icon(
                  Icons.notifications_none_outlined,
                ),
              ],
              onTap: (index) {
                setState(() {
                  barPageIndex = index;
                });
              },
            ),
          )),
    );
  }

//
  bottomBar() {
    if (barPageIndex == 0) {
      return WorkerSearch();
    } else if (barPageIndex == 1) {
      return Home();
    } else if (barPageIndex == 2) {
      return HomeScreen();
    } else if (barPageIndex == 3) {
      return NotifiPage();
    } else {
      return Home();
    }
  }
}
