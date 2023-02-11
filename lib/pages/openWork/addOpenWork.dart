import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutterpartproject/main.dart';
import 'package:flutterpartproject/models/departement.dart';
import 'package:flutterpartproject/services/user_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../component/customComponent.dart';
import '../../services/constans.dart';
import '../../functions/validation.dart';

import '../../models/api_response.dart';

class OpenWorks extends StatefulWidget {
  OpenWorks({Key? key}) : super(key: key);

  @override
  State<OpenWorks> createState() => _OpenWorksState();
}

class _OpenWorksState extends State<OpenWorks> {
  List departement = [];
  List directorates = [];
  List province = [];
  var selectedDepartement;
  var selectedDirectorates;
  var selectedProvince;

  TextEditingController days = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController descripJop = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController place = TextEditingController();
  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  /// get departement for dropbox
  getDepartement() async {
    var respones = await getRequest(departementURL);
    setState(() {});
    if (respones != null) {
      departement.addAll(respones['departement']);
      province.addAll(respones['province']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

////// get directorateis
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

  /////////////////////
  save_open_work() async {
    var formData = form_key.currentState;
    if (formData!.validate()) {
      var respones = await postRequest(
        saveURL,
        {
          "user_id": userId.getString('userId'),
          'departement_id': selectedDepartement.toString(),
          'province_id': selectedProvince.toString(),
          'directorate_id': selectedDirectorates.toString(),
          'title': address.text,
          'description': descripJop.text,
          'num_day': days.text,
          'pric': price.text,
          'address': place.text,
        },
      );

      if (respones['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: text("تم اضافة العمل بنجاح", 20.0, Colors.white)));
        setState(() {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${respones.error}')));
      }
    }
  }

  @override
  void initState() {
    getDepartement();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              title: const Text(" الاعمال المفتوحة"),
            ),
            body: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(30),
              child: ListView(
                //  reverse: true,
                children: [
                  Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: text("قم بتعبئة البيانات المطلوبة", 25.0,
                          const Color(0xFF262A4C))),
                  Form(
                    key: form_key,
                    child: Column(
                      children: [
                        DropdownButtonFormField(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
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
                                selectedProvince = value as int?;

                                getdirectorates();
                              });
                            },
                            validator: (value) => value == null
                                ? 'الحقل لايمكن ان يكون فارغ'
                                : null),

                        DropdownButtonFormField(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                selectedDirectorates = value as int?;
                              });
                            },
                            validator: (value) => value == null
                                ? 'الحقل لايمكن ان يكون فارغ'
                                : null),

                        DropdownButtonFormField(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            alignment: Alignment.bottomLeft,
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
                                selectedDepartement = value as int?;
                              });
                            },
                            validator: (value) => value == null
                                ? 'الحقل لايمكن ان يكون فارغ'
                                : null),
                        //////////////////////
                        ///
                        textformfilde("ادخل الوصف", descripJop, (value) {
                          return validInput(value!, 4, 25, "");
                        }),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child:
                                  text(" العمل المطلوب  ", 15.0, Colors.black),
                            ),
                            Expanded(
                                flex: 2,
                                child: textformfilde(
                                    "مثال تبليط عمارة   ", address, (value) {
                                  return validInput(value!, 4, 25, "");
                                }))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: text(" الموقع ", 15.0, Colors.black),
                            ),
                            Expanded(
                                flex: 2,
                                child: textformfilde("المصباحي   ", place,
                                    (value) {
                                  return validInput(value!, 4, 25, "");
                                }))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child:
                                  text(" الدوام المطلوب", 15.0, Colors.black),
                            ),
                            Expanded(
                                flex: 2,
                                child: textformfilde("مثال: 5 ايام  ", days,
                                    (value) {
                                  return validInput(value!, 1, 25, "number");
                                }))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: text("السعر", 15.0, Colors.black),
                            ),
                            Expanded(
                                flex: 2,
                                child: textformfilde(
                                    "مثال: 40000 ريال يمني  ", price, (value) {
                                  return validInput(value!, 1, 25, "number");
                                }))
                          ],
                        ),
                        ///////////// button
                        Container(
                            padding: EdgeInsets.all(20),
                            child: button("نشر الطلب", () {
                              save_open_work();
                            })),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
