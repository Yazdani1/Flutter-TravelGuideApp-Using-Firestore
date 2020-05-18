import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:flutter_ud_travel_guide/London.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {

  String img1 = "https://images.pexels.com/photos/3711348/pexels-photo-3711348.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  String img2 = "https://images.pexels.com/photos/2161467/pexels-photo-2161467.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  String img3 = "https://images.pexels.com/photos/3560362/pexels-photo-3560362.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  String img4 = "https://images.pexels.com/photos/235648/pexels-photo-235648.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  String img5 = "https://images.pexels.com/photos/1736222/pexels-photo-1736222.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  String img6 = "https://images.pexels.com/photos/1007657/pexels-photo-1007657.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";
  String img7 = "https://images.pexels.com/photos/2589011/pexels-photo-2589011.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";


  //Firestore Function

  Future getData() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("TopPlaces").getDocuments();
    return snap.documents;
  }

  //Refresh Indicator

  Future getRefresh() async {
    Future.delayed(Duration(seconds: 3));
    setState(() {
      getData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[

            //Carousol Container Start

            Container(
              height: 250.0,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,

              child: Carousel(
                images: [
                  NetworkImage(img1),
                  NetworkImage(img2),
                  NetworkImage(img3),
                  NetworkImage(img4)
                ],
                dotSize: 5.0,
                dotSpacing: 25.0,
                dotColor: Colors.lightGreenAccent,
                indicatorBgPadding: 10.0,
                //dotBgColor: Colors.purple.withOpacity(0.5),
                borderRadius: true,
              ),

            ),

            //End Carousol Container

            //Categories container Start
            Container(
              height: 200.0,
              margin: EdgeInsets.only(top: 10.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  InkWell(
                      child: city_Category(context, img3, "London"),
                    onTap: (){
                        Navigator.of(context).push(_createRoute(context));
                    },
                  ),
                  city_Category(context, img2, "Italy"),
                  city_Category(context, img5, "Germany"),
                  city_Category(context, img7, "Poland"),

                ],
              ),
            ),
            //Categories container End
            //Top Most Place Container Start
            Container(

              child: Column(
                children: <Widget>[
                  top_Places(context)
                ],
              ),
//              width: MediaQuery.of(context).size.width,
//              height: MediaQuery.of(context).size.height,
//              child: Column(
//                children: <Widget>[
//                  top_Places(context)
//                ],
//              ),
            )

            // Top Most Place Container End
          ],
        )
        ,

      )
      ,
    );
  }

  Widget city_Category(BuildContext context, String img, String name) {
    return Container(
      height: 200.0,
      margin: EdgeInsets.only(left: 10.0),
      child: Stack(
        children: <Widget>[

          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network(img,
                height: 200.0,
                width: 300.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 25.0,
            bottom: 20.0,
            top: 150.0,
            child: Text(name, style: TextStyle(
                fontSize: 30.0,
                color: Colors.white
            ),),
          ),


        ],
      ),

    );
  }

  Widget top_Places(BuildContext context) {
    return Container(
      height: 450.0,
      margin: EdgeInsets.all(10.0),
      child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return RefreshIndicator(
                onRefresh: getRefresh,
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      var ourData = snapshot.data[index];
                      return Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),

                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          ),

                          child: Column(
                            children: <Widget>[
                              //first container
                              Container(

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: <Widget>[

                                    Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      child: CircleAvatar(
                                        child: Text(ourData.data['name'][0]),
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),

                                    SizedBox(width: 5.0,),

                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[

                                                Container(
                                                  width: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width / 1.5,
                                                  child: Text(
                                                    ourData.data['name'],
                                                    style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(height: 5.0,),

                                                Text(ourData.data['days'],
                                                  style: TextStyle(
                                                      fontSize: 17.0,
                                                      color: Colors.deepOrange
                                                  ),)
                                              ],
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.only(
                                                right: 15.0),
                                            child: InkWell(
                                              onTap: () {
                                                bottom_Sheet(context,
                                                    ourData.data['name'],
                                                    ourData.data['days'],
                                                    ourData.data['img'],
                                                    ourData.data['des']
                                                );
                                              },
                                              child: Icon(
                                                Icons.more_horiz, size: 30.0,),
                                            ),
                                          )
                                        ],
                                      ),
                                    )

                                  ],
                                ),
                              ),
                              //end first container
                              //second container
                              Container(
                                margin: EdgeInsets.only(top: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20.0),
                                  child: Image.network(ourData.data['img'],
                                    height: 250.0,
                                    fit: BoxFit.cover,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                  ),
                                ),
                              ),
                              //end of second container
                              //third container
                              Container(
                                padding: EdgeInsets.all(10.0),
                                child: Text(ourData.data['des'],
                                  maxLines: 3,
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black
                                  ),

                                ),
                              ),
                              //end of third container


                            ],
                          ),
                        ),
                      );
                    }
                ),
              );
            }
          }
      ),
    );
  }

  Widget bottom_Sheet(BuildContext context, String name, String days,
      String img, String des) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            height: 700.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(

                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)
                  )
                ),
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  elevation: 10.0,
                  child: Column(
                    children: <Widget>[

                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            
                            Container(
                              child: CircleAvatar(
                                child: Text(name[0],
                                style: TextStyle(
                                  fontSize: 20.0
                                ),
                                ),
                                backgroundColor: Colors.deepOrange,
                                maxRadius: 25.0,

                              ),
                            ),

                            SizedBox(width: 10.0,),

                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Container(
                                    child: Text(name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black87
                                    ),
                                    ),
                                  ),
                                  SizedBox(height: 5.0,),
                                  Container(
                                    child: Text(days,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.amber,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  )

                                ],
                              ),
                            )

                            
                          ],
                        ),
                      ),

                      SizedBox(height: 6.0,),

                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(img,
                          height: 250.0,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),

                      SizedBox(height: 10.0,),

                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(des,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black87
                          ),
                          ),
                        ),
                      )





                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }


  Route _createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => London(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
//        var begin = Offset(0.0, 1.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;

        //var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1,0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }


}



