
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_in/EnterMobileNumber.dart';
import 'package:get_in/StartScreen.dart';

import 'models/Driver.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

      return Scaffold(

        body: Stack(
          //alignment: Alignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                height: _size.height,
                width: _size.width,
                color: Colors.white,
                child: Stack(fit: StackFit.loose, children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 167),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 149.90750122070312,
                              width: 136.6512451171875,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                  scale: 1,
                                  image: AssetImage('image_asset/Vector.jpg'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Get in!',
                                style: TextStyle(
                                    fontSize: 35,
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 400),

                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.only(left: 36, right: 36),
                              child: RaisedButton(
                                color: Colors.red.shade700,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, 'EnterMobileNumber');
                                },
                                child: Padding(
                                  padding:
                                  const EdgeInsets.only(
                                      left: 50.0, right: 50.0),
                                  child: Text(
                                    'Continue with Mobile Number',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 570),
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 40.0, right: 10.0),
                                child: Divider(
                                  color: Colors.black,
                                  height: 10,
                                )),
                          ),
                          Text(
                            'Or continue with',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3e4958),
                            ),
                          ),
                          Expanded(
                            child: new Container(
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 40.0),
                                child: Divider(
                                  color: Colors.black,
                                  height: 36,
                                )),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                //  padding: EdgeInsets.only(left:30 ),
                                  icon:
                                  Icon(FontAwesomeIcons.apple, size: 50,),

                                  onPressed: () {
                                    print('hello');
                                  }),
                              IconButton(
                                // padding: EdgeInsets.all(3),
                                  icon:
                                  Icon(FontAwesomeIcons.facebook, size: 50,
                                      color: Color(0xff3B5998)
                                  ),

                                  onPressed: () {
                                    print('hello');
                                  }),

                              IconButton(
                                //  padding: EdgeInsets.only(right:30),
                                  icon:
                                  Icon(FontAwesomeIcons.google, size: 50),

                                  onPressed: () {
                                    print('hello');
                                  }),

                            ]),
                      ),
                    ]),
                  ),
                ]),
              ),
            ]),
      );

    }

  }
