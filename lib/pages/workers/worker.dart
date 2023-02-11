import 'package:flutter/material.dart';
import 'package:flutterpartproject/services/constans.dart';

import 'package:flutterpartproject/services/user_service.dart';
import 'package:get/get.dart';

import '../../component/customComponent.dart';
import '../profilePages/profile.dart';

class WorkerSearch extends StatefulWidget {
  var selectedDepartement;
  var selectedDirectorates;
  var selectedProvince;
  WorkerSearch(
      {Key? key,
      this.selectedDepartement,
      this.selectedDirectorates,
      this.selectedProvince})
      : super(key: key);

  @override
  State<WorkerSearch> createState() => _WorkerSearchState();
}

class _WorkerSearchState extends State<WorkerSearch> {
  List departement = [];
  List province = [];
  List directorates = [];

  List workers = [];
  var selectedDepartement;
  var selectedDirectorates;
  var selectedProvince;
  double? evaluation;
  bool loading = false;
  GlobalKey formkey = GlobalKey();

// to get result of search
  getWorker() async {
    setState(() {
      loading = true;
    });

    var respones = await postRequest(searchResultURL, {
      'departement_id': selectedDepartement.toString(),
      'province_id': selectedProvince.toString(),
      'directorate_id': selectedDirectorates.toString()
    });

    setState(() {
      loading = false;
    });
    if (respones['users'] != null) {
      workers.clear();
      workers.addAll(respones['users']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

// //to get all worker and departement and province
  getAllWorker() async {
    var respones2;
    setState(() {
      loading = true;
    });
    var respones = await getRequest(departementURL);

    if (widget.selectedDepartement != null) {
      respones2 = await postRequest(searchResultURL, {
        'departement_id': widget.selectedDepartement.toString(),
        'province_id': widget.selectedProvince.toString(),
        'directorate_id': widget.selectedDirectorates.toString()
      });
    } else {
      respones2 = await getRequest(worker);
    }
    setState(() {
      loading = false;
    });
    if (respones != null || respones2 != null) {
      departement.addAll(respones['departement']);
      province.addAll(respones['province']);
      workers.addAll(respones2['users']);
      print(workers);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

  ///
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
    setState(() {});
  }

  @override
  void initState() {
    getAllWorker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text('العمال'),
          ),
          body: Container(
            child: ListView(
              children: [
                Container(
                    margin: EdgeInsets.all(30),
                    // height: MediaQuery.of(context).size.height - 480,
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
                            button("ابحث عن عامل", () {
                              getWorker();
                            }),
                          ],
                        ))),
                loading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : workers.isEmpty
                        ? Center(
                            child: text('لايوجد نتيجة', 20.0, Colors.black),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: workers.length,
                            itemBuilder: (context, i) => Container(
                                  margin: EdgeInsets.all(10),
                                  child: ListTile(
                                    minVerticalPadding: 20,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side:
                                          BorderSide(color: Color(0xff9199C0)),
                                    ),
                                    leading: InkWell(
                                      child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '$linkimageRoot/${workers[i]['image']}'),
                                                  fit: BoxFit.cover),
                                              border: Border.all(
                                                  color: Color(0xFF262A4C),
                                                  width: 2,
                                                  style: BorderStyle.solid),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(70)))),
                                      onTap: () {
                                        print("pic");
                                      },
                                    ),
                                    title: Row(children: [
                                      text(
                                        '${workers[i]['name']}',
                                        20.0,
                                        Color(0xff262A4C),
                                      ),
                                      SizedBox(width: 5),
                                      text(
                                          "${evaluation = double.parse(workers[i]['total']) / workers[i]['count']}",
                                          15.0,
                                          Colors.black),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: evaluation! >= 1
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: evaluation! >= 2
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: evaluation! >= 3
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: evaluation! >= 4
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 15,
                                        color: evaluation! >= 5
                                            ? Colors.yellow
                                            : Colors.grey,
                                      ),
                                      SizedBox(width: 5),
                                      text("${workers[i]['count']}", 15.0,
                                          Colors.black),
                                    ]),
                                    subtitle: Row(
                                      children: [
                                        const Icon(
                                          Icons.place,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        text(
                                          "${workers[i]['proName']}",
                                          15.0,
                                          Color.fromARGB(255, 126, 124, 124),
                                        ),
                                        SizedBox(width: 4),
                                        text(
                                          "_${workers[i]['dirName']}",
                                          15.0,
                                          Color.fromARGB(255, 126, 124, 124),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.work,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        text(
                                          "${workers[i]['depName']}",
                                          15.0,
                                          Color.fromARGB(255, 126, 124, 124),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    ),
                                    trailing: InkWell(
                                      child: text(
                                        "عرض المزيد",
                                        15.0,
                                        Color(0xff262A4C),
                                      ),
                                      onTap: () {
                                        Get.to(() => Proflie(
                                              id: workers[i]['user_id']
                                                  .toString(),
                                            ));
                                      },
                                    ),
                                  ),
                                )),
              ],
            ),
          ),
        ));
  }
}
