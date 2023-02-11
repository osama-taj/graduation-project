import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';
import 'package:flutterpartproject/main.dart';
import 'package:flutterpartproject/pages/works/likes.dart';
import 'package:flutterpartproject/pages/works/post.dart';
import '../../component/drawer.dart';
import '../../services/constans.dart';
import '../../services/user_service.dart';
import 'img.dart';

class Work extends StatefulWidget {
  Work({Key? key}) : super(key: key);

  @override
  State<Work> createState() => _WorkState();
}

class _WorkState extends State<Work> {
  ///
  List departement = [];
  List work = [];
  String id = '1';
  bool loading = false;
  String? user = userId.getString('userId');
  List? listimage;
  String? allim;
  var im;

// get departement for tabs
  getDepartement() async {
    setState(() {});
    var respones = await getRequest(departementURL);
    setState(() {});
    if (respones != null) {
      departement.addAll(respones['departement']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

// get all works
  getWork() async {
    setState(() {
      loading = true;
    });
    print(id);
    var respones = await postRequest(showWorkURL, {'dep_id': id.toString()});
    setState(() {
      loading = false;
    });

    if (respones != null) {
      work.clear();
      work.addAll(respones['data']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

  @override
  void initState() {
    getDepartement();
    getWork();

    super.initState();
  }

  /////
  List imgs = [];

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          drawer: drawerbody(),
          appBar: AppBar(
            title: Text("الاعمال"),
          ),
          body: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: departement.length,
                    itemBuilder: (context, i) {
                      return Container(
                        padding: EdgeInsets.only(top: 5),
                        margin: const EdgeInsets.only(
                            top: 5, right: 10, bottom: 20),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFE3E3EE),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              setState(() {
                                id = departement[i]['id'].toString();
                                print(id);
                                getWork();
                              });
                            },
                            child: Text(
                              departement[i]['name'],
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 15),
                            )),
                      );
                    },
                  )),
              Expanded(
                flex: 10,
                child: loading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        child: work.isEmpty
                            ? text("لايوجد اعمال", 20.0, Colors.black)
                            : ListView.builder(
                                itemCount: work.length,
                                itemBuilder: (context, i) => Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xff505B96),
                                              blurRadius: 5)
                                        ],
                                      ),
                                      margin: EdgeInsets.all(10),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          Posts(
                                            // calss
                                            bodys: [
                                              work[i]['name'],
                                              work[i]['image'],
                                              work[i]['description'],
                                              work[i]['created_at'],
                                              work[i]['titel']
                                            ],
                                          ),
                                          Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 200,
                                              width: double.infinity,
                                              child: Images(
                                                img: work[i]['images'],
                                              )),
                                          Like(
                                            userId: user!,
                                            workId: work[i]['id'].toString(),
                                          )
                                        ],
                                      ),
                                    )),
                      ),
              ),
            ],
          ),
        ));
  }
}
