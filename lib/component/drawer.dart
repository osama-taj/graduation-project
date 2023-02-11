import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';
import 'package:flutterpartproject/main.dart';
import 'package:flutterpartproject/pages/aboutApp.dart';
import 'package:flutterpartproject/pages/openWork/showOpenWorks.dart';
import 'package:flutterpartproject/pages/workers/worker.dart';
import 'package:flutterpartproject/pages/works/work.dart';
import 'package:flutterpartproject/services/user_service.dart';
import 'package:get/get.dart';
import '../services/constans.dart';
import '../pages/profilePages/profile.dart';
import '../pages/works/addWork.dart';
import '../pages/openWork/addOpenWork.dart';
import '../pages/home/bar.dart';

class drawerbody extends StatelessWidget {
  const drawerbody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "$linkimageRoot/${userImage.getString('userImage')}"),
            ),
          ),
          decoration: const BoxDecoration(
            color: Color(0xff262A4C),
          ),
          accountName: Container(
            width: double.infinity,
            child: Text(
              '${userEmail.getString('userEmail')}',
              style: TextStyle(fontSize: 15.0), //textAlign: TextAlign.right
            ),
          ),
          accountEmail: null,
        ),
        listTiles('الصفحه الرئيسيه', Icon(Icons.house), () {
          Get.to(() => Bar());
        }),
        listTiles("الصفحة الشخصية", Icon(Icons.person), () {
          Get.to(() => Proflie(
                id: userId.getString('userId'),
              ));
        }),

        ListTile(
          leading: Icon(Icons.list),
          title: PopupMenuButton(
              child: Text("التصنيفات"),
              itemBuilder: (i) {
                return [
                  const PopupMenuItem(
                    enabled: true,
                    child: Text(" الاعمال"),
                    value: 0,
                  ),
                  PopupMenuItem(
                    enabled:
                        userType.getString('userType') == '2' ? true : false,
                    child: Text(" اضافة عمل مفتوح"),
                    value: 1,
                  ),
                  const PopupMenuItem(
                    enabled: true,
                    child: Text("معرض الاعمال المفتوحة"),
                    value: 2,
                  ),
                  PopupMenuItem(
                    enabled:
                        userType.getString('userType') != '2' ? true : false,
                    child: Text("إضافة عمل"),
                    value: 3,
                  ),
                  const PopupMenuItem(
                    enabled: true,
                    child: Text("العمال"),
                    value: 4,
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  Get.to(Work());
                } else if (value == 1) {
                  Get.to(OpenWorks());
                } else if (value == 2) {
                  Get.to(ShowOpenWork());
                } else if (value == 3) {
                  Get.to(const AddWork());
                } else if (value == 4) {
                  Get.to(WorkerSearch());
                }
              }),
          onTap: () {},
        ),

        listTiles("عن التطبيق ", Icon(Icons.info), () {
          Get.to(() => AboutApp());
        }),

        listTiles('تسجيل الخروج', Icon(Icons.logout), () {
          logout();
        }),

        //----------------------------
      ],
    ));
  }
}
