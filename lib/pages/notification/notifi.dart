import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NotifiPage extends StatefulWidget {
  NotifiPage({Key? key}) : super(key: key);

  @override
  _NotifiPageState createState() => _NotifiPageState();
}

///////////////////////////////////////////
///

var mynotifi2 = [
  {
    'name': 'Osama',
    'img': 'https://picsum.photos/250?image=9',
    'comment': 'greet job you done ',
    'type': 2,
    'time': '2 sept'
  },
  {
    'name': 'Roqiah',
    'img':
        'https://images.unsplash.com/photo-1628694647734-bf4aedeede1e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'comment': 'i like it ... nice ',
    'type': 1,
    'time': '2 Oct'
  },
  {
    'name': 'Ashwaqq',
    'img': 'https://picsum.photos/250?image=9',
    'comment': 'i like it ... nice ',
    'type': 2,
    'time': '2 sept'
  },
  {
    'name': 'Osama',
    'img': 'https://picsum.photos/250?image=9',
    'comment': '_NotifiPageState extends State<NotifiPage>',
    'type': 1,
    'time': '2 sept'
  },
  {
    'name': 'Roqiah',
    'img': 'https://picsum.photos/250?image=9',
    'comment': '_NotifiPageState extends State<NotifiPage>',
    'type': 1,
    'time': "2 sept"
  },
  {
    'name': 'Ashwaq',
    'img': 'https://picsum.photos/250?image=9',
    'comment': 'i like it ... nice ',
    'type': 2,
    'time': '2 dec'
  },
  {
    'name': 'Osama',
    'img': 'https://picsum.photos/250?image=9',
    'comment': '_NotifiPageState extends State<NotifiPage>',
    'type': 1,
    'time': '2 sept'
  },
  {
    'name': 'Roqiah',
    'img': 'https://picsum.photos/250?image=9',
    'comment': 'how much for doing someing like  this this this ',
    'type': 2,
    'time': '2 sept'
  },
  {
    'name': 'Ashwaqqqq',
    'img': 'https://picsum.photos/250?image=9',
    'comment': '_NotifiPageState extends State<NotifiPage>',
    'type': 1,
    'time': '2 sept'
  }
];

class _NotifiPageState extends State<NotifiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("الاشعارات"),
      ),
      body: Container(
          color: Colors.white,
          child: ListView.builder(
              itemCount: mynotifi2.length,
              itemBuilder: (context, i) {
                int k = i;
                return Slidable(
                  startActionPane: ActionPane(
                    //key: const ValueKey(),
                    // A motion is a widget used to control how the pane animates.
                    motion: const ScrollMotion(),

                    // A pane can dismiss the Slidable.
                    //dismissible: DismissiblePane(onDismissed: () {}),

                    // All actions are defined in the children parameter.
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        onPressed: del(),
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        child: ListTile(
                          leading: InkWell(
                            child: Container(
                              width: 50,
                              height: 50,
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: '${mynotifi2[i]['img']}',
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                              /*decoration: BoxDecoration(
                                      image: DecorationImage(
                                      
                                          image: /* AssetImage(
                                            "images/${mynotifi[i]['img']}",
                                          )*/
                                              NetworkImage(
                                                  '${mynotifi2[i]['img']}'),
                                          fit: BoxFit.cover),
                                      border: Border.all(
                                          color: Color(0xFF262A4C),
                                          width: 2,
                                          style: BorderStyle.solid),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(70)))*/
                            ),
                            onTap: () {
                              print("pic");
                            },
                          ),
                          title: InkWell(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "${mynotifi2[i]['name']}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF262A4C),
                                      ),
                                    ),
                                    mynotifi2[i]['type'] == 1
                                        ? likeWidget()
                                        : commentWidget()
                                  ],
                                ),
                                if (mynotifi2[i]['type'] != 1)
                                  Column(
                                    children: [
                                      const SizedBox(
                                        height: 3,
                                      ),
                                      Text("${mynotifi2[i]['comment']}"),
                                      const SizedBox(
                                        height: 3,
                                      ),
                                    ],
                                  )
                              ],
                            ),
                            onTap: () {
                              print("roro");
                            },
                          ),
                          subtitle: Text("${mynotifi2[i]['time']}"),
                          trailing: mynotifi2[i]['type'] == 1
                              ? const Icon(
                                  Icons.favorite,
                                  color: Color(0xFF262A4C),
                                )
                              : const Icon(Icons.comment,
                                  color: Color(0xFF262A4C)),
                        ),
                      ),
                    ],
                  ),
                );
              })),
    );
  }
}

del() {
  print("deleteeeeee");
}

class commentWidget extends StatelessWidget {
  const commentWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(" comented your post ",
        style: TextStyle(fontSize: 15, color: Colors.grey));
  }
}

class likeWidget extends StatelessWidget {
  const likeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      " liked your post",
      style: TextStyle(fontSize: 15, color: Colors.grey),
    );
  }
}
