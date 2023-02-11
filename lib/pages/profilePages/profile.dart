import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutterpartproject/services/constans.dart';
import 'package:flutterpartproject/main.dart';
import 'package:flutterpartproject/pages/profilePages/openWork.dart';
import 'package:flutterpartproject/pages/profilePages/work.dart';
// import 'package:flutterpartproject/profilePages/editProfile.dart';
// import 'package:flutterpartproject/profilePages/openWork.dart';
// import 'package:flutterpartproject/profilePages/work.dart';
import 'package:flutterpartproject/services/user_service.dart';

import 'package:get/get.dart';
import '../../component/customComponent.dart';
import '../../functions/validation.dart';
import '../../models/user.dart';
import 'package:flutter/cupertino.dart';

import 'editProfile.dart';

List userInfo = [];
List evaluation = [];
bool loading = false;

class Proflie extends StatefulWidget {
  String? id;
  Proflie({Key? key, this.id}) : super(key: key);

  @override
  State<Proflie> createState() => _ProflieState();
}

class _ProflieState extends State<Proflie> {
  user? myuser;
  var respones;
  int? groupValue = 0;
  var ev;

  List work = [];
  List openWork = [];
  String? name, phone, email, priv, dir, eval, disc, depart, image;

  TextEditingController commentC = new TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future getEval() async {
    var respones = await postRequest(getevslURL, {"id": '1'});
    print(respones);
    return respones;
  }

  Future Eval() async {
    var formedata = formKey.currentState;
    if (formedata!.validate()) {
      var respones = await postRequest(evalURL, {
        "user_id": "${widget.id}",
        "evaluation": "$ev",
        "comment": "${commentC.text}"
      });
      if (respones['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: text("تم التقييم بنجاح", 20.0, Colors.white)));
        setState(() {});
      }
      if (respones['status'] == 'fial') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: text("عذرا لقد قمت بالتقييم مسبقا", 20.0, Colors.white)));
        setState(() {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${respones.error}')));
      }
    }
  }

