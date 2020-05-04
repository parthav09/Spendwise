import 'package:flutter/material.dart';

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
          SizedBox(
            height: 80,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(children: <Widget>[
                    SizedBox(
                      height: 6,
                    ),
                    CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Image.asset(
                          'assets/images/Devlogo.jpeg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                      radius: 40,
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                  ]),
                  Text(
                    "</> by️\nParthav Joshi",
                    style:
                    Theme.of(context).appBarTheme.textTheme.title,
                  )
                ],
              ),
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
                    style:
                    TextStyle(fontFamily: 'OpenSans', fontSize: 12),
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
