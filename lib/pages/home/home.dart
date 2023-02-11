import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutterpartproject/services/constans.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:flutterpartproject/pages/workers/worker.dart';
import '../../component/customComponent.dart';
import 'package:flutterpartproject/services/user_service.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../component/drawer.dart';
import '../../functions/validation.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey formkey = GlobalKey();

  List departement = [];
  List directorates = [];
  List province = [];
  List morEvaluation = [];
  List user = [];

  double evaluation = 1.0;
  bool loading = false;
  var selectedDepartement;
  var selectedDirectorates;
  var selectedProvince;

  // //
  // final parse = [
  //   MatchText(
  //       type: ParsedType.PHONE,
  //       style: const TextStyle(
  //         color: Colors.red,
  //         fontSize: 24,
  //       ),
  //       onTap: (url) {
  //         //   launch("tel:" + url);
  //       }),
  // ];
  // //

  //animated text
  List<MaterialColor> colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  TextStyle colorizeTextStyle = const TextStyle(
    fontSize: 30.0,
    fontFamily: 'Horizon',
  );

///////////// get departement ,province, mor evaluation user
  getData() async {
    setState(() {
      loading = true;
    });
    var respones = await getRequest(homeURL);

    setState(() {
      loading = false;
    });

    if (respones != null) {
      departement.addAll(respones['departemnts']);
      province.addAll(respones['province']);
      morEvaluation.addAll(respones['users']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

  /// get directorates
  getdirectorates() async {
    selectedDirectorates = null;
    var respones =
        await postRequest(searchURL, {'id': selectedProvince.toString()});
    setState(() {});
    if (respones['directorates'] != null) {
      directorates.clear();
      directorates.addAll(respones['directorates']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

  //

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("حلقة وصل"),
          ),
          drawer: drawerbody(),
          body: ListView(
            children: [
              Container(
                child: Column(
                  children: [
                    ///clip path
                    ClipPath(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          color: Color(0xff262A4C),
                          child: Image.asset(
                            "images/close-up-hard-hat-holding-by-construction-worker.jpg",
                            fit: BoxFit.fill,
                          )),
                      clipper: CustomClipPath(),
                    ),

                    Container(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'اهلا بكم في منصة حلقة وصل',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                          ),
                          ColorizeAnimatedText(
                            'انجز اعمالك بسهوله وامان',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                          ),
                          ColorizeAnimatedText(
                            'تصفح وشاهد الاعمال',
                            textStyle: colorizeTextStyle,
                            colors: colorizeColors,
                          ),
                        ],
                        repeatForever: true,
                        onTap: () {
                          print("Tap Event");
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),

                    /////
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              DropdownButton(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                // alignment: Alignment.bottomRight,
                                hint: const Text(
                                  "المهنة",
                                  style: TextStyle(color: Color(0xff9199C0)),
                                ),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                value: selectedDepartement,
                                items: departement.map((cat) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      cat['name'],
                                    ),
                                    value: cat['id'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDepartement = value;
                                  });
                                },
                              ),

                              DropdownButton(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                alignment: Alignment.bottomLeft,
                                hint: const Text(
                                  "المحافظة",
                                  style: TextStyle(color: Color(0xff9199C0)),
                                ),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                value: selectedProvince,
                                items: province.map((cat) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      cat['name'],
                                    ),
                                    value: cat['id'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedProvince = value;

                                    getdirectorates();
                                  });
                                },
                              ),
                              DropdownButton(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                alignment: Alignment.bottomLeft,
                                hint: const Text(
                                  "المديرية",
                                  style: TextStyle(color: Color(0xff9199C0)),
                                ),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                value: selectedDirectorates,
                                items: directorates.map((cat) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      cat['name'],
                                    ),
                                    value: cat['id'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedDirectorates = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //// button
                              button("ابحث عن عامل", () {
                                Get.to(() => WorkerSearch(
                                      selectedDepartement: selectedDepartement,
                                      selectedDirectorates:
                                          selectedDirectorates,
                                      selectedProvince: selectedProvince,
                                    ));
                              }),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 70, right: 20),
                child: text("الكثير من المهن ", 20.0, Colors.black),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    itemCount: departement.length > 6 ? 6 : departement.length,
                    itemBuilder: (context, i) {
                      return Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xff505B96),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.handyman_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                            text(
                                "${departement[i]['name']}", 20.0, Colors.white)
                          ],
                        ),
                      );
                    }),
              ),
              Container(
                padding: EdgeInsets.only(top: 70, right: 20),
                child: text("العمال الاكثر تقييم ", 20.0, Colors.black),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height - 400,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: morEvaluation.length,
                    itemBuilder: (context, i) => Container(
                      width: 150,
                      margin: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 2),
                            width: double.infinity,
                            height: 120,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "$linkimageRoot/${morEvaluation[i]['image']}",
                                    ),
                                    fit: BoxFit.fill)),
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: text("${morEvaluation[i]['name']}",
                                      20.0, Color(0xff262A4C)),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.place,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    text(
                                      "${morEvaluation[i]['proName']}",
                                      15.0,
                                      Color.fromARGB(255, 126, 124, 124),
                                    ),
                                    SizedBox(width: 10),
                                    text(
                                      "${morEvaluation[i]['dirName']}",
                                      15.0,
                                      Color.fromARGB(255, 126, 124, 124),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.work,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    text(
                                      "${morEvaluation[i]['depName']}",
                                      15.0,
                                      Color.fromARGB(255, 126, 124, 124),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      size: 15,
                                    ),
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    text(
                                      "${morEvaluation[i]['phone']}",
                                      15.0,
                                      Color.fromARGB(255, 126, 124, 124),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(children: [
                                  text(
                                      round(
                                          int.parse(morEvaluation[i]['total']) /
                                              morEvaluation[i]['count'],
                                          1),
                                      15.0,
                                      Colors.black),
                                  SizedBox(width: 5),
                                  Container(
                                    child: RatingBar.builder(
                                      ignoreGestures: true, //disable
                                      initialRating: evaluation = double.parse(
                                                  morEvaluation[i]['total']) /
                                              morEvaluation[i]['count'] +
                                          .0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemSize: 10,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 1.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 5.0,
                                      ),
                                      onRatingUpdate: (rating) {},
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  text("(${morEvaluation[i]['count']})", 15.0,
                                      Colors.black),
                                ]),
                                /* ParsedText(
                            text: '${morEvaluation[i]['phone']}',
                            style: TextStyle(color: Colors.black),
                            overflow: TextOverflow.clip,
                            parse: parse,
                            regexOptions: RegexOptions(caseSensitive: false),
                          ),*/
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