  getInformation() async {
    setState(() {
      loading = true;
    });
    var respones = await postRequest(userURL, {"id": widget.id.toString()});
    setState(() {
      loading = false;
    });
    if (respones != null) {
      // print(respones);
      userInfo.clear();
      userInfo.addAll(respones['user']);
      work.addAll(respones['work']);
      openWork.addAll(respones['openwork']);
      evaluation.clear();
      evaluation.addAll(respones['eval']);
      print(evaluation);
      print(userInfo);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    showDataAlert() {
      showDialog(
          context: context,
          builder: (context) {
            return Form(
              key: formKey,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20.0,
                    ),
                  ),
                ),
                title: text(" قم بالتقييم ", 20.0, Color(0xff262A4C)),
                content: Container(
                  height: 250,
                  child: SingleChildScrollView(
                    //  padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          child: RatingBar.builder(
                            ignoreGestures: false, //disable
                            initialRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemSize: 25,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 10.0,
                            ),
                            onRatingUpdate: (rating) {
                              ev = rating;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        text(" تعليق", 15.0, Colors.black),
                        textform("أدخل تعليق", false, Icons.person, commentC,
                            (value) {
                          return validInput(value!, 4, 25, "");
                        }),
                        Container(
                          width: double.infinity,
                          height: 60,
                          padding: const EdgeInsets.all(8.0),
                          margin: EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print(userId.getString('userId'));
                              print(userId.getString('userToken'));
                              Eval();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xff262A4C),
                              // fixedSize: Size(250, 50),
                            ),
                            child: const Text(
                              "إضافة",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              actions: [
                Container(
                    padding: EdgeInsets.only(right: 10),
                    child: IconButton(
                        onPressed: () {
                          print(userInfo[0]['user_id']);
                          Get.to(() => EditProfile(id: userInfo[0]['id']));
                        },
                        icon: Icon(Icons.settings)))
              ],
              floating: true,
              pinned: true,
              backgroundColor: Color.fromARGB(255, 8, 47, 80),
              shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              //toolbarHeight:  MediaQuery.of(context).size.height * 0.35),
              expandedHeight: MediaQuery.of(context).size.height - 400,
              flexibleSpace: FlexibleSpaceBar(

                  //title: Text("two"),
                  background: topSliverBar()),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 10,
                          child: IconButton(
                              iconSize: 40.0,
                              onPressed: () {
                                // AwesomDialogInfo(context, "Ali@gmail.com").show();
                                showDataAlert();
                                print("massagge");
                              },
                              icon: const Icon(
                                Icons.add,
                                color: Colors.black,
                              )),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: 50),
                            child: FutureBuilder(
                                future: getEval(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                      height: 120,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          primary: false,
                                          shrinkWrap: true,
                                          itemCount:
                                              snapshot.data['uses'].length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: Color(0xff262A4C)),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              width: 300,
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                      title: Text(
                                                    "${snapshot.data['uses'][i]['name']}",
                                                    style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF262A4C),
                                                    ),
                                                  )),
                                                  Container(
                                                    child: FittedBox(
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            horizontal: 16),
                                                        child: Text(
                                                          "${snapshot.data['uses'][i]['comment']}",
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Color(
                                                                0xFF262A4C),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: RatingBar.builder(
                                                      ignoreGestures:
                                                          true, //disable
                                                      initialRating: snapshot
                                                                  .data['uses'][
                                                              i]['evaluation'] +
                                                          .0,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: false,
                                                      itemSize: 25,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 10.0,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Text("loddddding");
                                  }
                                  return Text("erore");
                                }))
                      ],
                    ),

                    //Cupertino Sliding Segmented Control for work and openwork
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: CupertinoSlidingSegmentedControl<int>(
                        backgroundColor: CupertinoColors.white,
                        thumbColor: Color(0xff9199C0),
                        padding: EdgeInsets.all(8),
                        groupValue: groupValue,
                        children: {
                          0: text('الاعمال', 20.0, Colors.black),
                          1: text('الاعمال المفتوحة', 20.0, Colors.black),
                        },
                        onValueChanged: (value) {
                          setState(() {
                            groupValue = value;
                          });
                        },
                      ),
                    ),
                    groupValue == 0
                        ? userWork(u_work: work)
                        : userOpenWork(u_openWork: openWork)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class topSliverBar extends StatelessWidget {
  topSliverBar({
    Key? key,
  }) : super(key: key);
  String imagename = linkimageRoot;
  @override
  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Center(child: CircularProgressIndicator())
        : Container(
            margin: EdgeInsets.fromLTRB(25, 40, 25, 30),
            child: Column(
              children: [
                //this row for pic and name and star
                Container(
                  width: 70,
                  height: 70,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: imagename + userInfo[0]['image'],
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                // name and star

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: text('${userInfo[0]['name']} ', 20.0, Colors.white),
                ),
                ////
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.place_outlined,
                            color: Colors.white,
                          ),
                          //for city and palice
                          text('${userInfo[0]['privname']} /', 15.0,
                              Colors.white),
                          text(
                              " ${userInfo[0]['dirname']}", 15.0, Colors.white),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.phone_android_sharp,
                      color: Colors.white,
                    ),
                    text('${userInfo[0]['phone']}', 15.0, Colors.white)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.handyman_outlined,
                      color: Colors.white,
                    ),
                    text('${userInfo[0]['departname']}', 15.0, Colors.white)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_sharp,
                      color: Colors.yellow,
                    ),
                    evaluation.isEmpty
                        ? text('0', 15.0, Colors.white)
                        : text(
                            round(
                                int.parse(evaluation[0]['total']) /
                                    evaluation[0]['count'],
                                2),
                            15.0,
                            Colors.white),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                text('${userInfo[0]['description']} ', 15.0, Colors.white),
              ],
            ),
          );
  }
}
