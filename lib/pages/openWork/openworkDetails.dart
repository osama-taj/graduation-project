import 'package:flutter/material.dart';
import 'package:flutterpartproject/component/customComponent.dart';
import 'package:flutterpartproject/services/constans.dart';
import 'package:flutterpartproject/main.dart';
import 'package:flutterpartproject/pages/profilePages/profile.dart';
import 'package:flutterpartproject/services/user_service.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import '../../functions/validation.dart';

class Detailes extends StatefulWidget {
  final Map details;
  Detailes({Key? key, required this.details}) : super(key: key);

  @override
  State<Detailes> createState() => _DetailesState();
}

class _DetailesState extends State<Detailes> {
  TextEditingController dayC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List offer = [];
  bool loading = false;
  String message = '';

  @override
  void initState() {
    // TODO: implement initState
    print(widget.details);
    getOffers();
  }

///////// to get all offers
  getOffers() async {
    setState(() {
      loading = true;
    });
    var respones =
        await postRequest(offers, {'id': widget.details['id'].toString()});

    setState(() {
      loading = false;
    });
    if (respones != null) {
      offer.clear();
      offer.addAll(respones['offers']);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${respones.error}')));
    }
  }

///// add new offer
  addOffers() async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      var respones = await postRequest(addOfferURL, {
        'id': widget.details['id'].toString(),
        'user_id': userId.getString('userId'),
        'description': descriptionC.text,
        'num_day': dayC.text,
        'pric': priceC.text
      });

      if (respones != null) {
        message = respones['message'];
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: text("$message", 20.0, Colors.white)));
        getOffers();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${respones.error}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    text("تم النشر بواسطة", 20.0, Colors.black),
                    Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    '$linkimageRoot/${widget.details['image']}'),
                                fit: BoxFit.cover),
                            border: Border.all(
                                color: Color(0xFF262A4C),
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(70)))),
                    InkWell(
                      onTap: () {
                        Get.to(() => Proflie(
                              id: widget.details['user_id'].toString(),
                            ));
                      },
                      child: text(
                        "${widget.details['name']}",
                        15.0,
                        Color(0xff262A4C),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      text(
                        "${widget.details['title']}",
                        20.0,
                        Color(0xff262A4C),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      text('${widget.details['description']}', 20.0,
                          Colors.black),
                      const ReadMoreText(
                        '',
                        trimLines: 2,
                        // colorClickableText: Colors.purple,
                        trimMode: TrimMode.Length,
                        trimCollapsedText: 'عرض المزيد',
                        trimExpandedText: 'عرض اقل',
                        moreStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF505B96)),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        lessStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF505B96)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      text("التفاصيل", 20.0, Colors.black),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: text(" المطلوب  ", 15.0, Colors.black),
                          ),
                          Expanded(
                              flex: 3,
                              child: text(" ${widget.details['dep-name']}  ",
                                  15.0, Color.fromARGB(255, 125, 125, 125)))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: text(" الموقع  ", 15.0, Colors.black),
                          ),
                          Expanded(
                              flex: 3,
                              child: text(" ${widget.details['address']}", 15.0,
                                  Color.fromARGB(255, 125, 125, 125)))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child:
                                text(" ينفذ العمل في   ", 15.0, Colors.black),
                          ),
                          Expanded(
                              flex: 3,
                              child: text("  ${widget.details['num_day']} ايام",
                                  15.0, Color.fromARGB(255, 125, 125, 125)))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: text(" السعر  ", 15.0, Colors.black),
                          ),
                          Expanded(
                              flex: 3,
                              child: text(
                                  "  ${widget.details['pric']} ريال يمني ",
                                  15.0,
                                  Color.fromARGB(255, 125, 125, 125)))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      widget.details['user_id'] == userId.getString('userId')
                          ? Container()
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF262A4C)),
                              onPressed: () {
                                print(userId.getString('userId'));
                                print(widget.details['user_id']);
                                showDataAlert();
                              },
                              child: text('تقديم عرض', 15.0, Colors.white))
                    ],
                  ),
                )),
            SizedBox(
              height: 40,
            ),
            Container(
                padding: EdgeInsets.only(right: 10),
                child: text('العروض', 25.0, Color(0xff262A4C))),
            loading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : offer.isEmpty
                    ? Center(child: text("لايوجد عروض", 15.0, Colors.black))
                    : Expanded(
                        flex: 3,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: offer.length,
                            itemBuilder: (context, i) => Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Color(0xff9199C0)),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      margin: EdgeInsets.all(15),
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              dense: true,
                                              leading: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "$linkimageRoot/${offer[i]['image']}"),
                                                          fit: BoxFit.cover),
                                                      border: Border.all(
                                                          color:
                                                              Color(0xFF262A4C),
                                                          width: 2,
                                                          style: BorderStyle
                                                              .solid),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  70)))),
                                              title: text('${offer[i]['name']}',
                                                  20.0, Color(0xff262A4C)),
                                              subtitle: Text(
                                                  '${offer[i]['created_at']}'),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: text(
                                                      " ينفذ العمل في   ",
                                                      15.0,
                                                      Colors.black),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: text(
                                                        "${offer[i]['num_day']} ايام",
                                                        15.0,
                                                        const Color.fromARGB(
                                                            255,
                                                            125,
                                                            125,
                                                            125)))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: text(" السعر  ", 15.0,
                                                      Colors.black),
                                                ),
                                                Expanded(
                                                    flex: 3,
                                                    child: text(
                                                        "  ${offer[i]['pric']} ريال يمني ",
                                                        15.0,
                                                        const Color.fromARGB(
                                                            255,
                                                            125,
                                                            125,
                                                            125)))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            text("${offer[i]['description']}",
                                                15.0, Colors.black),
                                          ]),
                                    ),
                                  ],
                                )))
          ],
        ),
      ),
    );
  }

//////////////// dialog to add new offer
  showDataAlert() {
    showDialog(
        context: context,
        builder: (context) {
          return Form(
            key: formKey,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    20.0,
                  ),
                ),
              ),
              title: text("تقديم عرض", 20.0, Color(0xff262A4C)),
              content: Container(
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      text("عدد الايام", 15.0, Colors.black),
                      textformfilde("مثال: 5 ايام  ", dayC, (value) {
                        return validInput(value!, 1, 25, "number");
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      text("السعر ", 15.0, Colors.black),
                      textformfilde("مثال:5000  ", priceC, (value) {
                        return validInput(value!, 1, 25, "number");
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      text(" الوصف", 15.0, Colors.black),
                      textformfilde("ادخل الوصف", descriptionC, (value) {
                        return validInput(value!, 4, 25, "");
                      }),
                      Container(
                        width: double.infinity,
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        margin: EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigator.of(context).pop();
                            addOffers();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff262A4C),
                            // fixedSize: Size(250, 50),
                          ),
                          child: const Text(
                            "إضافة",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
