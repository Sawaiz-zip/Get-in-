import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_in/main.dart';

class Firebase_Messaging extends StatefulWidget {
  const Firebase_Messaging({Key key}) : super(key: key);

  @override
  _Firebase_MessagingState createState() => _Firebase_MessagingState();
}

class _Firebase_MessagingState extends State<Firebase_Messaging> {
  String notification_title;
  String notification_body;
  bool show=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  List<String> message_title=message_Title;
    List<String> message_body=message_Body;
if(message_title.isEmpty)
  {
    setState(() {
      show=false;

    });
    }
else
  {
    setState(() {
      show=true;
    });
  }

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          width: double.infinity,
          height: 80,
          padding: EdgeInsets.all(10),
          color: Colors.red,
          child: Center(
              child: Text(
            'Notifications',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          )),
        ),
      show==true?

         Container(
            child: new ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: message_Title.length,
                itemBuilder: (BuildContext context, int index) {
                 print('message lenght ${message_Title.length}');

                  return SingleChildScrollView(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: new Card(
                          clipBehavior: Clip.antiAlias,
                          elevation: 16,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 50, right: 50, top: 20, bottom: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message_Title[index],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                      Text(message_Body[index]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  );
                })):
      Center(child: Padding(
        padding: const EdgeInsets.only(top:100.0),
        child: Container(child: Text('No Notifications',style: TextStyle(fontSize: 20),)),
      )),
      ]),
    );
  }
}
