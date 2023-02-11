import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:photo_view/photo_view.dart';

import '../../services/constans.dart';

class Posts extends StatelessWidget {
  Posts({Key? key, required List<String> bodys})
      : this.bodys = bodys,
        super(key: key);
  final List<String> bodys;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              dense: true,
              leading: InkWell(
                child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              '$linkimageRoot/${bodys[1]}',
                            ),
                            fit: BoxFit.cover),
                        border: Border.all(
                            color: Color(0xFF262A4C),
                            width: 2,
                            style: BorderStyle.solid),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(70)))),
                onTap: () {
                  print("pic");
                },
              ),
              title: InkWell(
                child: text('${bodys[0]}', 20.0, Color(0xFF262A4C)),
                onTap: () {
                  print(bodys);
                },
              ),
              subtitle: Text(bodys[3]),
            ),
            SizedBox(
              height: 10,
            ),
            text('${bodys[4]}', 15.0, Colors.black),
            ReadMoreText(
              bodys[2],
              trimLines: 2,
              // colorClickableText: Colors.purple,
              trimMode: TrimMode.Length,
              trimCollapsedText: 'عرض المزيد',
              trimExpandedText: 'عرض اقل',
              moreStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505B96)),
              style: const TextStyle(color: Colors.black, fontSize: 16),
              lessStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF505B96)),
            ),
          ]),
    );
  }
}
