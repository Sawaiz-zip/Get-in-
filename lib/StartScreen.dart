import 'package:flutter/material.dart';
import 'package:get_in/Google_maps.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Container(
              height: 371,
              decoration: new BoxDecoration(
                  color: Color(0xffD22129),
                  borderRadius: new BorderRadius.only(
                      bottomLeft: const Radius.circular(80.0),
                      bottomRight: const Radius.circular(80.0))),
            )
          ],
        ),
        Positioned(
          top: 40,
          left: 125,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Get in!',
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          height: 400,
          right: 40,
          child: Container(
            padding: EdgeInsets.all(40),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image_asset/car1.png'),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          left: 20,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      child: ConstrainedBox(
                          constraints: BoxConstraints.tightForFinite(),
                          child: FlatButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset('image_asset/Maptile.png')))),
                  Container(
                      child: ConstrainedBox(
                          constraints: BoxConstraints.tightForFinite(),
                          child: FlatButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset('image_asset/Maptile.png'))))
                ],
              ),
              Row(
                children: [
                  Container(
                      child: ConstrainedBox(
                          constraints: BoxConstraints.tightForFinite(),
                          child: FlatButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset('image_asset/Maptile.png')))),
                  Container(
                      child: ConstrainedBox(
                          constraints: BoxConstraints.tightForFinite(),
                          child: FlatButton(
                              onPressed: () {},
                              padding: EdgeInsets.all(0.0),
                              child: Image.asset('image_asset/Maptile.png'))))
                ],
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'Google_Maps');
                },
                child: Text('Where to?'),
                color: Color(0xffD22129),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
