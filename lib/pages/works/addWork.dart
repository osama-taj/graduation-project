import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutterpartproject/services/constans.dart';
import 'package:flutterpartproject/main.dart';
import 'package:image_picker/image_picker.dart';
import '../../component/customComponent.dart';
import '../../functions/validation.dart';
import '../../services/user_service.dart';

class AddWork extends StatefulWidget {
  const AddWork({Key? key}) : super(key: key);

  @override
  State<AddWork> createState() => _AddWorkState();
}

class _AddWorkState extends State<AddWork> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;
  List<File> files = [];
  bool loding = false;
  List departement = [];
  var selectedDepartement;
  TextEditingController address = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController type = TextEditingController();
  GlobalKey<FormState> form_key = GlobalKey<FormState>();

//// get departement for dropbox
  work() async {
    print(userId.getString('userId'));
    loding = true;
    setState(() {});
    var respones = await getRequest(departementURL);
    loding = false;
    setState(() {});

    if (respones['departement'] != null) {
      departement.addAll(respones['departement']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

////////////////////////////////////////////////////////////
  /// to select image from gelry
  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

///////// to upload user work
  up() async {
    var formData = form_key.currentState;
    if (formData!.validate()) {
      for (int i = 0; i < imagefiles!.length; i++) {
        File m = File(imagefiles![i].path);
        files.add(m);
      }

      var respones = await uploadmultipleimage(
          saveWorkURL,
          {
            "user_id": userId.getString('userId'),
            'departement_id': selectedDepartement.toString(),
            'title': address.text,
            'description': discription.text,
          },
          files);
      if (respones['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: text("تم اضافة العمل بنجاح", 20.0, Colors.white)));
        setState(() {});
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${respones.error}')));
      }
    } else {
      print("ont valid");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    work();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("أضافة عمل"),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xff262A4C),
                  ),
                  onPressed: () {
                    up();
                  },
                  child: text("نشر", 20.0, Colors.white),
                )
              ],
            ),

            /*  floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xff262A4C),
              onPressed: pickImages,
              child: Icon(Icons.image),
            ),*/
            body: loding == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.only(top: 5, right: 5, left: 5),
                    padding:
                        const EdgeInsets.only(top: 30, right: 30, left: 30),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Color(0xff505B96), blurRadius: 5)
                      ],
                    ),
                    child: ListView(
                      children: [
                        Form(
                            key: form_key,
                            child: Column(
                              children: [
                                DropdownButtonFormField(
                                  validator: (value) {
                                    return value == null
                                        ? 'الحقل لايمكن ان يكون فارغ'
                                        : null;
                                  },
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
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
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child:
                                          text("العنوان ", 15.0, Colors.black),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: textformfilde(
                                            "مثال: المصباحي ", address,
                                            (value) {
                                          return validInput(value!, 4, 25, "");
                                        }))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: text("الوصف", 15.0, Colors.black),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: textFormField2(
                                        "الوصف",
                                        discription,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )),
                        imagefiles != null
                            ? Container(
                                padding: EdgeInsets.only(top: 30),
                                child: Wrap(
                                  children: imagefiles!.map((imageone) {
                                    return Stack(
                                      children: [
                                        Card(
                                          child: Container(
                                            height: 100,
                                            width: 150,
                                            child: Image.file(
                                                File(imageone.path),
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                        Positioned(
                                          child: GestureDetector(
                                            onTap: () {
                                              // imagefiles!.removeAt();
                                              setState(() {
                                                print(
                                                    'set new state of images');
                                              });
                                            },
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: Color(0xff9199C0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(),

                        /*   Container(
                        padding: EdgeInsets.all(20),
                        child: button("نشر الطلب", "")),*/
                        Container(
                            padding: EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: openImages,
                              style: ElevatedButton.styleFrom(
                                shadowColor: const Color(0xff262A4C),
                                elevation: 15,
                                primary: const Color(0xff262A4C),
                                padding: const EdgeInsets.all(0.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xff262A4C),
                                      Color(0xff505B96),
                                      //Color(0xff9199C0)
                                    ],
                                    begin: Alignment.centerRight,
                                    end: Alignment.centerLeft,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxHeight: 50, maxWidth: 150),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "إضافة صور",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ))));
  }
}
