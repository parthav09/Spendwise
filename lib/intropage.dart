import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About the Developer"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFF0EFF4)),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/Devlogo.jpeg'),
                          ),
                        ),
                      ),
                    ],
                    overflow: Overflow.clip,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Developed by',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Parthav Joshi',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(EvaIcons.github,),
                        onPressed: (){},
                      ),
                      IconButton(
                        icon: Icon(EvaIcons.twitter),
                        onPressed: (){},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.all(10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "\n Feedback",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(),
                  ],
                ),
                Container(
                  child: Text(
                    "Bugs Found!! \nFeature Suggestions??\nCreate a new issue on GitHub to let me know, or contibute by forking and sending a Personal Response",
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 12),
                  ),
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
