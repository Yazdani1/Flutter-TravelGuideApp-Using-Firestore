import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class London extends StatefulWidget {
  @override
  _LondonState createState() => new _LondonState();
}

class _LondonState extends State<London> {

  Future getTouristActivities() async {
    var firestore = Firestore.instance;
    QuerySnapshot snapshot = await firestore.collection("ToursActivities")
        .getDocuments();
    return snapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //first container
            Container(
              margin: EdgeInsets.only(top: 40.0, left: 10.0),
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Icon(Icons.arrow_back, size: 30.0,),
                    onTap: () {
                      Navigator.of(context).push(_createRoute(context));
                    },
                  ),
                  SizedBox(width: 10.0,),
                  Text("London", style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            //end first container
            //Second container
            Container(
              height: 105.0,
              margin: EdgeInsets.only(left: 10.0, top: 15.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  //first container
                  Container(
                    height: 100.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0XFFE84342),
                    ),
                    child: Column(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 12.0),
                          child: Center(
                              child: Icon(Icons.restaurant, size: 40.0,
                                color: Colors.white,)),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 9.0),
                          child: Text("Eat", style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white
                          ),),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  //Second container
                  Container(
                    height: 100.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0XFF596157),
                    ),
                    child: Column(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(top: 12.0),
                          child: Center(
                              child: Icon(Icons.card_travel, size: 40.0,
                                color: Colors.white,)),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: 9.0),
                          child: Text("See", style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white
                          ),),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  //Third container
                  Container(
                    height: 100.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0XFF162447),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 12.0),
                          child: Center(
                              child: Icon(
                                Icons.hotel, size: 40.0, color: Colors.white,)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 9.0),
                          child: Text("Sleep", style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white
                          ),),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  //Fourth container
                  Container(
                    height: 100.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Color(0XFF5d13e7),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 12.0),
                          child: Center(
                              child: Icon(
                                Icons.shop, size: 40.0, color: Colors.white,)),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 9.0),
                          child: Text("Shop", style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.white
                          ),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //end of second container

            //Third container
            Container(
              margin: EdgeInsets.only(top: 15.0),
              child: Column(
                children: <Widget>[

                  Container(
                    height: 50.0,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Tours & Activities",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0,),
                  Container(
                    height: 280.0,
                    child: getToursUI(context),
                  )

                ],
              ),
            )
            //end third container


          ],
        ),
      ),

    );
  }

  Route _createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Home(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        var begin = Offset(0.0, 1.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;

        //var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }

  Widget getToursUI(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getTouristActivities(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, index) {
                    var OurData = snapshot.data[index];
                    return Container(
                      height: 250.0,
                      width: 350.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image.network(OurData.data['img'],
                                height: 200.0,
                                width: 350.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 150.0,
                            left: 30.0,
                            bottom: 40.0,
                            child: Card(
                              elevation: 15.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                            ),
                          ),
                        ],
                      ),

                    );
                  }
              );
            }
          }
      ),
    );
  }


}




