import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterpartproject/services/constans.dart';
import 'package:flutterpartproject/services/user_service.dart';
import 'package:like_button/like_button.dart';

class Like extends StatefulWidget {
  final String userId;
  final String workId;
  Like({Key? key, required this.userId, required this.workId})
      : super(key: key);

  @override
  State<Like> createState() => _LikeState();
}

class _LikeState extends State<Like> {
  int like = 0;
  bool islke = false;
  var count;
  // var check;
  List checkanylike = [];

//// if user has like befor to make the favorite icon red
  istrue() async {
    var respones = await postRequest(
        checkanyLikeURL, {'work_id': widget.workId, 'id': widget.userId});
    checkanylike.clear();
    checkanylike.addAll(respones['data']);
    setState(() {});
    if (checkanylike.isEmpty) {
      islke = false;
    } else {
      islke = true;
    }
  }

//to add like
  Future<bool> addLike(bool islike) async {
    //if user has like befor
    var respones = await postRequest(
        checkanyLikeURL, {'work_id': widget.workId, 'id': widget.userId});
    checkanylike.clear();
    checkanylike.addAll(respones['data']);
    setState(() {});
    if (checkanylike.isEmpty) {
      like = 1;
    } else {
      like = 0;
    }
///////////////////////////////////////////////////// to add like or unlike
    var respones2 = await postRequest(LikesURL, {
      'heart_fill': like.toString(),
      'work_id': widget.workId,
      'user_id': widget.userId
    });

    if (respones2['messge'] == 'like') {
      return true;
    } else {
      return false;
    }
  }

//get count of likes
  getCount() async {
    var respones = await postRequest(CountLikeURL, {
      'work_id': widget.workId,
    });
    setState(() {});
    if (respones != null) {
      count = (respones['count']);
      print(respones['count']);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCount();
    istrue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Expanded(
        child: Row(
          children: [
            LikeButton(
              isLiked: islke,
              size: 20,
              circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                print(isLiked);
                return Icon(
                  Icons.favorite,
                  color: isLiked ? Colors.red : Colors.grey,
                  size: 20,
                );
              },
              likeCount: count,
              onTap: addLike,
            )
          ],
        ),
      ),
    );
  }
}
