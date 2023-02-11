import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import 'services/constans.dart';
import '../models/user.dart';

class drop extends StatefulWidget {
  drop({Key? key}) : super(key: key);

  @override
  State<drop> createState() => _dropState();
}

class _dropState extends State<drop> {
  static const Map<int, String> frequencyOptions = {
    30: "30 ssssssssss",
    1: "1sssssssss",
    2: "2sssssssssssssss",
  };

  int _frequencyValue = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: DropdownButton<int>(
            items: frequencyOptions
                .map((value, desc) {
                  return MapEntry(
                      value,
                      DropdownMenuItem<int>(
                        value: value,
                        child: Text(desc),
                      ));
                })
                .values
                .toList(),
            value: _frequencyValue,
            onChanged: (int? newValue) {
              if (newValue != null) {
                setState(() {
                  _frequencyValue = newValue;
                  print(_frequencyValue);
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
/*
class usersw extends StatefulWidget {
  usersw({Key? key}) : super(key: key);

  @override
  State<usersw> createState() => _userswState();
}

class _userswState extends State<usersw> {
  List users = [];
  List<dynamic> _userList = [];
  ApiResponse apiResponse = ApiResponse();
  Future getusers() async {
    final response = await http.get(Uri.parse(usersURL), headers: {
      'Accept': 'application/json',
    });

    apiResponse.data = await jsonDecode(response.body)['users']
        .map((p) => user.fromJson(p))
        .toList();

    setState(() {
      _userList = apiResponse.data as List<dynamic>;
    });

    // var responsebody = jsonDecode(response.body);
    //users.addAll(responsebody);
    print("uuuuuuuuuuuuuuuuuuuuuuuuuuu");
    //print(responsebody);
  }

  @override
  void initState() {
    getusers();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: users == null || users.isEmpty
          ? Center(child: Text("looooooding"))
          : Container(
              child: ListView.builder(
                  itemCount: _userList.length,
                  itemBuilder: (context, i) {
                    user usr = _userList[i];
                    return Text("${usr.name}");
                  })),
    );
  }
}*/
