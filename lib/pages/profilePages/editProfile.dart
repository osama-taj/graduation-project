import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';
import 'package:flutterpartproject/main.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/constans.dart';
import '../../functions/validation.dart';
import '../../services/user_service.dart';

class EditProfile extends StatefulWidget {
  int? id;
  EditProfile({Key? key, this.id}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var respones;
///////////////////////////////////////
  ///get all departement and province for dropbox
  getDepartement() async {
    var respones = await getRequest(departementURL);

    if (respones != null) {
      print("uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuu");
      partList.addAll(respones['departement']);
      ProvinceList.addAll(respones['province']);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

/////
  /// get directoris
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

  Future lodedallinfo() async {
    //get all directorateList for dropbox
    respones = await getRequest(getDirectoratetURL);
    directorateList = respones['Directorates'];

    //   //   //get user information
    respones =
        await postRequest(userInfoEditProfileURL, {"id": widget.id.toString()});

    imagename = respones['user']['iamge'];
    print(imagename);
    selectedpartvalue = respones['user']['departement_id'];
    selecteddirectoratesvalue = respones['user']['citys_id'];
    //selectedProvincevalue = respones['user']['citys_id'];
    selectedUserTypevalue = respones['user']['user_type'];
    namecontroller.text = respones['user']['name'];
    phonecontroller.text = respones['user']['phone'];
    emailcontroller.text = respones['user']['email'];
    desccontroller.text = respones['user']['description'];

    setState(() {});
  }

// to edit user information
  Future updateinfo() async {
    respones = await postRequest(updateprofileURL, {
      "id": userId.getString('userId'),
      "name": namecontroller.text,
      "user_type": "$selectedUserTypevalue",
      "departement_id": "$selectedpartvalue",
      "description": desccontroller.text,
      "email": emailcontroller.text,
      "phone": phonecontroller.text,
      "citys_id": "$selecteddirectoratesvalue",
    });
    if (respones['message'] == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: text("تم  التعديل بنجاح", 20.0, Colors.white)));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lodedallinfo();
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

  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController desccontroller = TextEditingController();
  TextEditingController mohacont = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  List userType = [
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
          title: Text("تعديل الملف الشخصي"),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
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
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF262A4C)),
                          onPressed: isactiv
                              ? () {
                                  uploadimg(myflie!);
                                }
                              : null,
                          child: Text("حفظ")),
                    ],
                  ),
                ),
                Container(
                  child: textform(
                      "أدخل الاسم", false, Icons.person, namecontroller,
                      (value) {
                    return validInput(value!, 4, 25, "username");
                  }),
                ),
                textform("ادخل الايميل ", false, Icons.email, emailcontroller,
                    (value) {
                  return validInput(value!, 5, 100, "email");
                }),
                textform("ادخل رقم الهاتف", false, Icons.phone, phonecontroller,
                    (value) {
                  return validInput(value!, 5, 100, "phone");
                }),
                textFormField2("ادخل الوصف ", desccontroller),

                SizedBox(
                  height: 20,
                ),

                ///
                DropdownButton(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  alignment: Alignment.bottomLeft,
                  hint: const Text(
                    "نوع المستخدم",
                    style: TextStyle(color: Color(0xff9199C0)),
                  ),
                  dropdownColor: Colors.white,
                  isExpanded: true,
                  value: selectedUserTypevalue,
                  items: userType.map((cat) {
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

                ///
                ///
                selectedUserTypevalue != 2
                    ? DropdownButton(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                DropdownButton(
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
                DropdownButton(
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
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF262A4C)),
                    onPressed: () {
                      updateinfo();
                    },
                    child: text(
                        ' حفظ ', 20.0, Color.fromARGB(255, 217, 205, 205))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
