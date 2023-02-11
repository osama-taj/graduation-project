import 'package:flutterpartproject/pages/onbording.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'pages/auth/loginpage.dart';
import 'pages/home/bar.dart';

int? initScreen;
late SharedPreferences userId;
late SharedPreferences userToken;
late SharedPreferences userImage;
late SharedPreferences userEmail;
late SharedPreferences userType;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = await SharedPreferences.getInstance();
  userToken = await SharedPreferences.getInstance();
  userImage = await SharedPreferences.getInstance();
  userEmail = await SharedPreferences.getInstance();
  userType = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontSize: 30,
          ),
        ),
        iconTheme: const IconThemeData(size: 30, color: Colors.grey),
        appBarTheme: const AppBarTheme(
          color: Color(0xff262A4C),
        ),
      ),
      home: initScreen == 0 || initScreen == null
          ? const introScreen()
          : userId.getString("userToken") == null
              ? Login()
              : Bar(),
    );
  }
}
