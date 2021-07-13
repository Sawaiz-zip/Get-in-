import 'package:flutter/material.dart';
class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Column(
            children: [
              Container(
                height: 371,
                decoration: new BoxDecoration(
                    color: Color(0xffD22129),

                    borderRadius: new BorderRadius.only(
                        bottomLeft:  const  Radius.circular(80.0),
                        bottomRight: const  Radius.circular(80.0))
                ),

              )
            ],
          ),
       Text('Get in!')
        ]
      ),
    );
  }
}
