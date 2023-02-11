import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../component/customComponent.dart';
import '../openWork/openworkDetails.dart';

class userOpenWork extends StatelessWidget {
  final List u_openWork;
  const userOpenWork({Key? key, required this.u_openWork}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return u_openWork.isEmpty
        ? text(" لايوجد اعمال مفتوحة", 15.0, Colors.black)
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: u_openWork.length,
            itemBuilder: (context, i) => Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xff9199C0),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        dense: true,
                        title: text("${u_openWork[i]['title']}", 20.0,
                            Color(0xff262A4C)),
                        subtitle: Text("${u_openWork[i]['created_at']}"),
                        trailing: text(
                          u_openWork[i]['stage'] == '3'
                              ? "مكنمل"
                              : u_openWork[i]['stage'] == '2'
                                  ? " جاري التنفيذ"
                                  : " مفتوح",
                          17.0,
                          Colors.black,
                        ),
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
                            "${u_openWork[i]['pro-name']}",
                            15.0,
                            Color.fromARGB(255, 126, 124, 124),
                          ),
                          SizedBox(width: 2),
                          text(
                            "${u_openWork[i]['dir-name']}",
                            15.0,
                            Color.fromARGB(255, 126, 124, 124),
                          ),
                          SizedBox(width: 10),
                          /////////////////////////

                          Icon(
                            Icons.work,
                            size: 15,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          text(
                            "${u_openWork[i]['dep-name']}",
                            15.0,
                            Color.fromARGB(255, 126, 124, 124),
                          ),
                          SizedBox(width: 10),
                          /////////////////////////

                          Icon(
                            Icons.price_change,
                            size: 15,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          text(
                            "${u_openWork[i]['pric']}",
                            15.0,
                            Color.fromARGB(255, 126, 124, 124),
                          ),
                          SizedBox(width: 10),
                          Icon(
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
                      text("${u_openWork[i]['description']}", 15.0,
                          Colors.black),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF262A4C)),
                          onPressed: () {
                            Get.to(() => Detailes(
                                  details: u_openWork[i],
                                ));
                          },
                          child: text(' عرض العمل', 15.0, Colors.white))
                    ],
                  ),
                ));
  }
}
