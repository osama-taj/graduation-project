import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';
import 'package:flutterpartproject/pages/openWork/openworkDetails.dart';
import 'package:get/get.dart';

import '../../services/constans.dart';
import '../../services/user_service.dart';

class ShowOpenWork extends StatefulWidget {
  ShowOpenWork({Key? key}) : super(key: key);

  @override
  State<ShowOpenWork> createState() => _ShowOpenWorkState();
}

class _ShowOpenWorkState extends State<ShowOpenWork> {
  GlobalKey formkey = GlobalKey();
  List departement = [];
  List province = [];
  List open_work = [];
  bool loading = false;
  var selectedDepartement;
  var selectedProvince;

  /////////////// get departement and province
  getDepartement() async {
    setState(() {
      loading = true;
    });
    var respones = await getRequest(departementURL);

    setState(() {
      loading = false;
    });
    if (respones != null) {
      departement.addAll(respones['departement']);
      province.addAll(respones['province']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

//////////get all open works

  getData() async {
    var respones;
    setState(() {
      loading = true;
    });
    if (selectedDepartement == null) {
      respones = await getRequest(openWork);
    } else {
      respones = await postRequest(filterOpenWork, {
        'provinces_id': selectedProvince.toString(),
        'departement_id': selectedDepartement.toString()
      });
    }
    setState(() {
      loading = false;
    });
    if (respones['Openwork'] != null) {
      open_work.clear();
      open_work.addAll(respones['Openwork']);
      print(open_work);
    } else
      (print("no result"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getDepartement();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(),
          body: Container(
            margin: EdgeInsets.only(top: 30, right: 10, left: 10),
            child: ListView(
              children: [
                Form(
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
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                            });
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        button("فلتر", () {
                          getData();
                        }),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                loading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: open_work.length,
                        itemBuilder: (context, i) => Container(
                              margin: EdgeInsets.only(
                                top: 20,
                              ),
                              padding: EdgeInsets.only(right: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xff9199C0)),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    title: text("${open_work[i]['title']}",
                                        20.0, Color(0xff262A4C)),
                                    subtitle:
                                        Text("${open_work[i]['created_at']}"),
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
                                        "${open_work[i]['pro-name']}",
                                        15.0,
                                        Color.fromARGB(255, 126, 124, 124),
                                      ),
                                      SizedBox(width: 2),
                                      text(
                                        "${open_work[i]['dir-name']}",
                                        15.0,
                                        Color.fromARGB(255, 126, 124, 124),
                                      ),
                                      SizedBox(width: 10),
                                      /////////////////////////

                                      const Icon(
                                        Icons.work,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      text(
                                        "${open_work[i]['dep-name']}",
                                        15.0,
                                        Color.fromARGB(255, 126, 124, 124),
                                      ),
                                      SizedBox(width: 10),
                                      /////////////////////////

                                      const Icon(
                                        Icons.price_change,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      text(
                                        "${open_work[i]['pric']}",
                                        15.0,
                                        Color.fromARGB(255, 126, 124, 124),
                                      ),
                                      SizedBox(width: 10),
                                      const Icon(
                                        Icons.price_change,
                                        size: 15,
                                      ),

                                      text(
                                        "ثلاثة عروض",
                                        15.0,
                                        Color.fromARGB(255, 126, 124, 124),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  text("${open_work[i]['description']}", 15.0,
                                      Colors.black),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF262A4C)),
                                      onPressed: () {
                                        Get.to(() => Detailes(
                                              details: open_work[i],
                                            ));
                                      },
                                      child: text(
                                          ' عرض العمل', 15.0, Colors.white))
                                ],
                              ),
                            )),
              ],
            ),
          )),
    );
  }
}
