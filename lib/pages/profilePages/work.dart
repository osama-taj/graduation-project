import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../component/customComponent.dart';
import '../../main.dart';
import '../works/likes.dart';

class userWork extends StatelessWidget {
  final List u_work;
  userWork({Key? key, required this.u_work}) : super(key: key);
  String? user_id = userId.getString('userId');
  @override
  Widget build(BuildContext context) {
    return u_work.isEmpty
        ? text("لايوجد اعمال", 15.0, Colors.black)
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: u_work.length,
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
                children: [
                  text('${u_work[i]['titel']}', 15.0, Colors.black),
                  ReadMoreText(
                    ' ${u_work[i]['description']}',
                    trimLines: 2,
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
                  Like(userId: user_id!, workId: u_work[i]['id'].toString())
                ],
              ),
            ),
          );
  }
}
