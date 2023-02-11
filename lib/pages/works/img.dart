// import 'package:flutter/material.dart';
// import 'package:carousel_pro/carousel_pro.dart';
// import 'package:flutterpartproject/constans.dart';
// import 'package:photo_view/photo_view.dart';

// class Images extends StatelessWidget {
//   const Images({Key? key, required List listimg})
//       : this.listimg = listimg,
//         super(key: key);
//   final List listimg;

//   @override
//   Widget build(BuildContext context) {
//     return Container(child: Text(""));
//     // child: ListView.builder(
//     //     itemCount: listimg.length,
//     //     itemBuilder: (context, i) => Text(listimg[i])));

//     /* Carousel(
//       boxFit: BoxFit.cover,
//       autoplay: false,
//       dotSize: 8,
//       dotIncreasedColor: const Color(0xff9199C0),
//       // dotColor: Color(0xFFE3E3EE),
//       dotBgColor: Colors.transparent,
//       dotPosition: DotPosition.bottomCenter,
//       dotVerticalPadding: 10.0,
//       showIndicator: true,
//       indicatorBgPadding: 3,
//       images: [
//         for (int i = 1; i < listimg.length; i++)
//           {
//             /* CachedNetworkImage(
//             imageUrl: '${listimg[i]}',
//             placeholder: (context, url) =>
//                 Center(child: CircularProgressIndicator()),
//             errorWidget: (context, url, error) => Icon(Icons.error),
//             fit: BoxFit.fill,
//           )*/
//             listimg[i].substring(1, listimg[i].length() - 1),
//             PhotoView(
//               imageProvider: NetworkImage('$linkimageWork/ ${listimg[i]}'),
//             ),
//           }
//       ],
//     );*/
//   }
// }

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../services/constans.dart';

class Images extends StatefulWidget {
  var img;
  Images({Key? key, this.img}) : super(key: key);

  @override
  State<Images> createState() => _ImagesState();
}

class _ImagesState extends State<Images> {
  List listimages = [];

  // نحول الصور الى نص
  siprateimages() {
    String images = widget.img;
    print(images);
    images = images.replaceAll('"', "");
    print(images);
    images = images.substring(1, images.length - 1);
    print(images);
    listimages = images.split(','); // هنا اتحولت لست وخلاص نستعمله طبيعي
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    print(widget.img);
    siprateimages();
  }

  @override
  Widget build(BuildContext context) {
    return Carousel(
      boxFit: BoxFit.cover,
      autoplay: false,
      dotSize: 8,
      dotIncreasedColor: const Color(0xff9199C0),
      // dotColor: Color(0xFFE3E3EE),
      dotBgColor: Colors.transparent,
      dotPosition: DotPosition.bottomCenter,
      dotVerticalPadding: 10.0,
      showIndicator: true,
      indicatorBgPadding: 3,
      images: [
        for (int i = 1; i < listimages.length; i++)
          //   CachedNetworkImage(
          //     imageUrl: '${listimg[i]}',
          //     placeholder: (context, url) =>
          //         Center(child: CircularProgressIndicator()),
          //     errorWidget: (context, url, error) => Icon(Icons.error),
          //     fit: BoxFit.fill,
          //
          PhotoView(
            imageProvider: NetworkImage('$linkimageWork/${listimages[i]}'),
          ),
      ],
    );
  }
}
