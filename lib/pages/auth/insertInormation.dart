import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';
import 'package:flutterpartproject/main.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/constans.dart';
import '../../functions/validation.dart';
import '../../services/user_service.dart';
import '../home/bar.dart';

class inserInfo extends StatefulWidget {
  inserInfo({Key? key}) : super(key: key);

  @override
  State<inserInfo> createState() => _inserInfoState();
}

class _inserInfoState extends State<inserInfo> {
  var respones;
///////////////////////////////////////
  ///get all departement for dropbox
  getDepartement() async {
    var respones = await getRequest(departementURL);
    if (respones != null) {
      partList.addAll(respones['departement']);
      ProvinceList.addAll(respones['province']);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

// get directorates for dropbox
  getdirectorates() async {
    selecteddirectoratesvalue = null;
    var respones =
        await postRequest(searchURL, {'id': selectedProvincevalue.toString()});
    setState(() {});
    if (respones['directorates'] != null) {
      directorateList.clear();
      directorateList.addAll(respones['directorates']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
    setState(() {});
  }

  ////////////////////////////////
// for add the rest user information
  Future addInfo() async {
    var formdata = form_key.currentState;
    if (formdata!.validate()) {
      respones = await postRequest(addCompletInfoURL, {
        "id": userId.getString('userId'),
        "user_type": "$selectedUserTypevalue",
        "departement_id": "$selectedpartvalue",
        "description": descriptioncontroller.text,
        "phone": phonecontroller.text,
        "citys_id": "$selecteddirectoratesvalue",
      });
      if (respones['message'] == 'seccuess') {
        userEmail.setString("userEmail", respones['data']['email']);
        userImage.setString("userImage", respones['data']['image']);
        userType.setString(
            "userType", respones['data']['user_type'].toString());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: text("تم إضافة البيانات", 20.0, Colors.white)));
        setState(() {});

        Get.offAll(Bar());
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${respones.error}')));
      }
      print(respones);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getDepartement();
    setState(() {});
  }

  final ImagePicker _picker = ImagePicker();
  File? myflie;
  bool isactiv = false;
  int? selectedpartvalue;
  int? selectedProvincevalue;
  int? selecteddirectoratesvalue;
  int? selectedUserTypevalue;
  String? imagename;
  List partList = [];
  List directorateList = [];
  List ProvinceList = [];

  TextEditingController phonecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  GlobalKey<FormState> form_key = GlobalKey<FormState>();

  List userTypes = [
    {'id': 1, 'name': 'عامل'},
    {'id': 2, 'name': 'صاحب عمل'},
    {'id': 3, 'name': 'عامل وصاحب عمل'}
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("اكمل تسجيل بياناتك "),
        ),
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: 120,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(100)),
                              child: myflie == null
                                  ? Container()
                                  : Image.file(
                                      myflie!,
                                    )),
                          Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(80, 0, 0, 0),
                                        Color.fromARGB(80, 0, 0, 0),
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter),
                                  borderRadius: BorderRadius.circular(100)),
                              child: IconButton(
                                onPressed: () async {
                                  XFile? xflie = await _picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (xflie != null) {
                                    myflie = File(xflie.path);
                                    isactiv = true;

                                    setState(() {});
                                  } else {}
                                },
                                icon: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              )),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: isactiv
                              ? () {
                                  uploadimg(myflie!);
                                }
                              : null,
                          child: Text("حفظ")),
                    ],
                  ),
                ),
                Form(
                    key: form_key,
                    child: Column(
                      children: [
                        textform("ادخل رقم الهاتف", false, Icons.phone,
                            phonecontroller, (value) {
                          return validInput(value!, 5, 100, "phone");
                        }),
                        textFormField2("ادخل الوصف ", descriptioncontroller),

                        const SizedBox(
                          height: 20,
                        ),

                        DropdownButtonFormField(
                          validator: (value) => value == null
                              ? 'الحقل لايمكن ان يكون فارغ'
                              : null,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          alignment: Alignment.bottomLeft,
                          hint: const Text(
                            "نوع المستخدم",
                            style: TextStyle(color: Color(0xff9199C0)),
                          ),
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          value: selectedUserTypevalue,
                          items: userTypes.map((cat) {
                            return DropdownMenuItem(
                              child: Text(
                                cat['name'],
                              ),
                              value: cat['id'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUserTypevalue = value as int?;
                            });
                          },
                        ),

                        selectedUserTypevalue != 2
                            ? DropdownButtonFormField(
                                validator: (value) => value == null
                                    ? 'الحقل لايمكن ان يكون فارغ'
                                    : null,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                alignment: Alignment.bottomLeft,
                                hint: const Text(
                                  "المهنة",
                                  style: TextStyle(color: Color(0xff9199C0)),
                                ),
                                dropdownColor: Colors.white,
                                isExpanded: true,
                                value: selectedpartvalue,
                                items: partList.map((cat) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      cat['name'],
                                    ),
                                    value: cat['id'],
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedpartvalue = value as int?;
                                  });
                                },
                              )
                            : Container(),

                        DropdownButtonFormField(
                          validator: (value) => value == null
                              ? 'الحقل لايمكن ان يكون فارغ'
                              : null,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          alignment: Alignment.bottomLeft,
                          hint: const Text(
                            "المحافظة",
                            style: TextStyle(color: Color(0xff9199C0)),
                          ),
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          value: selectedProvincevalue,
                          items: ProvinceList.map((cat) {
                            return DropdownMenuItem(
                              child: Text(
                                cat['name'],
                              ),
                              value: cat['id'],
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedProvincevalue = value as int?;
                              getdirectorates();
                            });
                          },
                        ),
                        DropdownButtonFormField(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            alignment: Alignment.bottomLeft,
                            hint: const Text(
                              "المديرية",
                              style: TextStyle(color: Color(0xff9199C0)),
                            ),
                            dropdownColor: Colors.white,
                            isExpanded: true,
                            value: selecteddirectoratesvalue,
                            items: directorateList.map((cat) {
                              return DropdownMenuItem(
                                child: Text(
                                  cat['name'],
                                ),
                                value: cat['id'],
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selecteddirectoratesvalue = value as int?;
                              });
                            },
                            validator: (value) {
                              setState(() {
                                value == null
                                    ? 'الحقل لايمكن ان يكون فارغ'
                                    : null;
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 57, 59, 80)),
                            onPressed: () {
                              addInfo();
                            },
                            child: text(' حفظ ', 20.0, Colors.white)),

                        //////
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
